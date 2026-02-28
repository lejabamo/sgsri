#!/usr/bin/env python3
"""
Script para crear backup de la base de datos SGRI
"""

import os
import sys
from datetime import datetime
from app import create_app
from app.config import Config
import subprocess

def create_backup():
    """Crear backup de la base de datos MySQL"""
    app = create_app()
    
    with app.app_context():
        config = app.config
        
        # Obtener configuración de la base de datos
        db_user = config.get('DB_USER', 'root')
        db_password = config.get('DB_PASSWORD', 'toor')
        db_host = config.get('DB_HOST', 'localhost')
        db_port = config.get('DB_PORT', '3306')
        db_name = config.get('DB_NAME', 'sgri')
        
        # Crear directorio de backups si no existe
        backup_dir = os.path.join(os.path.dirname(__file__), '..', 'backups')
        os.makedirs(backup_dir, exist_ok=True)
        
        # Nombre del archivo de backup con timestamp
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        backup_filename = f'sgri_backup_{timestamp}.sql'
        backup_path = os.path.join(backup_dir, backup_filename)
        
        print("=" * 60)
        print("CREANDO BACKUP DE LA BASE DE DATOS SGRI")
        print("=" * 60)
        print(f"Base de datos: {db_name}")
        print(f"Host: {db_host}:{db_port}")
        print(f"Archivo de backup: {backup_filename}")
        print()
        
        try:
            # Construir comando mysqldump
            # En Windows, puede ser mysqldump.exe o mysqldump dependiendo de la instalación
            mysqldump_cmd = 'mysqldump'
            
            # Verificar si mysqldump está disponible
            try:
                subprocess.run([mysqldump_cmd, '--version'], 
                             capture_output=True, check=True)
            except (subprocess.CalledProcessError, FileNotFoundError):
                # Intentar con .exe en Windows
                mysqldump_cmd = 'mysqldump.exe'
                try:
                    subprocess.run([mysqldump_cmd, '--version'], 
                                 capture_output=True, check=True)
                except (subprocess.CalledProcessError, FileNotFoundError):
                    print("ERROR: mysqldump no encontrado")
                    print("Asegúrate de que MySQL esté instalado y en el PATH")
                    return False
            
            # Construir comando completo
            cmd = [
                mysqldump_cmd,
                f'--user={db_user}',
                f'--password={db_password}',
                f'--host={db_host}',
                f'--port={db_port}',
                '--single-transaction',
                '--routines',
                '--triggers',
                '--events',
                '--add-drop-database',
                '--databases',
                db_name
            ]
            
            print("Ejecutando backup...")
            
            # Ejecutar mysqldump y guardar en archivo
            with open(backup_path, 'w', encoding='utf-8') as backup_file:
                result = subprocess.run(
                    cmd,
                    stdout=backup_file,
                    stderr=subprocess.PIPE,
                    text=True
                )
            
            if result.returncode == 0:
                # Obtener tamaño del archivo
                file_size = os.path.getsize(backup_path)
                file_size_mb = file_size / (1024 * 1024)
                
                print()
                print("=" * 60)
                print("BACKUP COMPLETADO EXITOSAMENTE")
                print("=" * 60)
                print(f"Archivo: {backup_path}")
                print(f"Tamaño: {file_size_mb:.2f} MB")
                print()
                
                # Crear también un enlace simbólico al último backup
                latest_backup = os.path.join(backup_dir, 'sgri_backup_latest.sql')
                try:
                    if os.path.exists(latest_backup):
                        os.remove(latest_backup)
                    os.symlink(backup_filename, latest_backup)
                except OSError:
                    # En Windows puede fallar si no hay permisos de administrador
                    pass
                
                return True
            else:
                print()
                print("=" * 60)
                print("ERROR AL CREAR BACKUP")
                print("=" * 60)
                print(result.stderr)
                return False
                
        except Exception as e:
            print()
            print("=" * 60)
            print("ERROR INESPERADO")
            print("=" * 60)
            print(f"Error: {str(e)}")
            return False

def list_backups():
    """Listar todos los backups disponibles"""
    backup_dir = os.path.join(os.path.dirname(__file__), '..', 'backups')
    
    if not os.path.exists(backup_dir):
        print("No hay directorio de backups")
        return
    
    backups = [f for f in os.listdir(backup_dir) 
               if f.startswith('sgri_backup_') and f.endswith('.sql')]
    
    if not backups:
        print("No se encontraron backups")
        return
    
    backups.sort(reverse=True)
    
    print("=" * 60)
    print("BACKUPS DISPONIBLES")
    print("=" * 60)
    for backup in backups:
        backup_path = os.path.join(backup_dir, backup)
        file_size = os.path.getsize(backup_path)
        file_size_mb = file_size / (1024 * 1024)
        mod_time = datetime.fromtimestamp(os.path.getmtime(backup_path))
        print(f"{backup} - {file_size_mb:.2f} MB - {mod_time.strftime('%Y-%m-%d %H:%M:%S')}")

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == '--list':
        list_backups()
    else:
        success = create_backup()
        sys.exit(0 if success else 1)

