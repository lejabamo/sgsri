# etl_usuarios.py
import os
from datetime import datetime
import logging
import mysql.connector
import hashlib

# Importar funciones desde etl_utils
from etl_utils import setup_logging, load_env_file, get_db_connection

# Configurar logging
setup_logging()

# --- Carga de Variables de Entorno ---
# GLPI
if load_env_file('glpi_credentials.env', "GLPI"):
    GLPI_DB_HOST = os.environ.get('GLPI_MYSQL_HOST')
    GLPI_DB_USER = os.environ.get('GLPI_MYSQL_USER')
    GLPI_DB_PASSWORD = os.environ.get('GLPI_MYSQL_PASSWORD')
    GLPI_DB_NAME = os.environ.get('GLPI_MYSQL_DB')
    GLPI_DB_PORT = os.environ.get('GLPI_MYSQL_PORT', '3306')
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
else:
    logging.error("No se pudo cargar la configuración de SGSI. Saliendo.")
    exit()

# --- Constantes de Transformación ---
DEFAULT_PASSWORD = "cambiar123"  # Password temporal por defecto
DEFAULT_PUESTO = "Usuario del Sistema"  # Puesto por defecto

# --- Funciones ETL para Usuarios ---

def get_glpi_users_sql_query():
    """
    Retorna la consulta SQL para extraer usuarios de GLPI.
    Se usa la consulta que filtra por equipo y usuario asignado,
    asegurando que traemos los campos necesarios.
    """
    return """
    SELECT 
        u.id AS raw_glpi_user_id,
        u.name AS raw_username,
        u.realname AS raw_lastname,    -- Asumiendo 'realname' es apellido
        u.firstname AS raw_firstname,
        ue.email AS raw_email,
        u.phone AS raw_phone,
        u.mobile AS raw_mobile,
        u.is_active AS raw_is_active,
        u.comment AS raw_comment -- Ejemplo, si quieres migrar comentarios o notas
    FROM 
        db_glpi.glpi_users u
    LEFT JOIN 
        db_glpi.glpi_useremails ue ON ue.users_id = u.id AND ue.is_default = 1
    WHERE u.is_deleted = 0; -- Opcional: excluir usuarios eliminados lógicamente en GLPI
    """
    # Podrías guardar esto en un Extract_Users.sql si prefieres

def extract_glpi_users(glpi_conn):
    """Extrae datos de usuarios de GLPI usando extract_users.sql."""
    if not glpi_conn:
        return []
    
    # Leer la consulta SQL desde extract_users.sql
    try:
        script_dir = os.path.dirname(os.path.abspath(__file__))
        sql_file_path = os.path.join(script_dir, 'extract_users.sql')
        with open(sql_file_path, 'r', encoding='utf-8') as f:
            sql_query = f.read()
    except FileNotFoundError:
        logging.error(f"Error: El archivo 'extract_users.sql' no fue encontrado en {script_dir}.")
        return []
    except Exception as e:
        logging.error(f"Error al leer 'extract_users.sql': {e}")
        return []

    users_data = []
    cursor = None
    try:
        cursor = glpi_conn.cursor(dictionary=True)
        cursor.execute(sql_query)
        users_data = cursor.fetchall()
        logging.info(f"Se extrajeron {len(users_data)} usuarios de GLPI.")
    except mysql.connector.Error as err:
        logging.error(f"Error durante la extracción de datos de usuarios de GLPI: {err}")
    finally:
        if cursor:
            cursor.close()
    return users_data

def transform_user_data(glpi_user_row):
    """Transforma un registro de usuario de GLPI al formato de la tabla usuarios_sistema en SGSI."""
    
    # Nombre completo
    firstname = glpi_user_row.get('raw_firstname', '') or ''
    lastname = glpi_user_row.get('raw_lastname', '') or ''
    nombre_completo = f"{firstname} {lastname}".strip()
    if not nombre_completo: # Si ambos son None o vacíos, usar el username
        nombre_completo = glpi_user_row.get('raw_username')

    # Estado del usuario
    estado_usuario_sgsi = 'Activo' if glpi_user_row.get('raw_is_active') == 1 else 'Inactivo'

    # Generar hash del password por defecto
    password_hash = hashlib.sha256(DEFAULT_PASSWORD.encode()).hexdigest()

    # Email institucional (asignar valor único por defecto si no existe)
    email_institucional = glpi_user_row.get('raw_email')
    if not email_institucional or email_institucional.strip() == '':
        user_id = glpi_user_row.get('raw_glpi_user_id')
        email_institucional = f'sin_email_{user_id}@institucion.local'

    # Datos para la tabla usuarios_sistema
    sgsi_user_data = {
        'nombre_completo': nombre_completo,
        'email_institucional': email_institucional,
        'password_hash': password_hash,
        'puesto_organizacion': DEFAULT_PUESTO,
        'estado_usuario': estado_usuario_sgsi,
        # Los siguientes campos se manejan por defecto en la BD:
        # fecha_creacion_registro: DEFAULT CURRENT_TIMESTAMP
        # fecha_ultima_actualizacion: DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        # fecha_ultimo_login: NULL por defecto
        # intentos_fallidos_login: DEFAULT 0
        # requiere_cambio_password: DEFAULT 1
    }
    
    # Validación simple: nombre_completo es importante para SGSI
    if not sgsi_user_data['nombre_completo']:
        logging.warning(f"Usuario GLPI ID {glpi_user_row.get('raw_glpi_user_id')} no tiene nombre completo. Se omitirá.")
        return None

    return sgsi_user_data

def load_users_to_sgsi(sgsi_conn, sgsi_user_data):
    """Carga o actualiza un usuario en la tabla usuarios_sistema de SGSI."""
    if not sgsi_conn or not sgsi_user_data:
        return False
    
    cursor = None
    try:
        cursor = sgsi_conn.cursor()
        
        # Columnas en la tabla usuarios_sistema (excluyendo id_usuario que es auto_increment)
        cols = [
            'nombre_completo', 'email_institucional', 'password_hash', 
            'puesto_organizacion', 'estado_usuario'
            # Los demás campos se manejan por defecto en la BD
        ]
        
        values = [sgsi_user_data.get(col) for col in cols]
        
        # Para ON DUPLICATE KEY UPDATE, actualizamos todos los campos excepto email_institucional
        # ya que es UNIQUE y es la clave para la duplicidad
        update_clause_parts = []
        for col in cols:
            if col not in ['email_institucional']: # email_institucional es la clave para la duplicidad
                update_clause_parts.append(f"{col}=VALUES({col})")
        update_clause = ', '.join(update_clause_parts)

        sql_upsert = f"""
            INSERT INTO usuarios_sistema ({', '.join(cols)})
            VALUES ({', '.join(['%s'] * len(cols))})
            ON DUPLICATE KEY UPDATE {update_clause}
        """
        
        cursor.execute(sql_upsert, values)
        sgsi_conn.commit()
        
        # Determinar si fue insert o update
        if cursor.lastrowid and cursor.rowcount == 1: # INSERT
            logging.debug(f"Usuario INSERTADO en SGSI: {sgsi_user_data['nombre_completo']} (Email: {sgsi_user_data['email_institucional']})")
            return "inserted"
        elif cursor.rowcount >= 1: # UPDATE (1 si no hubo cambios, 2 si hubo cambios)
            logging.debug(f"Usuario ACTUALIZADO/SIN CAMBIOS en SGSI: {sgsi_user_data['nombre_completo']} (Email: {sgsi_user_data['email_institucional']})")
            return "updated"
        else: # No debería ocurrir con ON DUPLICATE KEY UPDATE si la clave existe o se inserta
            logging.warning(f"Operación no determinada para usuario SGSI: {sgsi_user_data['nombre_completo']} (Email: {sgsi_user_data['email_institucional']})")
            return "unknown"

    except mysql.connector.Error as err:
        logging.error(f"Error al cargar usuario {sgsi_user_data.get('nombre_completo')} en SGSI: {err}")
        if sgsi_conn: sgsi_conn.rollback()
        return "error"
    finally:
        if cursor:
            cursor.close()

# --- Punto de Entrada Principal ---
if __name__ == '__main__':
    logging.info("Iniciando script ETL para GLPI Usuarios -> SGSI...")

    glpi_conn = get_db_connection(GLPI_DB_HOST, GLPI_DB_USER, GLPI_DB_PASSWORD, GLPI_DB_NAME, GLPI_DB_PORT)
    sgsi_conn = get_db_connection(SGSI_DB_HOST, SGSI_DB_USER, SGSI_DB_PASSWORD, SGSI_DB_NAME, SGSI_DB_PORT)

    if not glpi_conn or not sgsi_conn:
        logging.error("No se pudieron establecer todas las conexiones a las bases de datos. Abortando.")
        if glpi_conn and glpi_conn.is_connected(): glpi_conn.close()
        if sgsi_conn and sgsi_conn.is_connected(): sgsi_conn.close()
        exit()

    extracted_glpi_users = extract_glpi_users(glpi_conn)
    
    total_processed = 0
    total_inserted = 0
    total_updated = 0
    total_errors = 0

    if extracted_glpi_users:
        for glpi_user_row in extracted_glpi_users:
            total_processed += 1
            logging.info(f"Procesando usuario GLPI ID: {glpi_user_row.get('raw_glpi_user_id')} - Username: {glpi_user_row.get('raw_username')}")
            
            transformed_data = transform_user_data(glpi_user_row)
            
            if transformed_data:
                result_status = load_users_to_sgsi(sgsi_conn, transformed_data)
                if result_status == "inserted":
                    total_inserted += 1
                elif result_status == "updated":
                    total_updated +=1
                elif result_status == "error":
                    total_errors +=1
            else:
                logging.warning(f"Usuario GLPI ID: {glpi_user_row.get('raw_glpi_user_id')} omitido debido a transformación fallida o datos insuficientes.")
                total_errors +=1 # Contar como error si la transformación devuelve None

    logging.info("--- Resumen del Proceso ETL de Usuarios ---")
    logging.info(f"Total de usuarios GLPI procesados: {total_processed}")
    logging.info(f"Total de usuarios insertados en SGSI: {total_inserted}")
    logging.info(f"Total de usuarios actualizados/sin cambios en SGSI: {total_updated}")
    logging.info(f"Total de errores/omisiones: {total_errors}")

    if glpi_conn and glpi_conn.is_connected():
        glpi_conn.close()
        logging.info("Conexión a GLPI cerrada.")
    if sgsi_conn and sgsi_conn.is_connected():
        sgsi_conn.close()
        logging.info("Conexión a SGSI DB cerrada.")
    
    logging.info("Script ETL de Usuarios finalizado.")