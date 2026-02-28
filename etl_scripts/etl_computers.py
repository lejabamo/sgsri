# etl_computadoras.py
import os
from datetime import datetime
import logging
import mysql.connector # Sigue siendo necesario para mysql.connector.Error

# Importar funciones desde etl_utils
from etl_utils import setup_logging, load_env_file, get_db_connection, get_user_id_by_email, get_script_dir

# Configurar logging (ahora se llama desde etl_utils)
setup_logging()

# --- Carga de Variables de Entorno ---
# GLPI
if load_env_file('glpi_credentials.env', "GLPI"):
    GLPI_DB_HOST = os.environ.get('GLPI_MYSQL_HOST')
    GLPI_DB_USER = os.environ.get('GLPI_MYSQL_USER')
    GLPI_DB_PASSWORD = os.environ.get('GLPI_MYSQL_PASSWORD')
    GLPI_DB_NAME = os.environ.get('GLPI_MYSQL_DB')
    GLPI_DB_PORT = os.environ.get('GLPI_MYSQL_PORT', '3306')
    GLPI_BASE_URL = os.environ.get('GLPI_BASE_URL', 'http://172.19.0.214/glpi')
    
    # Debug logging para GLPI
    logging.info("Configuración GLPI cargada:")
    logging.info(f"Host: {GLPI_DB_HOST}")
    logging.info(f"User: {GLPI_DB_USER}")
    logging.info(f"Database: {GLPI_DB_NAME}")
    logging.info(f"Port: {GLPI_DB_PORT}")
else:
    logging.error("No se pudo cargar la configuración de GLPI. Saliendo.")
    exit()

# SGSI
if load_env_file('sgsi_credentials.env', "SGSI"):
    SGSI_DB_HOST = os.environ.get('SGSI_MYSQL_HOST')
    SGSI_DB_USER = os.environ.get('SGSI_MYSQL_USER')
    SGSI_DB_PASSWORD = os.environ.get('SGSI_MYSQL_PASSWORD')
    SGSI_DB_NAME = os.environ.get('SGSI_MYSQL_DB')
    SGSI_DB_PORT = os.environ.get('SGSI_MYSQL_PORT', '3306')
    
    # Debug logging para SGSI
    logging.info("Configuración SGSI cargada:")
    logging.info(f"Host: {SGSI_DB_HOST}")
    logging.info(f"User: {SGSI_DB_USER}")
    logging.info(f"Database: {SGSI_DB_NAME}")
    logging.info(f"Port: {SGSI_DB_PORT}")
else:
    logging.error("No se pudo cargar la configuración de SGSI. Saliendo.")
    exit()

# --- Mapeos y Constantes de Transformación ---
GLPI_STATUS_TO_SGSI_STATUS = {
    # Las claves DEBEN estar en minúsculas para la comparación insensible a mayúsculas
    'en producción': 'En produccion',
    'en stock': 'En stock',
    'retirado': 'Retirado',
    'mantenimiento': 'En mantenimiento',
    'standby': 'En stock',
    'para eliminar': 'Retirado',
    'en uso': 'En produccion',
    # Validar con los datos de glpi_states.name
    # Ejemplo de tu caso: 'servicios informaticos' (debería ser un estado real de GLPI)
}
DEFAULT_SGSI_STATUS = 'Planificado'

MANUFACTURER_MAP = {
    # Las claves DEBEN estar en minúsculas
    'hp': 'HP',
    'hewlett-packard': 'HP',
    'hewlett packard': 'HP',
    'helvwrt pack': 'HP',
    'he pa': 'HP',
    'dell inc.': 'DELL',
    'dell': 'DELL',
    'lenovo': 'LENOVO',
    'microsoft corporation': 'MICROSOFT',
    'apple inc.': 'APPLE',
    'apple': 'APPLE',
    'vmware, inc.': 'VMWARE',
    'vmware': 'VMWARE',
    'toshiba': 'TOSHIBA',
    'asus': 'ASUS',
    'insyde': 'INSYDE', # Puede ser BIOS/Firmware, no un fabricante de equipo
    'samsung': 'SAMSUNG',
    # Agrega más mapeos aquí
}
DEFAULT_MANUFACTURER_HANDLING = 'UPPERCASE' # O 'ORIGINAL' si prefieres no modificar si no hay mapeo

# --- Funciones ETL ---

def extract_glpi_computers(glpi_conn):
    if not glpi_conn:
        return []
    
    try:
        # Usar ruta absoluta para el archivo SQL
        script_dir = get_script_dir()
        sql_file_path = os.path.join(script_dir, 'extract_computers.sql')
        with open(sql_file_path, 'r', encoding='utf-8') as f:
            sql_query = f.read()
    except FileNotFoundError:
        logging.error(f"Error: El archivo 'extract_computers.sql' no fue encontrado en {script_dir}.")
        return []
    except Exception as e:
        logging.error(f"Error al leer 'extract_computers.sql': {e}")
        return []

    computers_data = []
    try:
        cursor = glpi_conn.cursor(dictionary=True)
        cursor.execute(sql_query)
        computers_data = cursor.fetchall()
        logging.info(f"Se extrajeron {len(computers_data)} computadoras de GLPI.")
    except mysql.connector.Error as err:
        logging.error(f"Error durante la extracción de datos de GLPI: {err}")
    finally:
        if cursor:
            cursor.close()
    return computers_data

def transform_computer_data(computer_row, sgsi_cursor):
    try:
        id_propietario = get_user_id_by_email(computer_row.get('raw_usuario_principal_email'), sgsi_cursor)
        id_custodio = get_user_id_by_email(computer_row.get('raw_usuario_tecnico_email'), sgsi_cursor)

        estado_glpi_raw = computer_row.get('raw_estado_glpi_nombre')
        estado_activo_sgsi = DEFAULT_SGSI_STATUS
        if estado_glpi_raw:
            estado_activo_sgsi = GLPI_STATUS_TO_SGSI_STATUS.get(estado_glpi_raw.lower(), DEFAULT_SGSI_STATUS)
            if estado_glpi_raw.lower() not in GLPI_STATUS_TO_SGSI_STATUS and estado_glpi_raw:
                logging.warning(f"Estado GLPI '{estado_glpi_raw}' no mapeado para '{computer_row.get('raw_nombre_activo')}'. Usando por defecto: '{DEFAULT_SGSI_STATUS}'.")

        ram_gb = None
        raw_ram_mb = computer_row.get('raw_ram_total_mb')
        if raw_ram_mb:
            try:
                ram_gb = int(float(raw_ram_mb)) // 1024
            except (ValueError, TypeError):
                logging.warning(f"Valor de RAM no válido '{raw_ram_mb}' para '{computer_row.get('raw_nombre_activo')}'. Se dejará como NULL.")
                
        almacenamiento_gb = None
        raw_disco_value_as_mb = computer_row.get('raw_disco_total_gb') 
        if raw_disco_value_as_mb:
            try:
                almacenamiento_gb = int(float(raw_disco_value_as_mb)) // 1024
            except (ValueError, TypeError):
                logging.warning(f"Valor de Disco (considerado MB) no válido '{raw_disco_value_as_mb}' para '{computer_row.get('raw_nombre_activo')}'. Se dejará como NULL.")

        raw_fabricante = computer_row.get('raw_fabricante_nombre')
        fabricante_sgsi = None
        if raw_fabricante:
            fabricante_sgsi = MANUFACTURER_MAP.get(raw_fabricante.lower(), 
                                                 raw_fabricante.upper() if DEFAULT_MANUFACTURER_HANDLING == 'UPPERCASE' else raw_fabricante)
        
        nombre_activo_sgsi = computer_row.get('raw_nombre_activo').upper() if computer_row.get('raw_nombre_activo') else None
        modelo_sgsi = computer_row.get('raw_modelo_nombre').upper() if computer_row.get('raw_modelo_nombre') else None
        tipo_computadora_sgsi = computer_row.get('raw_tipo_computadora_nombre').upper() if computer_row.get('raw_tipo_computadora_nombre') else None
        sistema_operativo_sgsi = computer_row.get('raw_sistema_operativo_nombre').upper() if computer_row.get('raw_sistema_operativo_nombre') else None

        fecha_adquisicion = computer_row.get('raw_fecha_creacion_glpi')

        activo_data = {
            'Nombre': nombre_activo_sgsi,
            'Descripcion': computer_row.get('raw_comentario'),
            'Tipo_Activo': 'Hardware',
            'subtipo_activo': tipo_computadora_sgsi,
            'ID_Propietario': id_propietario,
            'ID_Custodio': id_custodio,
            'estado_activo': estado_activo_sgsi,
            'fuente_datos_principal': 'GLPI_Importado',
            'id_externo_glpi': computer_row.get('raw_glpi_id'),
            'fecha_adquisicion': fecha_adquisicion,
            'fecha_ultima_actualizacion_sgsi': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }

        detalle_tecnologico_data = {
            'numero_serie': computer_row.get('raw_numero_serie').upper() if computer_row.get('raw_numero_serie') else None,
            'modelo': modelo_sgsi,
            'fabricante': fabricante_sgsi,
            'tipo_glpi_raw': tipo_computadora_sgsi,
            'sistema_operativo': sistema_operativo_sgsi,
            'version_so': computer_row.get('raw_sistema_operativo_version'),
            'direccion_ip_principal': computer_row.get('raw_ip_principal'),
            'direccion_mac_principal': computer_row.get('raw_mac_principal'),
            'ubicacion_fisica_tecnica': computer_row.get('raw_ubicacion_nombre_completo'),
            'glpi_url_referencia': f"{GLPI_BASE_URL}/front/computer.form.php?id={computer_row.get('raw_glpi_id')}",
            'fecha_sincronizacion_glpi': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            'memoria_ram_gb': ram_gb,
            'almacenamiento_gb': almacenamiento_gb,
        }
        return activo_data, detalle_tecnologico_data
    except Exception as e:
        logging.error(f"Error en transformación para GLPI ID {computer_row.get('raw_glpi_id')}: {str(e)}")
        logging.error(f"Datos del registro que falló: {computer_row}")
        return None, None

def load_computer_data(sgsi_conn, activo_data, detalle_tecnologico_data):
    if not sgsi_conn:
        return False, 0, 0
    
    cursor = None
    inserted_activos = 0
    updated_activos = 0

    try:
        cursor = sgsi_conn.cursor()
        activos_cols = [
            'Nombre', 'Descripcion', 'Tipo_Activo', 'subtipo_activo', 'ID_Propietario', 
            'ID_Custodio', 'estado_activo', 'fuente_datos_principal', 'id_externo_glpi', 
            'fecha_adquisicion', 'fecha_ultima_actualizacion_sgsi'
        ]
        activos_values = [activo_data.get(col) for col in activos_cols]
        
        activos_update_clause_parts = []
        for col in activos_cols:
            # No actualizamos la PK ni el id_externo_glpi en la cláusula UPDATE
            if col not in ['id_externo_glpi']: 
                 activos_update_clause_parts.append(f"{col}=VALUES({col})")
        activos_update_clause = ', '.join(activos_update_clause_parts)
        
        sql_activos = f"""
            INSERT INTO activos ({', '.join(activos_cols)})
            VALUES ({', '.join(['%s'] * len(activos_cols))})
            ON DUPLICATE KEY UPDATE {activos_update_clause}
        """
        cursor.execute(sql_activos, activos_values)
        
        id_activo = None
        # lastrowid es > 0 para un INSERT. rowcount es 1 para INSERT, 2 para UPDATE con cambios, 0/1 para UPDATE sin cambios
        if cursor.lastrowid and cursor.rowcount == 1: 
            id_activo = cursor.lastrowid
            inserted_activos +=1
            logging.debug(f"Activo INSERTADO con ID_Activo: {id_activo} (GLPI ID: {activo_data['id_externo_glpi']})")
        elif cursor.rowcount >= 1: # Podría ser 2 (update con cambio) o 1 (update sin cambio)
            cursor.execute("SELECT ID_Activo FROM activos WHERE id_externo_glpi = %s", (activo_data['id_externo_glpi'],))
            result = cursor.fetchone()
            if result:
                id_activo = result[0]
                if cursor.rowcount == 2: # Efectivamente hubo una actualización con cambios
                    updated_activos +=1
                    logging.debug(f"Activo ACTUALIZADO con ID_Activo: {id_activo} (GLPI ID: {activo_data['id_externo_glpi']})")
                else: # rowcount = 1, indica que la clave duplicada existía pero no hubo cambios netos.
                    logging.debug(f"Activo existente SIN CAMBIOS ID_Activo: {id_activo} (GLPI ID: {activo_data['id_externo_glpi']})")
        
        if not id_activo:
            logging.error(f"No se pudo obtener ID_Activo para GLPI ID: {activo_data['id_externo_glpi']} después de operación en tabla 'activos'.")
            sgsi_conn.rollback()
            return False, 0, 0

        detalle_tecnologico_data['ID_Activo'] = id_activo
        detalles_cols = [
            'ID_Activo', 'numero_serie', 'modelo', 'fabricante', 'tipo_glpi_raw', 
            'sistema_operativo', 'version_so', 'direccion_ip_principal', 
            'direccion_mac_principal', 'ubicacion_fisica_tecnica', 
            'glpi_url_referencia', 'fecha_sincronizacion_glpi', 
            'memoria_ram_gb', 'almacenamiento_gb'
        ]
        detalles_values = [detalle_tecnologico_data.get(col) for col in detalles_cols]
        detalles_update_clause = ', '.join([f"{col}=VALUES({col})" for col in detalles_cols if col != 'ID_Activo'])

        sql_detalles = f"""
            INSERT INTO activos_detalles_tecnologicos ({', '.join(detalles_cols)})
            VALUES ({', '.join(['%s'] * len(detalles_cols))})
            ON DUPLICATE KEY UPDATE {detalles_update_clause}
        """
        cursor.execute(sql_detalles, detalles_values)
        # No podemos saber fácilmente si esta segunda operación fue insert o update sin otra consulta.
        
        sgsi_conn.commit()
        return True, inserted_activos, updated_activos

    except mysql.connector.Error as err:
        logging.error(f"Error al cargar datos en SGSI DB para GLPI ID {activo_data.get('id_externo_glpi')}: {err}")
        if sgsi_conn: sgsi_conn.rollback()
        return False, 0, 0
    finally:
        if cursor:
            cursor.close()

# --- Punto de Entrada Principal ---
if __name__ == '__main__':
    logging.info("Iniciando script ETL para GLPI Computadoras -> SGSI...")

    glpi_conn = get_db_connection(GLPI_DB_HOST, GLPI_DB_USER, GLPI_DB_PASSWORD, GLPI_DB_NAME, GLPI_DB_PORT, charset='utf8', collation='utf8_general_ci')
    sgsi_conn = get_db_connection(SGSI_DB_HOST, SGSI_DB_USER, SGSI_DB_PASSWORD, SGSI_DB_NAME, SGSI_DB_PORT)

    if not glpi_conn or not sgsi_conn:
        logging.error("No se pudieron establecer todas las conexiones a las bases de datos. Abortando.")
        if glpi_conn and glpi_conn.is_connected(): glpi_conn.close()
        if sgsi_conn and sgsi_conn.is_connected(): sgsi_conn.close()
        exit()

    extracted_computers = extract_glpi_computers(glpi_conn)
    
    total_processed = 0
    total_operations_successful = 0
    total_activos_inserted = 0
    total_activos_updated = 0
    failed_records = []

    if extracted_computers:
        sgsi_cursor_for_transform = None
        try:
            sgsi_cursor_for_transform = sgsi_conn.cursor()
            for computer_row in extracted_computers:
                total_processed += 1
                glpi_id = computer_row.get('raw_glpi_id')
                nombre = computer_row.get('raw_nombre_activo')
                logging.info(f"Procesando GLPI ID: {glpi_id} - Nombre: {nombre}")
                
                activo_transformed, detalle_transformed = transform_computer_data(computer_row, sgsi_cursor_for_transform)
                
                if activo_transformed is None or detalle_transformed is None:
                    failed_records.append({
                        'glpi_id': glpi_id,
                        'nombre': nombre,
                        'error': 'Error en transformación'
                    })
                    continue

                success, inserted, updated = load_computer_data(sgsi_conn, activo_transformed, detalle_transformed)
                if success:
                    total_operations_successful += 1
                    total_activos_inserted += inserted
                    total_activos_updated += updated
                else:
                    failed_records.append({
                        'glpi_id': glpi_id,
                        'nombre': nombre,
                        'error': 'Error en carga'
                    })
                    logging.error(f"Fallo al cargar/actualizar datos para GLPI ID: {glpi_id}")
        
        finally:
            if sgsi_cursor_for_transform:
                sgsi_cursor_for_transform.close()

    logging.info("--- Resumen del Proceso ETL ---")
    logging.info(f"Total de registros GLPI procesados: {total_processed}")
    logging.info(f"Total de activos procesados exitosamente (insert/update en ambas tablas): {total_operations_successful}")
    logging.info(f"Detalle tabla 'activos' -> Insertados: {total_activos_inserted}, Actualizados con cambios: {total_activos_updated}")
    
    if failed_records:
        logging.warning("--- Registros que fallaron ---")
        for record in failed_records:
            logging.warning(f"GLPI ID: {record['glpi_id']}, Nombre: {record['nombre']}, Error: {record['error']}")
    
    failed_operations = total_processed - total_operations_successful
    if failed_operations > 0:
        logging.warning(f"Número de activos con fallos durante la carga/actualización: {failed_operations}")

    if glpi_conn and glpi_conn.is_connected():
        glpi_conn.close()
        logging.info("Conexión a GLPI cerrada.")
    if sgsi_conn and sgsi_conn.is_connected():
        sgsi_conn.close()
        logging.info("Conexión a SGSI DB cerrada.")
    
    logging.info("Script ETL de Computadoras finalizado.")