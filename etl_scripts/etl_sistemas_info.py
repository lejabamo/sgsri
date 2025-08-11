import os
import pandas as pd
import logging
import mysql.connector
from etl_utils import setup_logging, load_env_file, get_db_connection

# Configuración de logging
setup_logging()

# Ruta del archivo CSV
CSV_PATH = r'C:\Users\jefes\OneDrive\Desktop\SISE 2025\Seguridad/InventarioSistemaSedcau.csv'
# Nombre de la tabla destino
TABLE_NAME = 'activos_detalles_sistemas_informacion'

# Mapeo de columnas Excel -> Tabla SGSRI
EXCEL_TO_DB = {
    'Item': 'item',
    'NombreOficina': 'nombre_oficina',
    'Sigla': 'sigla',
    'NombreSistema': 'nombre_sistema',
    'TipoSistema': 'tipo_sistema',
    'FuncionalidadPrincipal': 'funcionalidad_principal',
    'UsuariosPrincipales': 'usuarios_principales',
    'SecretariaSistemaInformacion': 'secretaria_uso',
    'ContactoResponsable': 'contacto_responsable',
    'ProveedorDesarrollador': 'proveedor_externo_si_aplica',
    'Infraestructura': 'infraestructura_tecnologica',
    'IntegracionesSistemas': 'integraciones',
    'NivelCriticidad': 'nivel_criticidad'
}

# Cargar variables de entorno para SGSRI
if not load_env_file('sgsi_credentials.env', "SGSI"):
    logging.error("No se pudo cargar la configuración de SGSI. Saliendo.")
    exit(1)

SGSI_DB_HOST = os.environ.get('SGSI_MYSQL_HOST')
SGSI_DB_USER = os.environ.get('SGSI_MYSQL_USER')
SGSI_DB_PASSWORD = os.environ.get('SGSI_MYSQL_PASSWORD')
SGSI_DB_NAME = os.environ.get('SGSI_MYSQL_DB')
SGSI_DB_PORT = os.environ.get('SGSI_MYSQL_PORT', '3306')

# Leer CSV
try:
    df = pd.read_csv(CSV_PATH, encoding='latin1')
    df.columns = df.columns.str.strip()  # Limpia espacios en los encabezados
    logging.info(f"Columnas leídas del CSV: {df.columns.tolist()}")
except Exception as e:
    logging.error(f"Error leyendo el archivo CSV: {e}")
    exit(1)

# Obtener columnas de la tabla destino
conn = get_db_connection(SGSI_DB_HOST, SGSI_DB_USER, SGSI_DB_PASSWORD, SGSI_DB_NAME, SGSI_DB_PORT)
cursor = conn.cursor()
cursor.execute(f"DESCRIBE {TABLE_NAME}")
db_columns = [row[0] for row in cursor.fetchall()]

# Determinar columnas coincidentes y no coincidentes
excel_cols = set(EXCEL_TO_DB.keys())
db_cols = set(EXCEL_TO_DB.values())
missing_in_db = [col for col in excel_cols if EXCEL_TO_DB[col] not in db_columns]

# Si hay columnas en el Excel que no existen en la tabla, agregarlas automáticamente
if missing_in_db:
    logging.info(f"Columnas faltantes en la tabla: {missing_in_db}")
    for excel_col in missing_in_db:
        db_col = EXCEL_TO_DB[excel_col]
        alter_sql = f"ALTER TABLE {TABLE_NAME} ADD COLUMN `{db_col}` VARCHAR(255) NULL;"
        try:
            cursor.execute(alter_sql)
            conn.commit()
            logging.info(f"Columna agregada: {db_col}")
        except Exception as e:
            logging.error(f"Error agregando columna {db_col}: {e}")
else:
    logging.info("No hay columnas faltantes en la tabla.")

# Volver a obtener columnas de la tabla después de posibles alteraciones
cursor.execute(f"DESCRIBE {TABLE_NAME}")
db_columns = [row[0] for row in cursor.fetchall()]

# Filtrar solo columnas que existen en la tabla
valid_mappings = {k: v for k, v in EXCEL_TO_DB.items() if v in db_columns}

# Preparar datos para inserción
insert_rows = []
for _, row in df.iterrows():
    insert_row = {db_col: row[excel_col] for excel_col, db_col in valid_mappings.items()}
    insert_rows.append(insert_row)

logging.info(f"Filas leídas del Excel: {len(insert_rows)}")

# Insertar datos
inserted_count = 0
for row in insert_rows:
    cols = ', '.join(row.keys())
    placeholders = ', '.join(['%s'] * len(row))
    sql = f"INSERT INTO {TABLE_NAME} ({cols}) VALUES ({placeholders})"
    try:
        cursor.execute(sql, list(row.values()))
        conn.commit()
        inserted_count += 1
        logging.info(f"Insertado: {row}")
    except Exception as e:
        logging.error(f"Error insertando {row}: {e}")

logging.info(f"Filas insertadas correctamente: {inserted_count}")

cursor.close()
conn.close()

logging.info("Proceso ETL finalizado.") 