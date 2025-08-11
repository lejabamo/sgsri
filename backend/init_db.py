#!/usr/bin/env python3
"""
Script para inicializar la base de datos del SGRI
Crea todas las tablas necesarias para el sistema
"""

import os
import sys
from dotenv import load_dotenv

# Agregar el directorio backend al path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from app import create_app, db
from app.models import UsuarioSistema, Activo, Riesgo, RiesgoActivo, Incidente

def init_database():
    """Inicializar la base de datos"""
    app = create_app()
    
    with app.app_context():
        print("Creando tablas de la base de datos...")
        db.create_all()
        print("✅ Tablas creadas exitosamente")
        
        # Crear algunos datos de ejemplo
        print("Creando datos de ejemplo...")
        create_sample_data()
        print("✅ Datos de ejemplo creados exitosamente")
        
        print("🎉 Base de datos inicializada correctamente!")

def create_sample_data():
    """Crear datos de ejemplo para el sistema"""
    
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
    init_database() 