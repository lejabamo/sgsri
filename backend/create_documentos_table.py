#!/usr/bin/env python3
"""
Script para crear la tabla de documentos adjuntos en la base de datos
"""

import sys
import os

# Agregar el directorio del proyecto al path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from app import create_app, db
from app.modelos.documentos import DocumentoAdjunto

def create_documentos_table():
    """Crear la tabla de documentos adjuntos"""
    app = create_app()
    
    with app.app_context():
        try:
            # Crear la tabla
            db.create_all()
            print("Tabla 'documentos_adjuntos' creada exitosamente")
            
            # Verificar que la tabla existe
            from sqlalchemy import inspect
            inspector = inspect(db.engine)
            tables = inspector.get_table_names()
            
            if 'documentos_adjuntos' in tables:
                print("Verificación: La tabla existe en la base de datos")
                
                # Mostrar estructura de la tabla
                columns = inspector.get_columns('documentos_adjuntos')
                print("\nEstructura de la tabla:")
                for column in columns:
                    print(f"  - {column['name']}: {column['type']}")
                    
            else:
                print("Error: La tabla no se creó correctamente")
                
        except Exception as e:
            print(f"Error al crear la tabla: {str(e)}")
            return False
            
    return True

if __name__ == "__main__":
    print("Creando tabla de documentos adjuntos...")
    success = create_documentos_table()
    
    if success:
        print("\nProceso completado exitosamente")
    else:
        print("\nEl proceso falló")
        sys.exit(1)
