# etl_utils.py
import os
import mysql.connector
from dotenv import load_dotenv
import logging
import sys

def get_script_dir():
    """Returns the directory where the current script is located."""
    if getattr(sys, 'frozen', False):
        # If the application is run as a bundle (e.g. PyInstaller)
        return os.path.dirname(sys.executable)
    else:
        # If the application is run from a Python interpreter
        return os.path.dirname(os.path.abspath(__file__))

def setup_logging():
    """Configura el logging básico para los scripts ETL."""
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def load_env_file(dotenv_path, purpose=""):
    """Carga un archivo .env específico usando rutas absolutas."""
    script_dir = get_script_dir()
    absolute_path = os.path.join(script_dir, dotenv_path)
    
    if os.path.exists(absolute_path):
        logging.info(f"Cargando variables de entorno para {purpose} desde: {absolute_path}")
        load_dotenv(absolute_path, override=True) # Override para permitir cargar múltiples .env
    else:
        logging.warning(f"ADVERTENCIA: El archivo de credenciales '{absolute_path}' ({purpose}) no fue encontrado.")
        return False
    return True

def get_db_connection(host, user, password, database, port, charset=None, collation=None):
    """Establece y devuelve una conexión a la base de datos.
    Permite forzar charset/collation cuando el servidor no soporta el default.
    """
    connection = None
    if not all([host, user, database]): # Password puede ser vacío para algunos usuarios/configs
        logging.error(f"Faltan parámetros de conexión para {database} en {host} (host, user, db son requeridos).")
        return None
    try:
        # Defaults, con fallback cuando el servidor no soporta el charset
        candidates = []
        if charset:
            candidates.append((charset, collation or 'utf8_general_ci'))
        else:
            candidates.extend([
                ('utf8', 'utf8_general_ci'),
                ('latin1', 'latin1_swedish_ci'),
                ('utf8mb4', 'utf8mb4_general_ci'),
            ])

        last_err = None
        for cs, coll in candidates:
            try:
                connection = mysql.connector.connect(
                    host=host,
                    user=user,
                    password=password,
                    database=database,
                    port=int(port),
                    charset=cs,
                    collation=coll,
                    use_unicode=True
                )
                if connection.is_connected():
                    logging.info(f"Conexión exitosa a la base de datos {database} en {host} (charset={cs}, coll={coll}).")
                    break
            except mysql.connector.Error as err:
                last_err = err
                logging.warning(f"Reintento conexión {database}@{host} con charset={cs} falló: {err}")
                connection = None
        if connection is None:
            raise last_err or Exception('No se pudo conectar con ninguno de los charsets probados')
    except mysql.connector.Error as err:
        logging.error(f"Error al conectar a la BD {database} en {host}: {err}")
        connection = None
    except ValueError as ve:
        logging.error(f"Error en el valor del puerto para {database} en {host}: {ve}")
        connection = None
    return connection

def get_user_id_by_email(email, sgsi_cursor):
    """Obtiene el id_usuario de la tabla usuarios_sistema basado en el email."""
    if not email:
        return None
    try:
        sgsi_cursor.execute("SELECT id_usuario FROM usuarios_sistema WHERE email_institucional = %s", (email,))
        result = sgsi_cursor.fetchone()
        if result:
            return result[0]
        else:
            logging.warning(f"No se encontró usuario en SGSI con email: {email}")
            return None
    except mysql.connector.Error as err:
        logging.error(f"Error al buscar usuario por email {email} en SGSI: {err}")
        return None

# Puedes agregar más funciones comunes aquí a medida que las necesites.