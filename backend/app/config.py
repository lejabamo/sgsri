import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', 'dev')
    # Configuración actualizada para MySQL en Windows con autenticación nativa
    SQLALCHEMY_DATABASE_URI = os.environ.get(
        'DATABASE_URL', 
        'mysql+mysqlconnector://root:password@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password&charset=utf8mb4'
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False 