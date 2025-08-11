#!/usr/bin/env python3
"""
Script para configurar la base de datos del SGRI
Permite elegir entre SQLite (recomendado para desarrollo) y MySQL
"""

import os
import sys
from dotenv import load_dotenv

def setup_database():
    """Configurar la base de datos según la elección del usuario"""
    print("🔧 Configuración de Base de Datos del SGRI")
    print("=" * 50)
    
    print("\nOpciones disponibles:")
    print("1. SQLite (Recomendado para desarrollo)")
    print("2. MySQL (Para producción)")
    
    while True:
        choice = input("\nSelecciona una opción (1 o 2): ").strip()
        
        if choice == "1":
            setup_sqlite()
            break
        elif choice == "2":
            setup_mysql()
            break
        else:
            print("❌ Opción inválida. Por favor selecciona 1 o 2.")

def setup_sqlite():
    """Configurar SQLite"""
    print("\n📁 Configurando SQLite...")
    
    # Crear archivo .env con configuración de SQLite
    env_content = """SECRET_KEY=sgri_secret_key_2024
DATABASE_URL=sqlite:///sgri.db
"""
    
    with open('.env', 'w') as f:
        f.write(env_content)
    
    print("✅ Configuración de SQLite completada")
    print("📝 Archivo .env creado con configuración de SQLite")
    print("💡 La base de datos se creará automáticamente en sgri.db")

def setup_mysql():
    """Configurar MySQL"""
    print("\n🐬 Configurando MySQL...")
    
    print("\nPor favor proporciona la información de conexión a MySQL:")
    
    host = input("Host (default: localhost): ").strip() or "localhost"
    port = input("Puerto (default: 3306): ").strip() or "3306"
    database = input("Base de datos (default: sgri_db_final_v2): ").strip() or "sgri_db_final_v2"
    username = input("Usuario MySQL: ").strip()
    password = input("Contraseña MySQL: ").strip()
    
    # Crear archivo .env con configuración de MySQL
    env_content = f"""SECRET_KEY=sgri_secret_key_2024
DATABASE_URL=mysql+mysqlconnector://{username}:{password}@{host}:{port}/{database}?auth_plugin=mysql_native_password
"""
    
    with open('.env', 'w') as f:
        f.write(env_content)
    
    print("\n✅ Configuración de MySQL completada")
    print("📝 Archivo .env creado con configuración de MySQL")
    print("⚠️  Asegúrate de que:")
    print("   - MySQL esté instalado y ejecutándose")
    print("   - La base de datos exista")
    print("   - El usuario tenga permisos")

def create_database():
    """Crear la base de datos e inicializar tablas"""
    print("\n🗄️  Inicializando base de datos...")
    
    try:
        # Importar después de configurar el entorno
        from app import create_app, db
        from app.models import UsuarioSistema, Activo, Riesgo, RiesgoActivo, Incidente
        
        app = create_app()
        
        with app.app_context():
            print("📋 Creando tablas...")
            db.create_all()
            print("✅ Tablas creadas exitosamente")
            
            # Verificar si ya hay datos
            if UsuarioSistema.query.count() == 0:
                print("📊 Creando datos de ejemplo...")
                create_sample_data()
                print("✅ Datos de ejemplo creados exitosamente")
            else:
                print("ℹ️  La base de datos ya contiene datos")
            
            print("🎉 Base de datos inicializada correctamente!")
            
    except Exception as e:
        print(f"❌ Error al inicializar la base de datos: {str(e)}")
        print("\n💡 Soluciones posibles:")
        print("   - Verificar la configuración en .env")
        print("   - Para MySQL: asegurar que el servicio esté ejecutándose")
        print("   - Para SQLite: verificar permisos de escritura")

def create_sample_data():
    """Crear datos de ejemplo"""
    from app.models import UsuarioSistema, Activo, Riesgo, RiesgoActivo, Incidente
    from datetime import datetime
    
    # Crear usuarios de ejemplo
    usuarios = [
        UsuarioSistema(
            nombre="Juan Pérez",
            email="juan.perez@empresa.com",
            departamento="TI",
            rol="Administrador"
        ),
        UsuarioSistema(
            nombre="María García",
            email="maria.garcia@empresa.com",
            departamento="TI",
            rol="Técnico"
        ),
        UsuarioSistema(
            nombre="Carlos López",
            email="carlos.lopez@empresa.com",
            departamento="Operaciones",
            rol="Responsable"
        )
    ]
    
    for usuario in usuarios:
        db.session.add(usuario)
    
    db.session.commit()
    print(f"  - {len(usuarios)} usuarios creados")
    
    # Crear activos de ejemplo
    activos = [
        Activo(
            Nombre="Servidor Web Principal",
            Descripcion="Servidor web para la aplicación principal de la empresa",
            Tipo_Activo="Infraestructura",
            subtipo_activo="Servidor",
            ID_Propietario=1,
            ID_Custodio=2,
            Nivel_Clasificacion_Confidencialidad="Uso Interno",
            Nivel_Clasificacion_Integridad="Media",
            Nivel_Clasificacion_Disponibilidad="Alta",
            nivel_criticidad_negocio="Alto",
            estado_activo="Activo",
            requiere_backup=True,
            frecuencia_backup_general="Diario",
            tiempo_retencion_general="30 días"
        ),
        Activo(
            Nombre="Base de Datos Principal",
            Descripcion="Base de datos principal que almacena información crítica",
            Tipo_Activo="Infraestructura",
            subtipo_activo="Base de Datos",
            ID_Propietario=1,
            ID_Custodio=1,
            Nivel_Clasificacion_Confidencialidad="Confidencial",
            Nivel_Clasificacion_Integridad="Alta",
            Nivel_Clasificacion_Disponibilidad="Alta",
            nivel_criticidad_negocio="Crítico",
            estado_activo="Activo",
            requiere_backup=True,
            frecuencia_backup_general="Cada 4 horas",
            tiempo_retencion_general="90 días"
        ),
        Activo(
            Nombre="Aplicación ERP",
            Descripcion="Aplicación de gestión empresarial",
            Tipo_Activo="Software",
            subtipo_activo="Aplicación",
            ID_Propietario=3,
            ID_Custodio=2,
            Nivel_Clasificacion_Confidencialidad="Uso Interno",
            Nivel_Clasificacion_Integridad="Media",
            Nivel_Clasificacion_Disponibilidad="Media",
            nivel_criticidad_negocio="Medio",
            estado_activo="Activo",
            requiere_backup=True,
            frecuencia_backup_general="Semanal",
            tiempo_retencion_general="60 días"
        )
    ]
    
    for activo in activos:
        db.session.add(activo)
    
    db.session.commit()
    print(f"  - {len(activos)} activos creados")
    
    # Crear riesgos de ejemplo
    riesgos = [
        Riesgo(
            nombre_riesgo="Pérdida de datos críticos",
            descripcion="Riesgo de pérdida de datos por fallo del sistema de backup",
            tipo_riesgo="Técnico",
            nivel_riesgo="Alto",
            estado="Activo"
        ),
        Riesgo(
            nombre_riesgo="Interrupción del servicio",
            descripcion="Riesgo de interrupción del servicio por fallo de infraestructura",
            tipo_riesgo="Operacional",
            nivel_riesgo="Medio",
            estado="Activo"
        ),
        Riesgo(
            nombre_riesgo="Acceso no autorizado",
            descripcion="Riesgo de acceso no autorizado a sistemas críticos",
            tipo_riesgo="Seguridad",
            nivel_riesgo="Alto",
            estado="Activo"
        )
    ]
    
    for riesgo in riesgos:
        db.session.add(riesgo)
    
    db.session.commit()
    print(f"  - {len(riesgos)} riesgos creados")
    
    # Asociar riesgos a activos
    asociaciones = [
        RiesgoActivo(
            id_riesgo=1,
            ID_Activo=2,  # Base de Datos Principal
            probabilidad=3,
            impacto=5,
            nivel_riesgo_calculado="Alto",
            medidas_mitigacion="Backup automático diario y redundancia de almacenamiento"
        ),
        RiesgoActivo(
            id_riesgo=2,
            ID_Activo=1,  # Servidor Web Principal
            probabilidad=2,
            impacto=4,
            nivel_riesgo_calculado="Medio",
            medidas_mitigacion="Monitoreo continuo y redundancia de servidores"
        ),
        RiesgoActivo(
            id_riesgo=3,
            ID_Activo=2,  # Base de Datos Principal
            probabilidad=2,
            impacto=5,
            nivel_riesgo_calculado="Alto",
            medidas_mitigacion="Autenticación multifactor y auditoría de accesos"
        )
    ]
    
    for asociacion in asociaciones:
        db.session.add(asociacion)
    
    db.session.commit()
    print(f"  - {len(asociaciones)} asociaciones riesgo-activo creadas")
    
    # Crear incidentes de ejemplo
    incidentes = [
        Incidente(
            titulo="Caída del servidor web",
            descripcion="El servidor web principal no responde durante 30 minutos",
            tipo_incidente="Disponibilidad",
            severidad="Media",
            estado="Resuelto",
            ID_Activo=1,
            responsable="Equipo de Infraestructura",
            acciones_correctivas="Servicios reiniciados y monitoreo mejorado"
        ),
        Incidente(
            titulo="Acceso no autorizado detectado",
            descripcion="Se detectó un intento de acceso no autorizado a la base de datos",
            tipo_incidente="Seguridad",
            severidad="Alta",
            estado="En Proceso",
            ID_Activo=2,
            responsable="Equipo de Seguridad",
            acciones_correctivas="Bloqueo de IP y revisión de logs"
        )
    ]
    
    for incidente in incidentes:
        db.session.add(incidente)
    
    db.session.commit()
    print(f"  - {len(incidentes)} incidentes creados")

if __name__ == "__main__":
    load_dotenv()
    
    # Verificar si ya existe configuración
    if os.path.exists('.env'):
        print("📝 Archivo .env encontrado")
        response = input("¿Deseas reconfigurar la base de datos? (s/n): ").strip().lower()
        if response != 's':
            print("🔄 Usando configuración existente...")
            create_database()
            sys.exit(0)
    
    setup_database()
    create_database() 