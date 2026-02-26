#!/usr/bin/env python3
"""
Script para debuggear los modelos y consultas
"""

from app import create_app
from app.models import db, UsuarioSistema, Activo, Riesgo, Incidente
from sqlalchemy import text

def debug_models():
    """Debuggear los modelos y consultas"""
    print("🔍 DEBUGGEANDO MODELOS Y CONSULTAS")
    print("=" * 50)
    
    app = create_app()
    
    with app.app_context():
        try:
            # Probar consulta SQL directa
            print("1. Probando consulta SQL directa...")
            result = db.session.execute(text("SELECT COUNT(*) FROM usuarios_sistema"))
            count = result.scalar()
            print(f"   ✅ SQL directa: {count} usuarios")
            
            # Probar consulta con SQLAlchemy
            print("2. Probando consulta con SQLAlchemy...")
            usuarios = UsuarioSistema.query.all()
            print(f"   ✅ SQLAlchemy: {len(usuarios)} usuarios")
            
            # Probar consulta con filtros
            print("3. Probando consulta con filtros...")
            usuarios_ti = UsuarioSistema.query.filter_by(departamento='TI').all()
            print(f"   ✅ Filtros: {len(usuarios_ti)} usuarios de TI")
            
            # Probar consulta con distinct
            print("4. Probando consulta distinct...")
            departamentos = db.session.query(UsuarioSistema.departamento).distinct().all()
            print(f"   ✅ Distinct: {len(departamentos)} departamentos únicos")
            
            # Probar consulta de activos
            print("5. Probando consulta de activos...")
            activos = Activo.query.all()
            print(f"   ✅ Activos: {len(activos)} activos")
            
            # Probar consulta de riesgos
            print("6. Probando consulta de riesgos...")
            riesgos = Riesgo.query.all()
            print(f"   ✅ Riesgos: {len(riesgos)} riesgos")
            
            # Probar consulta de incidentes
            print("7. Probando consulta de incidentes...")
            incidentes = Incidente.query.all()
            print(f"   ✅ Incidentes: {len(incidentes)} incidentes")
            
            print("\n✅ TODAS LAS CONSULTAS FUNCIONAN CORRECTAMENTE")
            
        except Exception as e:
            print(f"❌ ERROR: {str(e)}")
            import traceback
            print(f"Traceback: {traceback.format_exc()}")

if __name__ == "__main__":
    debug_models()
