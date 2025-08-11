import os
from dotenv import load_dotenv

# Determina el directorio base del proyecto
# Esto asegura que encuentre el .env sin importar desde dónde se ejecute el script.
basedir = os.path.abspath(os.path.dirname(__file__))
load_dotenv(os.path.join(basedir, '.env')) # Carga las variables del .env

class Config:
    """Clase base de configuración."""
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'una-clave-secreta-por-defecto-muy-dificil'
    FLASK_APP = os.environ.get('FLASK_APP') or 'run.py'
    FLASK_ENV = os.environ.get('FLASK_ENV') or 'development'

    # Configuración SQLAlchemy para MySQL
    DB_USER = os.environ.get('DB_USER')
    DB_PASSWORD = os.environ.get('DB_PASSWORD')
    DB_HOST = os.environ.get('DB_HOST')
    DB_PORT = os.environ.get('DB_PORT')
    DB_NAME = os.environ.get('DB_NAME')

    if not all([DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_NAME]):
        print("ALERTA: Una o más variables de configuración de la base de datos no están definidas.")
        # Podrías optar por lanzar un error aquí si prefieres que la app no inicie sin config de BD
        # raise ValueError("Faltan variables de configuración para la base de datos en el archivo .env")


    # SQLAlchemy Database URI
    # Asegúrate de que esta cadena de conexión coincida con el conector que instalaste (mysqlclient o PyMySQL)
    # Opción A: Para mysqlclient
    SQLALCHEMY_DATABASE_URI = f'mysql+mysqlclient://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'
    # Opción B: Para PyMySQL (si usaste ese conector)
    # SQLALCHEMY_DATABASE_URI = f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}?charset=utf8mb4'

    SQLALCHEMY_TRACK_MODIFICATIONS = False # Desactiva el seguimiento de modificaciones de SQLAlchemy, que consume recursos.
    SQLALCHEMY_ECHO = False # Poner a True solo durante el desarrollo para ver las queries SQL generadas.

class DevelopmentConfig(Config):
    """Configuración para desarrollo."""
    DEBUG = True
    SQLALCHEMY_ECHO = True # Útil para ver las queries en desarrollo

class ProductionConfig(Config):
    """Configuración para producción."""
    DEBUG = False
    SQLALCHEMY_ECHO = False
    # Aquí podrías añadir otras configuraciones específicas de producción
    # como configuraciones de logging más robustas, diferentes servidores de BD si aplica, etc.

class TestingConfig(Config):
    """Configuración para pruebas."""
    TESTING = True
    # Podrías usar una base de datos SQLite en memoria para pruebas rápidas
    # SQLALCHEMY_DATABASE_URI = 'sqlite:///:memory:'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = False

# Diccionario para seleccionar la configuración basada en FLASK_ENV
config_by_name = dict(
    development=DevelopmentConfig,
    production=ProductionConfig,
    testing=TestingConfig
)