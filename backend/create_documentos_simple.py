#!/usr/bin/env python3
"""
Script simple para crear la tabla de documentos adjuntos
"""

import sys
import os

# Agregar el directorio del proyecto al path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from app import create_app, db

def create_documentos_table():
    """Crear la tabla de documentos adjuntos"""
    app = create_app()
    
    with app.app_context():
        try:
            # Crear la tabla usando SQL directo
            sql = """
            CREATE TABLE IF NOT EXISTS documentos_adjuntos (
                id INT AUTO_INCREMENT PRIMARY KEY,
                accion_id VARCHAR(50) NOT NULL,
                nombre_original VARCHAR(255) NOT NULL,
                nombre_archivo VARCHAR(255) NOT NULL UNIQUE,
                tipo_mime VARCHAR(100) NOT NULL,
                tamaño_bytes BIGINT NOT NULL,
                ruta_archivo VARCHAR(500) NOT NULL,
                descripcion TEXT,
                fecha_subida DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                fecha_modificacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                subido_por INT,
                activo BOOLEAN NOT NULL DEFAULT TRUE,
                INDEX idx_accion_id (accion_id),
                INDEX idx_subido_por (subido_por),
                FOREIGN KEY (subido_por) REFERENCES usuarios_auth(id_usuario_auth)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
            """
            
            with db.engine.connect() as connection:
                connection.execute(db.text(sql))
                connection.commit()
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
