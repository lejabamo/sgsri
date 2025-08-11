import os
import logging
import mysql.connector
from etl_utils import setup_logging, load_env_file, get_db_connection

# Configurar logging
setup_logging()

def clean_tables(sgsi_conn):
    """Limpia las tablas y reinicia los contadores."""
    if not sgsi_conn:
        return False
    
    cursor = None
    try:
        cursor = sgsi_conn.cursor()
        
        # Leer el script de limpieza
        script_dir = os.path.dirname(os.path.abspath(__file__))
        clean_script_path = os.path.join(script_dir, 'clean_tables.sql')
        
        with open(clean_script_path, 'r') as f:
            clean_script = f.read()
        
        # Ejecutar cada comando SQL por separado
        for command in clean_script.split(';'):
            if command.strip():
                cursor.execute(command)
        
        sgsi_conn.commit()
        logging.info("Tablas limpiadas y contadores reiniciados exitosamente.")
        return True
        
    except Exception as e:
        logging.error(f"Error al limpiar las tablas: {str(e)}")
        if sgsi_conn:
            sgsi_conn.rollback()
        return False
    finally:
        if cursor:
            cursor.close()

if __name__ == '__main__':
    logging.info("Iniciando proceso de limpieza y ETL...")
    
    # Cargar credenciales SGSI
    if not load_env_file('sgsi_credentials.env', "SGSI"):
        logging.error("No se pudo cargar la configuración de SGSI. Saliendo.")
        exit()
    
    # Obtener credenciales SGSI
    SGSI_DB_HOST = os.environ.get('SGSI_MYSQL_HOST')
    SGSI_DB_USER = os.environ.get('SGSI_MYSQL_USER')
    SGSI_DB_PASSWORD = os.environ.get('SGSI_MYSQL_PASSWORD')
    SGSI_DB_NAME = os.environ.get('SGSI_MYSQL_DB')
    SGSI_DB_PORT = os.environ.get('SGSI_MYSQL_PORT', '3306')
    
    # Conectar a SGSI
    sgsi_conn = get_db_connection(SGSI_DB_HOST, SGSI_DB_USER, SGSI_DB_PASSWORD, SGSI_DB_NAME, SGSI_DB_PORT)
    
    if not sgsi_conn:
        logging.error("No se pudo conectar a la base de datos SGSI. Abortando.")
        exit()
    
    # Limpiar tablas
    if clean_tables(sgsi_conn):
        logging.info("Procediendo a ejecutar el ETL...")
        # Cerrar conexión actual
        sgsi_conn.close()
        
        # Ejecutar el script ETL
        os.system('python etl_computers.py')
    else:
        logging.error("La limpieza de tablas falló. No se ejecutará el ETL.")
        if sgsi_conn:
            sgsi_conn.close() 