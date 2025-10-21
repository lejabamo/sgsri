import os
import logging
from datetime import datetime
import mysql.connector

from etl_utils import setup_logging, load_env_file, get_db_connection, get_script_dir

setup_logging()

# Load envs
if load_env_file('glpi_credentials.env', 'GLPI'):
    GLPI_DB_HOST = os.environ.get('GLPI_MYSQL_HOST')
    GLPI_DB_USER = os.environ.get('GLPI_MYSQL_USER')
    GLPI_DB_PASSWORD = os.environ.get('GLPI_MYSQL_PASSWORD')
    GLPI_DB_NAME = os.environ.get('GLPI_MYSQL_DB')
    GLPI_DB_PORT = os.environ.get('GLPI_MYSQL_PORT', '3306')
else:
    logging.error('No se pudo cargar GLPI credentials')
    raise SystemExit(1)

if load_env_file('sgsi_credentials.env', 'SGSI'):
    SGSI_DB_HOST = os.environ.get('SGSI_MYSQL_HOST')
    SGSI_DB_USER = os.environ.get('SGSI_MYSQL_USER')
    SGSI_DB_PASSWORD = os.environ.get('SGSI_MYSQL_PASSWORD')
    SGSI_DB_NAME = os.environ.get('SGSI_MYSQL_DB')
    SGSI_DB_PORT = os.environ.get('SGSI_MYSQL_PORT', '3306')
else:
    logging.error('No se pudo cargar SGSI credentials')
    raise SystemExit(1)


def extract_glpi_softwares(glpi_conn):
    try:
        script_dir = get_script_dir()
        sql_path = os.path.join(script_dir, 'extract_softwares.sql')
        with open(sql_path, 'r', encoding='utf-8') as f:
            sql = f.read()
    except Exception as e:
        logging.error(f"No se pudo leer extract_softwares.sql: {e}")
        return []

    try:
        cur = glpi_conn.cursor(dictionary=True)
        cur.execute(sql)
        rows = cur.fetchall()
        cur.close()
        logging.info(f"Se extrajeron {len(rows)} softwares de GLPI")
        return rows
    except mysql.connector.Error as err:
        logging.error(f"Error extrayendo softwares: {err}")
        return []


def transform_sw_row(row: dict) -> dict:
    nombre = (row.get('raw_sw_nombre') or '').upper() or None
    fabricante = (row.get('raw_fabricante') or '')
    fabricante = fabricante.upper() if fabricante else None
    categoria = (row.get('raw_categoria') or '')
    categoria = categoria.upper() if categoria else None
    return {
        'Nombre': nombre,
        'Fabricante': fabricante,
        'Categoria': categoria,
        'Es_Valido': int(row.get('raw_es_valido') or 1),
        'id_externo_glpi': row.get('raw_sw_id'),
        'fecha_ultima_actualizacion_sgsi': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
    }


def load_sw_to_sgsi(conn, sw: dict):
    cols = ['Nombre', 'Fabricante', 'Categoria', 'Es_Valido', 'id_externo_glpi', 'fecha_ultima_actualizacion_sgsi']
    vals = [sw.get(c) for c in cols]
    update = ', '.join([f"{c}=VALUES({c})" for c in cols if c != 'id_externo_glpi'])
    sql = f"""
        INSERT INTO software_catalogo ({', '.join(cols)})
        VALUES ({', '.join(['%s']*len(cols))})
        ON DUPLICATE KEY UPDATE {update}
    """
    cur = conn.cursor()
    cur.execute(sql, vals)
    conn.commit()
    cur.close()


def run():
    logging.info('Iniciando ETL de Softwares (catálogo)')
    # GLPI en este entorno requiere latin1
    glpi_conn = get_db_connection(GLPI_DB_HOST, GLPI_DB_USER, GLPI_DB_PASSWORD, GLPI_DB_NAME, GLPI_DB_PORT, charset='latin1', collation='latin1_swedish_ci')
    sgsi_conn = get_db_connection(SGSI_DB_HOST, SGSI_DB_USER, SGSI_DB_PASSWORD, SGSI_DB_NAME, SGSI_DB_PORT, charset='utf8mb4', collation='utf8mb4_unicode_ci')
    if not glpi_conn or not sgsi_conn:
        logging.error('Conexiones no disponibles')
        raise SystemExit(1)

    rows = extract_glpi_softwares(glpi_conn)
    count = 0
    for r in rows:
        sw = transform_sw_row(r)
        load_sw_to_sgsi(sgsi_conn, sw)
        count += 1
    logging.info(f"Softwares procesados: {count}")

    if glpi_conn.is_connected():
        glpi_conn.close()
    if sgsi_conn.is_connected():
        sgsi_conn.close()
    logging.info('ETL de Softwares finalizado')


if __name__ == '__main__':
    run()


