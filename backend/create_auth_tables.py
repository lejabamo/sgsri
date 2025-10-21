#!/usr/bin/env python3
"""
Script para crear las tablas de autenticación en la base de datos
"""

from app import create_app
from app import db
from app.auth.models import Rol, UsuarioAuth, SesionUsuario

def create_auth_tables():
    """Crear tablas de autenticación"""
    app = create_app()
    
    with app.app_context():
        try:
            # Crear todas las tablas
            db.create_all()
            print("✅ Tablas de autenticación creadas correctamente")
            
            # Verificar que las tablas se crearon
            from sqlalchemy import inspect
            inspector = inspect(db.engine)
            tables = inspector.get_table_names()
            
            auth_tables = ['roles_auth', 'usuarios_auth', 'sesiones_usuario']
            for table in auth_tables:
                if table in tables:
                    print(f"✅ Tabla '{table}' creada")
                else:
                    print(f"❌ Tabla '{table}' NO creada")
                    
        except Exception as e:
            print(f"❌ Error creando tablas: {str(e)}")

if __name__ == "__main__":
    create_auth_tables()
