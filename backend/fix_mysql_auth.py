#!/usr/bin/env python3
"""
Script para solucionar problemas de autenticación de MySQL en Windows
"""

import mysql.connector
from mysql.connector import Error

def fix_mysql_authentication():
    """Solucionar problemas de autenticación de MySQL"""
    print("🔧 Solucionando problemas de autenticación de MySQL...")
    
    # Configuración de conexión
    config = {
        'host': 'localhost',
        'user': 'root',
        'password': 'password',  # Cambiar por tu contraseña
        'auth_plugin': 'mysql_native_password'
    }
    
    try:
        # Conectar a MySQL
        print("📡 Conectando a MySQL...")
        connection = mysql.connector.connect(**config)
        
        if connection.is_connected():
            cursor = connection.cursor()
            
            # Verificar versión de MySQL
            cursor.execute("SELECT VERSION()")
            version = cursor.fetchone()
            print(f"✅ Conectado a MySQL versión: {version[0]}")
            
            # Crear la base de datos si no existe
            cursor.execute("CREATE DATABASE IF NOT EXISTS sgri_db_final_v2")
            print("✅ Base de datos 'sgri_db_final_v2' creada/verificada")
            
            # Verificar y crear usuario si es necesario
            cursor.execute("SELECT User FROM mysql.user WHERE User = 'sgri_user'")
            user_exists = cursor.fetchone()
            
            if not user_exists:
                # Crear usuario específico para la aplicación
                cursor.execute("""
                    CREATE USER 'sgri_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'sgri_password'
                """)
                print("✅ Usuario 'sgri_user' creado")
            
            # Otorgar permisos
            cursor.execute("""
                GRANT ALL PRIVILEGES ON sgri_db_final_v2.* TO 'sgri_user'@'localhost'
            """)
            cursor.execute("FLUSH PRIVILEGES")
            print("✅ Permisos otorgados")
            
            # Crear archivo .env con la nueva configuración
            env_content = """SECRET_KEY=sgri_secret_key_2024
DATABASE_URL=mysql+mysqlconnector://sgri_user:sgri_password@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password&charset=utf8mb4
"""
            
            with open('.env', 'w') as f:
                f.write(env_content)
            
            print("✅ Archivo .env actualizado con nueva configuración")
            print("\n📝 Configuración de conexión:")
            print("   Usuario: sgri_user")
            print("   Contraseña: sgri_password")
            print("   Base de datos: sgri_db_final_v2")
            
            cursor.close()
            connection.close()
            print("✅ Conexión cerrada correctamente")
            
        return True
        
    except Error as e:
        print(f"❌ Error de conexión: {e}")
        print("\n💡 Soluciones posibles:")
        print("1. Verificar que MySQL esté ejecutándose")
        print("2. Verificar las credenciales de root")
        print("3. Ejecutar como administrador")
        print("4. Verificar que el puerto 3306 esté disponible")
        return False

def test_connection():
    """Probar la conexión con la nueva configuración"""
    print("\n🧪 Probando conexión con nueva configuración...")
    
    try:
        from app import create_app, db
        
        app = create_app()
        
        with app.app_context():
            # Intentar conectar a la base de datos
            db.engine.connect()
            print("✅ Conexión exitosa con la nueva configuración")
            return True
            
    except Exception as e:
        print(f"❌ Error en la prueba de conexión: {e}")
        return False

if __name__ == "__main__":
    print("🔧 Solucionador de Autenticación MySQL para SGRI")
    print("=" * 50)
    
    # Solicitar credenciales de root
    print("\nPor favor proporciona las credenciales de MySQL root:")
    root_password = input("Contraseña de root (dejar vacío si no hay): ").strip()
    
    if root_password:
        # Actualizar la configuración con la contraseña proporcionada
        import mysql.connector
        from mysql.connector import Error
        
        config = {
            'host': 'localhost',
            'user': 'root',
            'password': root_password,
            'auth_plugin': 'mysql_native_password'
        }
        
        try:
            connection = mysql.connector.connect(**config)
            
            if connection.is_connected():
                cursor = connection.cursor()
                
                # Crear la base de datos
                cursor.execute("CREATE DATABASE IF NOT EXISTS sgri_db_final_v2")
                
                # Crear usuario específico
                cursor.execute("""
                    CREATE USER IF NOT EXISTS 'sgri_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'sgri_password'
                """)
                
                # Otorgar permisos
                cursor.execute("""
                    GRANT ALL PRIVILEGES ON sgri_db_final_v2.* TO 'sgri_user'@'localhost'
                """)
                cursor.execute("FLUSH PRIVILEGES")
                
                # Crear archivo .env
                env_content = f"""SECRET_KEY=sgri_secret_key_2024
DATABASE_URL=mysql+mysqlconnector://sgri_user:sgri_password@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password&charset=utf8mb4
"""
                
                with open('.env', 'w') as f:
                    f.write(env_content)
                
                print("✅ Configuración completada exitosamente")
                print("📝 Archivo .env creado con nueva configuración")
                
                cursor.close()
                connection.close()
                
                # Probar la conexión
                if test_connection():
                    print("\n🎉 ¡Configuración completada! Puedes ejecutar:")
                    print("   python init_db.py")
                else:
                    print("\n⚠️  La configuración se completó pero hay problemas de conexión")
                
        except Error as e:
            print(f"❌ Error: {e}")
            print("\n💡 Verifica que:")
            print("   - MySQL esté ejecutándose")
            print("   - Las credenciales sean correctas")
            print("   - Tengas permisos de administrador")
    
    else:
        print("⚠️  No se proporcionó contraseña. Usando configuración por defecto.")
        if fix_mysql_authentication():
            if test_connection():
                print("\n🎉 ¡Configuración completada! Puedes ejecutar:")
                print("   python init_db.py")
            else:
                print("\n⚠️  La configuración se completó pero hay problemas de conexión") 