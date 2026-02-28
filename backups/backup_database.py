#!/usr/bin/env python3
"""
Script para crear backup de la base de datos del proyecto SGSRI
"""

import os
import sys
import datetime
import subprocess
from pathlib import Path

def create_database_backup():
    """Crear backup de la base de datos"""
    try:
        # Obtener la fecha actual para el nombre del backup
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_filename = f"sgsri_backup_{timestamp}.sql"
        backup_path = Path("backups") / backup_filename
        
        # Configuración de la base de datos
        db_config = {
            'host': 'localhost',
            'port': '5432',
            'database': 'sgsri_db',
            'user': 'postgres',
            'password': 'your_password_here'  # Cambiar por la contraseña real
        }
        
        # Comando para crear el backup
        pg_dump_cmd = [
            'pg_dump',
            f"--host={db_config['host']}",
            f"--port={db_config['port']}",
            f"--username={db_config['user']}",
            f"--dbname={db_config['database']}",
            f"--file={backup_path}",
            '--verbose',
            '--clean',
            '--create'
        ]
        
        print(f"Creando backup de la base de datos...")
        print(f"Archivo de destino: {backup_path}")
        
        # Ejecutar el comando pg_dump
        result = subprocess.run(pg_dump_cmd, capture_output=True, text=True)
        
        if result.returncode == 0:
            print(f"✅ Backup creado exitosamente: {backup_path}")
            print(f"Tamaño del archivo: {backup_path.stat().st_size / 1024 / 1024:.2f} MB")
        else:
            print(f"❌ Error al crear el backup:")
            print(f"STDOUT: {result.stdout}")
            print(f"STDERR: {result.stderr}")
            return False
            
    except Exception as e:
        print(f"❌ Error inesperado: {e}")
        return False
    
    return True

def create_data_backup():
    """Crear backup de los datos del proyecto"""
    try:
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_filename = f"sgsri_data_backup_{timestamp}.zip"
        backup_path = Path("backups") / backup_filename
        
        # Archivos y carpetas importantes a respaldar
        important_paths = [
            "backend/app/models.py",
            "backend/app/routes/",
            "backend/app/auth/",
            "frontend/src/",
            "Docs/",
            "etl_scripts/",
            "requirements.txt",
            "README.md"
        ]
        
        print(f"Creando backup de datos del proyecto...")
        print(f"Archivo de destino: {backup_path}")
        
        # Crear el archivo ZIP
        import zipfile
        with zipfile.ZipFile(backup_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
            for path in important_paths:
                if os.path.exists(path):
                    if os.path.isfile(path):
                        zipf.write(path)
                    elif os.path.isdir(path):
                        for root, dirs, files in os.walk(path):
                            for file in files:
                                file_path = os.path.join(root, file)
                                zipf.write(file_path)
        
        print(f"✅ Backup de datos creado exitosamente: {backup_path}")
        print(f"Tamaño del archivo: {backup_path.stat().st_size / 1024 / 1024:.2f} MB")
        
    except Exception as e:
        print(f"❌ Error al crear el backup de datos: {e}")
        return False
    
    return True

def main():
    """Función principal"""
    print("🚀 Iniciando proceso de backup del proyecto SGSRI")
    print("=" * 50)
    
    # Crear directorio de backups si no existe
    os.makedirs("backups", exist_ok=True)
    
    # Crear backup de la base de datos
    print("\n📊 Creando backup de la base de datos...")
    db_success = create_database_backup()
    
    # Crear backup de los datos del proyecto
    print("\n📁 Creando backup de los datos del proyecto...")
    data_success = create_data_backup()
    
    # Resumen
    print("\n" + "=" * 50)
    print("📋 RESUMEN DEL BACKUP:")
    print(f"Base de datos: {'✅ Exitoso' if db_success else '❌ Falló'}")
    print(f"Datos del proyecto: {'✅ Exitoso' if data_success else '❌ Falló'}")
    
    if db_success and data_success:
        print("\n🎉 ¡Backup completado exitosamente!")
    else:
        print("\n⚠️  Backup completado con errores. Revisar los mensajes anteriores.")
    
    return db_success and data_success

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
