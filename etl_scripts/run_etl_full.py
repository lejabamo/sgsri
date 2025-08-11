import logging
import mysql.connector
import os
import sys
from etl_utils import setup_logging, load_env_file, get_db_connection
import etl_users
import etl_computers

def clean_tables(conn):
    CLEAN_SQL = [
        "DELETE FROM activos_detalles_tecnologicos;",
        "ALTER TABLE activos_detalles_tecnologicos AUTO_INCREMENT = 1;",
        "DELETE FROM activos;",
        "ALTER TABLE activos AUTO_INCREMENT = 1;",
        "DELETE FROM usuarios_sistema;",
        "ALTER TABLE usuarios_sistema AUTO_INCREMENT = 1;"
    ]
    cursor = conn.cursor()
    for sql in CLEAN_SQL:
        try:
            cursor.execute(sql)
            conn.commit()
            logging.info(f"Ejecutado: {sql}")
        except Exception as e:
            logging.error(f"Error ejecutando '{sql}': {e}")
    cursor.close()

if __name__ == "__main__":
    setup_logging()
    # Cargar variables de entorno
    if not load_env_file('sgsi_credentials.env', "SGSI"):
        logging.error("No se pudo cargar la configuración de SGSI. Saliendo.")
        sys.exit(1)

    SGSI_DB_HOST = os.environ.get('SGSI_MYSQL_HOST')
    SGSI_DB_USER = os.environ.get('SGSI_MYSQL_USER')
    SGSI_DB_PASSWORD = os.environ.get('SGSI_MYSQL_PASSWORD')
    SGSI_DB_NAME = os.environ.get('SGSI_MYSQL_DB')
    SGSI_DB_PORT = os.environ.get('SGSI_MYSQL_PORT', '3306')

    logging.info("Iniciando limpieza de tablas SGSRI...")
    sgsi_conn = get_db_connection(SGSI_DB_HOST, SGSI_DB_USER, SGSI_DB_PASSWORD, SGSI_DB_NAME, SGSI_DB_PORT)
    if not sgsi_conn:
        logging.error("No se pudo conectar a la base de datos SGSRI. Abortando.")
        sys.exit(1)
    clean_tables(sgsi_conn)
    logging.info("Limpieza de tablas completada.")

    # Ejecutar ETL de usuarios
    logging.info("Iniciando ETL de usuarios...")
    etl_users_main = getattr(etl_users, '__main__', None)
    if etl_users_main:
        etl_users.__main__()
    else:
        glpi_conn = etl_users.get_db_connection(
            etl_users.GLPI_DB_HOST, etl_users.GLPI_DB_USER, etl_users.GLPI_DB_PASSWORD, etl_users.GLPI_DB_NAME, etl_users.GLPI_DB_PORT)
        extracted_glpi_users = etl_users.extract_glpi_users(glpi_conn)
        if extracted_glpi_users:
            for glpi_user_row in extracted_glpi_users:
                transformed_data = etl_users.transform_user_data(glpi_user_row)
                if transformed_data:
                    etl_users.load_users_to_sgsi(sgsi_conn, transformed_data)
        if glpi_conn and glpi_conn.is_connected():
            glpi_conn.close()
    logging.info("ETL de usuarios completado.")

    # Ejecutar ETL de activos
    logging.info("Iniciando ETL de activos...")
    etl_computers_main = getattr(etl_computers, '__main__', None)
    if etl_computers_main:
        etl_computers.__main__()
    else:
        glpi_conn = etl_computers.get_db_connection(
            etl_computers.GLPI_DB_HOST, etl_computers.GLPI_DB_USER, etl_computers.GLPI_DB_PASSWORD, etl_computers.GLPI_DB_NAME, etl_computers.GLPI_DB_PORT)
        sgsi_conn2 = get_db_connection(SGSI_DB_HOST, SGSI_DB_USER, SGSI_DB_PASSWORD, SGSI_DB_NAME, SGSI_DB_PORT)
        extracted_computers = etl_computers.extract_glpi_computers(glpi_conn)
        if extracted_computers:
            sgsi_cursor = sgsi_conn2.cursor()
            for comp_row in extracted_computers:
                transformed_data = etl_computers.transform_computer_data(comp_row, sgsi_cursor)
                if transformed_data:
                    etl_computers.load_computer_data(sgsi_conn2, *transformed_data)
            sgsi_cursor.close()
        if glpi_conn and glpi_conn.is_connected():
            glpi_conn.close()
        if sgsi_conn2 and sgsi_conn2.is_connected():
            sgsi_conn2.close()
    logging.info("ETL de activos completado.")

    if sgsi_conn and sgsi_conn.is_connected():
        sgsi_conn.close()
        logging.info("Conexión a SGSRI cerrada.")
    logging.info("Proceso ETL completo finalizado.") 