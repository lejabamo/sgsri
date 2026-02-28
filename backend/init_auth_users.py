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
        auth_users_data = [
            {
                'id_usuario_sistema': 1,  # Juan Pérez
                'username': 'admin',
                'password': 'admin123',
                'id_rol': 1  # ADMIN
            },
            {
                'id_usuario_sistema': 2,  # María García
                'username': 'operador',
                'password': 'operador123',
                'id_rol': 2  # OPERADOR
            },
            {
                'id_usuario_sistema': 3,  # Carlos López
                'username': 'consultor',
                'password': 'consultor123',
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

        # Mostrar credenciales
        print("\nCredenciales de acceso:")
        print("Admin: admin / admin123")
        print("Operador: operador / operador123")
        print("Consultor: consultor / consultor123")

if __name__ == "__main__":
    init_auth_users()