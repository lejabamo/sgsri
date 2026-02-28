import os
import logging
from datetime import datetime
import mysql.connector

from etl_utils import setup_logging, load_env_file, get_db_connection, get_script_dir

setup_logging()

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


def extract_computer_software(glpi_conn):
    try:
        sql_path = os.path.join(get_script_dir(), 'extract_computer_software.sql')
        with open(sql_path, 'r', encoding='utf-8') as f:
            sql = f.read()
    except Exception as e:
        logging.error(f'No se pudo leer extract_computer_software.sql: {e}')
        return []

    try:
        cur = glpi_conn.cursor(dictionary=True)
        cur.execute(sql)
        rows = cur.fetchall()
        cur.close()
        logging.info(f'Relaciones equipo-software extraídas: {len(rows)}')
        return rows
    except mysql.connector.Error as err:
        logging.error(f'Error extrayendo relaciones equipo-software: {err}')
        return []


def resolve_ids(conn, raw_computer_id, raw_sw_id):
    cur = conn.cursor()
    cur.execute('SELECT ID_Activo FROM activos WHERE id_externo_glpi = %s', (raw_computer_id,))
    r = cur.fetchone()
    id_activo = r[0] if r else None

    cur.execute('SELECT ID_Software FROM software_catalogo WHERE id_externo_glpi = %s', (raw_sw_id,))
    r2 = cur.fetchone()
    id_sw = r2[0] if r2 else None
    cur.close()
    return id_activo, id_sw


def upsert_activo_software(conn, id_activo, id_sw, version, raw_swver_id):
    cols = ['ID_Activo', 'ID_Software', 'Version', 'id_externo_glpi_isv', 'fecha_ultima_actualizacion_sgsi']
    vals = [id_activo, id_sw, version, raw_swver_id, datetime.now().strftime('%Y-%m-%d %H:%M:%S')]
    update = ', '.join([f"{c}=VALUES({c})" for c in cols if c not in ('ID_Activo', 'ID_Software', 'Version')])
    sql = f"""
        INSERT INTO activos_software ({', '.join(cols)})
        VALUES ({', '.join(['%s']*len(cols))})
        ON DUPLICATE KEY UPDATE {update}
    """
    cur = conn.cursor()
    cur.execute(sql, vals)
    conn.commit()
    cur.close()


def run():
    logging.info('Iniciando ETL relación Activo-Software')
    glpi_conn = get_db_connection(GLPI_DB_HOST, GLPI_DB_USER, GLPI_DB_PASSWORD, GLPI_DB_NAME, GLPI_DB_PORT, charset='utf8', collation='utf8_general_ci')
    sgsi_conn = get_db_connection(SGSI_DB_HOST, SGSI_DB_USER, SGSI_DB_PASSWORD, SGSI_DB_NAME, SGSI_DB_PORT, charset='utf8mb4', collation='utf8mb4_unicode_ci')
    if not glpi_conn or not sgsi_conn:
        logging.error('Conexiones no disponibles')
        raise SystemExit(1)

    rows = extract_computer_software(glpi_conn)
    processed = 0
    skipped = 0
    for r in rows:
        id_activo, id_sw = resolve_ids(sgsi_conn, r.get('raw_computer_id'), r.get('raw_sw_id'))
        if not id_activo or not id_sw:
            skipped += 1
            continue
        upsert_activo_software(sgsi_conn, id_activo, id_sw, r.get('raw_version'), r.get('raw_swver_id'))
        processed += 1

    logging.info(f'Relaciones cargadas/actualizadas: {processed}, saltadas: {skipped}')
    if glpi_conn.is_connected():
        glpi_conn.close()
    if sgsi_conn.is_connected():
        sgsi_conn.close()
    logging.info('ETL relación Activo-Software finalizado')


if __name__ == '__main__':
    run()


