#!/usr/bin/env python3
"""
Script para probar la autenticación
"""

from app import create_app
from app.auth.models import UsuarioAuth, Rol
from app.models import UsuarioSistema
from app import db

def test_auth():
    """Probar autenticación"""
    app = create_app()

    with app.app_context():
        print("=== Probando autenticación ===")

        # Verificar roles
        roles = Rol.query.all()
        print(f"Roles encontrados: {len(roles)}")
        for rol in roles:
            print(f"  - {rol.nombre_rol} (ID: {rol.id_rol})")

        # Verificar usuarios del sistema
        usuarios_sistema = UsuarioSistema.query.all()
        print(f"\nUsuarios del sistema encontrados: {len(usuarios_sistema)}")
        for usuario in usuarios_sistema:
            print(f"  - {usuario.nombre_completo} (ID: {usuario.id_usuario})")

        # Verificar usuarios de autenticación
        usuarios_auth = UsuarioAuth.query.all()
        print(f"\nUsuarios de autenticación encontrados: {len(usuarios_auth)}")
        for usuario in usuarios_auth:
            print(f"  - {usuario.username} (ID: {usuario.id_usuario_auth}, Rol: {usuario.rol.nombre_rol if usuario.rol else 'None'})")

        # Probar login manual
        print("\n=== Probando login ===")
        usuario = UsuarioAuth.query.filter_by(username='admin').first()
        if usuario:
            print(f"Usuario encontrado: {usuario.username}")
            print(f"Contraseña hasheada: {usuario.password_hash[:20]}...")

            # Probar verificación de contraseña
            test_password = "admin123"
            is_valid = usuario.check_password(test_password)
            print(f"Contraseña '{test_password}' válida: {is_valid}")

            if is_valid:
                token = usuario.generate_token()
                print(f"Token generado: {token[:50]}...")
        else:
            print("Usuario 'admin' no encontrado")

if __name__ == "__main__":
    test_auth()