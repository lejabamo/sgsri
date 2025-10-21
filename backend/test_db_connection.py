#!/usr/bin/env python3
"""
Script para verificar la conexión a la base de datos y probar consultas
"""

from app import create_app
from app.models import db, UsuarioSistema, Activo, Riesgo, Incidente
from sqlalchemy import text

def test_database_connection():
    """Probar la conexión a la base de datos"""
    print("🔍 VERIFICANDO CONEXIÓN A LA BASE DE DATOS")
    print("=" * 50)
    
    app = create_app()
    
    with app.app_context():
        try:
            # Probar conexión básica
            result = db.session.execute(text("SELECT 1"))
            print("✅ Conexión a la base de datos: EXITOSA")
            
            # Verificar si las tablas existen
            tables_to_check = ['usuarios_sistema', 'activos', 'riesgos', 'incidentes']
            
            for table in tables_to_check:
                try:
                    result = db.session.execute(text(f"SELECT COUNT(*) FROM {table}"))
                    count = result.scalar()
                    print(f"✅ Tabla '{table}': EXISTE ({count} registros)")
                except Exception as e:
                    print(f"❌ Tabla '{table}': ERROR - {str(e)}")
            
            # Probar consultas específicas
            print("\n🔍 PROBANDO CONSULTAS ESPECÍFICAS")
            print("-" * 30)
            
            # Probar consulta de usuarios
            try:
                usuarios = UsuarioSistema.query.all()
                print(f"✅ Consulta UsuarioSistema: {len(usuarios)} usuarios encontrados")
            except Exception as e:
                print(f"❌ Consulta UsuarioSistema: ERROR - {str(e)}")
            
            # Probar consulta de activos
            try:
                activos = Activo.query.all()
                print(f"✅ Consulta Activo: {len(activos)} activos encontrados")
            except Exception as e:
                print(f"❌ Consulta Activo: ERROR - {str(e)}")
            
            # Probar consulta de riesgos
            try:
                riesgos = Riesgo.query.all()
                print(f"✅ Consulta Riesgo: {len(riesgos)} riesgos encontrados")
            except Exception as e:
                print(f"❌ Consulta Riesgo: ERROR - {str(e)}")
            
            # Probar consulta de incidentes
            try:
                incidentes = Incidente.query.all()
                print(f"✅ Consulta Incidente: {len(incidentes)} incidentes encontrados")
            except Exception as e:
                print(f"❌ Consulta Incidente: ERROR - {str(e)}")
            
            # Probar consulta con JOIN
            try:
                result = db.session.execute(text("""
                    SELECT COUNT(*) 
                    FROM usuarios_sistema u 
                    LEFT JOIN activos a ON u.id_usuario = a.ID_Propietario
                """))
                count = result.scalar()
                print(f"✅ Consulta JOIN: EXITOSA ({count} registros)")
            except Exception as e:
                print(f"❌ Consulta JOIN: ERROR - {str(e)}")
                
        except Exception as e:
            print(f"❌ Error de conexión: {str(e)}")
            import traceback
            print(f"Traceback: {traceback.format_exc()}")

if __name__ == "__main__":
    test_database_connection()
