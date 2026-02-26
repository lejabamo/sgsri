#!/usr/bin/env python3
"""
Script para inicializar usuarios de autenticación
"""

from app import create_app
from app.auth.models import UsuarioAuth
from app.models import UsuarioSistema
from app import db

def init_auth_users():
    """Inicializar usuarios de autenticación"""
    app = create_app()

    with app.app_context():
        # Obtener usuarios del sistema existentes
        usuarios_sistema = UsuarioSistema.query.all()

        if not usuarios_sistema:
            print("No hay usuarios del sistema. Ejecuta setup_database.py primero")
            return

        # Usuarios de autenticación a crear
        # IMPORTANTE: Las contraseñas deben configurarse mediante variables de entorno
        # o generarse de forma segura. NO hardcodear contraseñas en el código.
        import os
        import secrets
        import string
        
        def generate_secure_password(length=12):
            """Generar contraseña segura aleatoria"""
            alphabet = string.ascii_letters + string.digits + "!@#$%^&*"
            return ''.join(secrets.choice(alphabet) for i in range(length))
        
        # Obtener contraseñas de variables de entorno, o generar nuevas
        admin_password = os.getenv('ADMIN_PASSWORD', generate_secure_password())
        operador_password = os.getenv('OPERADOR_PASSWORD', generate_secure_password())
        consultor_password = os.getenv('CONSULTOR_PASSWORD', generate_secure_password())
        
        auth_users_data = [
            {
                'id_usuario_sistema': 1,  # Juan Pérez
                'username': 'admin',
                'password': admin_password,
                'id_rol': 1  # ADMIN
            },
            {
                'id_usuario_sistema': 2,  # María García
                'username': 'operador',
                'password': operador_password,
                'id_rol': 2  # OPERADOR
            },
            {
                'id_usuario_sistema': 3,  # Carlos López
                'username': 'consultor',
                'password': consultor_password,
                'id_rol': 3  # CONSULTOR
            }
        ]

        for user_data in auth_users_data:
            # Verificar si el usuario ya existe
            existing_user = UsuarioAuth.query.filter_by(username=user_data['username']).first()

            if not existing_user:
                # Verificar que el usuario del sistema existe
                usuario_sistema = UsuarioSistema.query.get(user_data['id_usuario_sistema'])
                if not usuario_sistema:
                    print(f"Usuario del sistema con ID {user_data['id_usuario_sistema']} no encontrado")
                    continue

                user = UsuarioAuth(**user_data)
                user.set_password(user_data['password'])
                db.session.add(user)
                print(f"Usuario '{user_data['username']}' creado")
            else:
                print(f"Usuario '{user_data['username']}' ya existe")

        db.session.commit()
        print("Usuarios de autenticación inicializados correctamente")

        # Mostrar credenciales solo si se generaron (no si vienen de variables de entorno)
        if not os.getenv('ADMIN_PASSWORD'):
            print("\n⚠️  IMPORTANTE: Se generaron contraseñas aleatorias.")
            print("⚠️  Las contraseñas se muestran SOLO en la primera ejecución.")
            print("\nCredenciales de acceso generadas:")
            print(f"Admin: admin / {admin_password}")
            print(f"Operador: operador / {operador_password}")
            print(f"Consultor: consultor / {consultor_password}")
            print("\n⚠️  Guarda estas contraseñas de forma segura.")
            print("⚠️  Para producción, usa variables de entorno:")
            print("   export ADMIN_PASSWORD='tu_password_seguro'")
            print("   export OPERADOR_PASSWORD='tu_password_seguro'")
            print("   export CONSULTOR_PASSWORD='tu_password_seguro'")
        else:
            print("\n✅ Usuarios creados con contraseñas de variables de entorno")

if __name__ == "__main__":
    init_auth_users()