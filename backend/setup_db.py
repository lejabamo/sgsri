#!/usr/bin/env python3
"""
Script para configurar e inicializar la base de datos del SGRI
Este sistema utiliza MySQL como base de datos
"""

import os
import sys
from dotenv import load_dotenv

def setup_database():
    """Configurar la base de datos MySQL"""
    print("🔧 Configuración de Base de Datos del SGRI")
    print("=" * 60)
    print("\n⚠️  Este sistema utiliza MySQL como base de datos")
    setup_mysql()


def setup_mysql():
    """Configurar MySQL"""
    print("\n🐬 Configurando MySQL...")
    
    print("\nPor favor proporciona la información de conexión a MySQL:")
    
    host = input("Host (default: localhost): ").strip() or "localhost"
    port = input("Puerto (default: 3306): ").strip() or "3306"
    database = input("Base de datos (default: sgri): ").strip() or "sgri"
    username = input("Usuario MySQL: ").strip()
    password = input("Contraseña MySQL: ").strip()
    
    # Crear archivo .env con configuración de MySQL
    env_content = f"""SECRET_KEY=sgri_secret_key_2024_production
DB_USER={username}
DB_PASSWORD={password}
DB_HOST={host}
DB_PORT={port}
DB_NAME={database}
FLASK_ENV=production
"""
    
    env_path = os.path.join(os.path.dirname(__file__), '..', '.env')
    with open(env_path, 'w') as f:
        f.write(env_content)
    
    print("\n✅ Configuración de MySQL completada")
    print(f"📝 Archivo .env creado en: {env_path}")
    print("⚠️  Asegúrate de que:")
    print("   - MySQL esté instalado y ejecutándose")
    print("   - La base de datos exista (o se creará automáticamente)")
    print("   - El usuario tenga permisos para crear tablas")

def create_database():
    """Crear la base de datos e inicializar tablas"""
    print("\n🗄️  Inicializando base de datos...")
    
    try:
        # Cargar variables de entorno
        env_path = os.path.join(os.path.dirname(__file__), '..', '.env')
        if os.path.exists(env_path):
            load_dotenv(env_path)
        else:
            load_dotenv()
        
        # Agregar el directorio backend al path
        sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
        
        from app import create_app, db
        from app.models import (
            UsuarioSistema, Activo, Riesgo, RiesgoActivo, Incidente,
            niveles_probabilidad, niveles_impacto, controles_seguridad,
            nivelesriesgo, evaluacion_riesgo_activo,
            Rol, UsuarioAuth, SesionUsuario, DocumentoAdjunto
        )
        
        app = create_app()
        
        with app.app_context():
            print("📋 Creando tablas...")
            db.create_all()
            print("✅ Tablas creadas exitosamente")
            
            # Verificar si ya hay datos
            if UsuarioSistema.query.count() == 0:
                print("📊 Creando datos iniciales...")
                create_initial_data(db)
                print("✅ Datos iniciales creados exitosamente")
            else:
                print("ℹ️  La base de datos ya contiene datos")
            
            print("\n🎉 Base de datos inicializada correctamente!")
            print("\n📌 Próximos pasos:")
            print("   1. Ejecuta el backend: cd backend && python run.py")
            print("   2. Ejecuta el frontend: cd frontend && npm run dev")
            
    except Exception as e:
        print(f"\n❌ Error al inicializar la base de datos: {str(e)}")
        import traceback
        traceback.print_exc()
        print("\n💡 Soluciones posibles:")
        print("   - Verificar la configuración en .env")
        print("   - Para MySQL: asegurar que el servicio esté ejecutándose")
        print("   - Para SQLite: verificar permisos de escritura")
        print("   - Verificar que todas las dependencias estén instaladas")

def create_initial_data(db):
    """Crear datos iniciales del sistema"""
    from app.models import (
        UsuarioSistema, Activo, Riesgo, RiesgoActivo, Incidente,
        niveles_probabilidad, niveles_impacto, controles_seguridad,
        nivelesriesgo, evaluacion_riesgo_activo,
        Rol, UsuarioAuth
    )
    from datetime import datetime, date
    
    # Crear roles
    print("  - Creando roles...")
    roles_data = [
        {'nombre_rol': 'Administrador', 'descripcion': 'Acceso completo al sistema'},
        {'nombre_rol': 'Analista', 'descripcion': 'Puede gestionar riesgos y activos'},
        {'nombre_rol': 'Usuario', 'descripcion': 'Acceso de solo lectura'}
    ]
    
    roles = {}
    for rol_data in roles_data:
        rol = Rol.query.filter_by(nombre_rol=rol_data['nombre_rol']).first()
        if not rol:
            rol = Rol(**rol_data)
            db.session.add(rol)
            db.session.flush()
        roles[rol_data['nombre_rol']] = rol
    
    db.session.commit()
    print(f"    ✓ {len(roles)} roles creados")
    
    # Crear usuarios del sistema
    print("  - Creando usuarios del sistema...")
    usuarios_sistema = [
        UsuarioSistema(
            nombre_completo="Administrador del Sistema",
            email_institucional="admin@sgsri.local",
            puesto_organizacion="Administrador",
            estado_usuario="Activo"
        ),
        UsuarioSistema(
            nombre_completo="Analista de Riesgos",
            email_institucional="analista@sgsri.local",
            puesto_organizacion="Analista",
            estado_usuario="Activo"
        )
    ]
    
    for usuario in usuarios_sistema:
        existing = UsuarioSistema.query.filter_by(email_institucional=usuario.email_institucional).first()
        if not existing:
            db.session.add(usuario)
    
    db.session.commit()
    print(f"    ✓ {len(usuarios_sistema)} usuarios del sistema creados")
    
    # Crear usuarios de autenticación
    print("  - Creando usuarios de autenticación...")
    admin_usuario = UsuarioSistema.query.filter_by(email_institucional="admin@sgsri.local").first()
    if admin_usuario:
        admin_auth = UsuarioAuth.query.filter_by(username='admin').first()
        if not admin_auth:
            admin_auth = UsuarioAuth(
                id_usuario_sistema=admin_usuario.id_usuario,
                username='admin',
                id_rol=roles['Administrador'].id_rol,
                activo=True
            )
            admin_auth.set_password('admin123')  # Cambiar en producción
            db.session.add(admin_auth)
    
    db.session.commit()
    print("    ✓ Usuario admin creado (username: admin, password: admin123)")
    
    # Crear niveles de probabilidad
    print("  - Creando niveles de probabilidad...")
    niveles_prob = [
        {'Nombre': 'Muy Baja', 'Valor': 1, 'Descripcion': 'Muy improbable que ocurra', 'Color_Representacion': '#00FF00'},
        {'Nombre': 'Baja', 'Valor': 2, 'Descripcion': 'Poco probable que ocurra', 'Color_Representacion': '#90EE90'},
        {'Nombre': 'Media', 'Valor': 3, 'Descripcion': 'Probable que ocurra', 'Color_Representacion': '#FFFF00'},
        {'Nombre': 'Alta', 'Valor': 4, 'Descripcion': 'Muy probable que ocurra', 'Color_Representacion': '#FFA500'},
        {'Nombre': 'Muy Alta', 'Valor': 5, 'Descripcion': 'Casi seguro que ocurra', 'Color_Representacion': '#FF0000'}
    ]
    
    for nivel_data in niveles_prob:
        nivel = niveles_probabilidad.query.filter_by(Nombre=nivel_data['Nombre']).first()
        if not nivel:
            nivel = niveles_probabilidad(**nivel_data)
            db.session.add(nivel)
    
    db.session.commit()
    print(f"    ✓ {len(niveles_prob)} niveles de probabilidad creados")
    
    # Crear niveles de impacto
    print("  - Creando niveles de impacto...")
    niveles_imp = [
        {'Nombre': 'Muy Bajo', 'Valor': 1, 'Descripcion': 'Impacto mínimo', 'Color_Representacion': '#00FF00'},
        {'Nombre': 'Bajo', 'Valor': 2, 'Descripcion': 'Impacto bajo', 'Color_Representacion': '#90EE90'},
        {'Nombre': 'Medio', 'Valor': 3, 'Descripcion': 'Impacto medio', 'Color_Representacion': '#FFFF00'},
        {'Nombre': 'Alto', 'Valor': 4, 'Descripcion': 'Impacto alto', 'Color_Representacion': '#FFA500'},
        {'Nombre': 'Muy Alto', 'Valor': 5, 'Descripcion': 'Impacto crítico', 'Color_Representacion': '#FF0000'}
    ]
    
    for nivel_data in niveles_imp:
        nivel = niveles_impacto.query.filter_by(Nombre=nivel_data['Nombre']).first()
        if not nivel:
            nivel = niveles_impacto(**nivel_data)
            db.session.add(nivel)
    
    db.session.commit()
    print(f"    ✓ {len(niveles_imp)} niveles de impacto creados")
    
    # Crear niveles de riesgo
    print("  - Creando niveles de riesgo...")
    niveles_riesgo = [
        {'Nombre': 'Bajo', 'Valor_Min': 1, 'Valor_Max': 8, 'Color_Representacion': '#00FF00', 
         'Acciones_Sugeridas': 'Monitoreo periódico', 'Descripcion': 'Riesgo bajo'},
        {'Nombre': 'Medio', 'Valor_Min': 9, 'Valor_Max': 15, 'Color_Representacion': '#FFFF00',
         'Acciones_Sugeridas': 'Implementar controles básicos', 'Descripcion': 'Riesgo medio'},
        {'Nombre': 'Alto', 'Valor_Min': 16, 'Valor_Max': 25, 'Color_Representacion': '#FF0000',
         'Acciones_Sugeridas': 'Implementar controles inmediatos y plan de mitigación', 'Descripcion': 'Riesgo alto'}
    ]
    
    for nivel_data in niveles_riesgo:
        nivel = nivelesriesgo.query.filter_by(Nombre=nivel_data['Nombre']).first()
        if not nivel:
            nivel = nivelesriesgo(**nivel_data)
            db.session.add(nivel)
    
    db.session.commit()
    print(f"    ✓ {len(niveles_riesgo)} niveles de riesgo creados")
    
    print("\n✅ Datos iniciales creados correctamente")

if __name__ == "__main__":
    print("\n" + "=" * 60)
    print("🚀 Configuración e Inicialización de Base de Datos SGRI")
    print("=" * 60)
    
    # Verificar si ya existe configuración
    env_path = os.path.join(os.path.dirname(__file__), '..', '.env')
    if os.path.exists(env_path):
        print("\n📝 Archivo .env encontrado")
        response = input("¿Deseas reconfigurar la base de datos? (s/n): ").strip().lower()
        if response != 's':
            print("🔄 Usando configuración existente...")
            create_database()
            sys.exit(0)
    
    setup_database()
    create_database()

