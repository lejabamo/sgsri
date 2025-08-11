#!/usr/bin/env python3
"""
Script para verificar la versión de MySQL y su configuración
"""

import subprocess
import sys
import mysql.connector
from mysql.connector import Error

def check_mysql_version():
    """Verificar la versión de MySQL instalada"""
    print("🔍 Verificando versión de MySQL...")
    
    try:
        # Intentar conectar con mysql-connector
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='',  # Sin contraseña por defecto
            auth_plugin='mysql_native_password'
        )
        
        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute("SELECT VERSION()")
            version = cursor.fetchone()
            print(f"✅ MySQL versión: {version[0]}")
            
            # Verificar configuración de autenticación
            cursor.execute("SELECT User, Host, plugin FROM mysql.user WHERE User = 'root'")
            users = cursor.fetchall()
            
            print("\n📋 Configuración de usuarios:")
            for user in users:
                print(f"   Usuario: {user[0]}@{user[1]} - Plugin: {user[2]}")
            
            cursor.close()
            connection.close()
            return True
            
    except Error as e:
        print(f"❌ Error de conexión: {e}")
        return False

def check_mysql_command_line():
    """Verificar MySQL desde línea de comandos"""
    print("\n🔍 Verificando MySQL desde línea de comandos...")
    
    try:
        # Verificar si mysql está en PATH
        result = subprocess.run(['mysql', '--version'], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            print(f"✅ MySQL CLI: {result.stdout.strip()}")
            return True
        else:
            print("❌ MySQL CLI no encontrado en PATH")
            return False
    except FileNotFoundError:
        print("❌ MySQL CLI no encontrado")
        return False

def check_mysql_service():
    """Verificar si el servicio MySQL está ejecutándose"""
    print("\n🔍 Verificando servicio MySQL...")
    
    try:
        # Verificar servicio en Windows
        result = subprocess.run(['sc', 'query', 'mysql'], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            if "RUNNING" in result.stdout:
                print("✅ Servicio MySQL está ejecutándose")
                return True
            else:
                print("⚠️  Servicio MySQL no está ejecutándose")
                return False
        else:
            print("❌ No se pudo verificar el servicio MySQL")
            return False
    except FileNotFoundError:
        print("❌ Comando 'sc' no disponible")
        return False

def check_connection_options():
    """Verificar opciones de conexión"""
    print("\n🔍 Verificando opciones de conexión...")
    
    # Probar diferentes configuraciones
    configs = [
        {
            'name': 'Sin contraseña',
            'config': {
                'host': 'localhost',
                'user': 'root',
                'auth_plugin': 'mysql_native_password'
            }
        },
        {
            'name': 'Con contraseña vacía',
            'config': {
                'host': 'localhost',
                'user': 'root',
                'password': '',
                'auth_plugin': 'mysql_native_password'
            }
        },
        {
            'name': 'Sin plugin específico',
            'config': {
                'host': 'localhost',
                'user': 'root'
            }
        }
    ]
    
    for config in configs:
        try:
            connection = mysql.connector.connect(**config['config'])
            if connection.is_connected():
                print(f"✅ {config['name']}: Conexión exitosa")
                connection.close()
            else:
                print(f"❌ {config['name']}: Conexión fallida")
        except Error as e:
            print(f"❌ {config['name']}: {e}")

def recommend_solution():
    """Recomendar solución basada en la verificación"""
    print("\n🎯 RECOMENDACIONES:")
    print("=" * 50)
    
    print("\n1. **Para MySQL 8.0.43 (Recomendado):**")
    print("   - Usar mysql_native_password explícitamente")
    print("   - Configurar usuario específico para la aplicación")
    print("   - Usar charset=utf8mb4")
    
    print("\n2. **Configuración del archivo .env:**")
    print("   DATABASE_URL=mysql+mysqlconnector://sgri_user:sgri_password@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password&charset=utf8mb4")
    
    print("\n3. **Comandos SQL necesarios:**")
    print("   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'tu_contraseña';")
    print("   CREATE USER 'sgri_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'sgri_password';")
    print("   GRANT ALL PRIVILEGES ON sgri_db_final_v2.* TO 'sgri_user'@'localhost';")
    
    print("\n4. **Alternativa si persisten problemas:**")
    print("   - Usar MySQL 5.7.x para máxima compatibilidad")
    print("   - O usar SQLite para desarrollo")

def main():
    """Función principal"""
    print("🔍 Verificador de MySQL para SGRI")
    print("=" * 50)
    
    # Verificaciones
    cli_ok = check_mysql_command_line()
    service_ok = check_mysql_service()
    version_ok = check_mysql_version()
    
    if cli_ok and service_ok:
        check_connection_options()
    
    recommend_solution()
    
    print("\n📝 Próximos pasos:")
    if version_ok:
        print("1. Ejecutar: python fix_mysql_auth.py")
        print("2. O configurar manualmente siguiendo MYSQL_SETUP.md")
    else:
        print("1. Verificar instalación de MySQL")
        print("2. Asegurar que el servicio esté ejecutándose")
        print("3. Configurar autenticación correctamente")

if __name__ == "__main__":
    main() 