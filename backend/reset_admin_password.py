#!/usr/bin/env python3
"""
Script para resetear la contraseña del admin
"""

from app import create_app
from app.auth.models import UsuarioAuth
from app import db

def reset_admin_password():
    """Resetear contraseña del admin"""
    app = create_app()

    with app.app_context():
        # Buscar usuario admin
        usuario = UsuarioAuth.query.filter_by(username='admin').first()

        if usuario:
            print(f"Usuario encontrado: {usuario.username}")
            print(f"Contraseña anterior hasheada: {usuario.password_hash[:30]}...")

            # Resetear contraseña
            nueva_password = "admin123"
            usuario.set_password(nueva_password)

            db.session.commit()

            print(f"Contraseña reseteada a: {nueva_password}")
            print(f"Nueva contraseña hasheada: {usuario.password_hash[:30]}...")

            # Verificar que funciona
            es_valida = usuario.check_password(nueva_password)
            print(f"Verificación de contraseña: {es_valida}")

        else:
            print("Usuario 'admin' no encontrado")

if __name__ == "__main__":
    reset_admin_password()