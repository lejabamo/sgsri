#!/usr/bin/env python3
"""
Script para cargar vulnerabilidades clasificadas basadas en estándares 
de seguridad y guías del MinTIC Colombia
"""

import sys
import os
from datetime import datetime, date

# Agregar el directorio del proyecto al path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from app import create_app, db
from app.models import db

def load_vulnerabilidades():
    """Cargar vulnerabilidades clasificadas para búsqueda inteligente"""
    
    app = create_app()
    
    with app.app_context():
        # Verificar si ya existen vulnerabilidades
        existing_vulns = db.session.execute(db.text("SELECT COUNT(*) FROM vulnerabilidades")).scalar()
        if existing_vulns > 0:
            print(f"Ya existen {existing_vulns} vulnerabilidades en la base de datos.")
            return
        
        # Vulnerabilidades clasificadas basadas en estándares de seguridad
        vulnerabilidades_data = [
            # VULNERABILIDADES DE AUTENTICACIÓN Y AUTORIZACIÓN
            {
                'nombre': 'Contraseñas Débiles',
                'descripcion': 'Uso de contraseñas que no cumplen con políticas de complejidad',
                'categoria': 'Autenticación',
                'severidad': 'Media',
                'cve_referencia': 'CWE-521',
                'descripcion_tecnica': 'Contraseñas que no cumplen con requisitos de longitud, complejidad o no se cambian regularmente',
                'impacto_potencial': 'Acceso no autorizado a cuentas de usuario y sistemas',
                'controles_recomendados': 'Políticas de contraseñas robustas, autenticación multifactor, gestión de identidades'
            },
            {
                'nombre': 'Falta de Autenticación Multifactor',
                'descripcion': 'Ausencia de autenticación de dos factores en sistemas críticos',
                'categoria': 'Autenticación',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-308',
                'descripcion_tecnica': 'Sistemas que solo requieren usuario y contraseña para autenticación',
                'impacto_potencial': 'Compromiso de cuentas mediante robo de credenciales',
                'controles_recomendados': 'Implementación de MFA, tokens hardware, biometría'
            },
            {
                'nombre': 'Privilegios Excesivos',
                'descripcion': 'Usuarios con permisos superiores a los requeridos para sus funciones',
                'categoria': 'Autorización',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-250',
                'descripcion_tecnica': 'Principio de menor privilegio no aplicado correctamente',
                'impacto_potencial': 'Acceso no autorizado a datos y funciones críticas',
                'controles_recomendados': 'Revisión periódica de permisos, segregación de funciones, control de acceso basado en roles'
            },
            
            # VULNERABILIDADES DE RED Y COMUNICACIONES
            {
                'nombre': 'Comunicaciones No Cifradas',
                'descripcion': 'Transmisión de datos sensibles sin cifrado',
                'categoria': 'Comunicaciones',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-319',
                'descripcion_tecnica': 'Protocolos de comunicación sin cifrado (HTTP, FTP, Telnet)',
                'impacto_potencial': 'Interceptación y modificación de datos en tránsito',
                'controles_recomendados': 'HTTPS, VPN, cifrado de extremo a extremo, certificados SSL/TLS'
            },
            {
                'nombre': 'Puertos y Servicios Innecesarios',
                'descripcion': 'Puertos de red abiertos que exponen servicios no utilizados',
                'categoria': 'Red',
                'severidad': 'Media',
                'cve_referencia': 'CWE-16',
                'descripcion_tecnica': 'Servicios de red ejecutándose en puertos no requeridos',
                'impacto_potencial': 'Superficie de ataque ampliada, acceso no autorizado',
                'controles_recomendados': 'Firewall, cierre de puertos innecesarios, hardening de sistemas'
            },
            
            # VULNERABILIDADES DE SOFTWARE Y APLICACIONES
            {
                'nombre': 'Software Desactualizado',
                'descripcion': 'Aplicaciones y sistemas operativos con versiones obsoletas',
                'categoria': 'Software',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-1104',
                'descripcion_tecnica': 'Falta de parches de seguridad y actualizaciones',
                'impacto_potencial': 'Explotación de vulnerabilidades conocidas',
                'controles_recomendados': 'Gestión de parches, actualizaciones automáticas, inventario de software'
            },
            {
                'nombre': 'Inyección SQL',
                'descripcion': 'Vulnerabilidad que permite ejecutar consultas SQL maliciosas',
                'categoria': 'Aplicación',
                'severidad': 'Crítica',
                'cve_referencia': 'CWE-89',
                'descripcion_tecnica': 'Falta de validación y sanitización de entradas de usuario',
                'impacto_potencial': 'Acceso no autorizado a bases de datos, robo de información',
                'controles_recomendados': 'Consultas preparadas, validación de entrada, WAF'
            },
            {
                'nombre': 'Cross-Site Scripting (XSS)',
                'descripcion': 'Vulnerabilidad que permite inyectar código JavaScript malicioso',
                'categoria': 'Aplicación',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-79',
                'descripcion_tecnica': 'Falta de sanitización de contenido generado dinámicamente',
                'impacto_potencial': 'Robo de sesiones, redirección maliciosa, defacement',
                'controles_recomendados': 'Validación de entrada, encoding de salida, CSP headers'
            },
            
            # VULNERABILIDADES DE ALMACENAMIENTO Y DATOS
            {
                'nombre': 'Datos Sensibles en Logs',
                'descripcion': 'Registro de información confidencial en archivos de log',
                'categoria': 'Datos',
                'severidad': 'Media',
                'cve_referencia': 'CWE-532',
                'descripcion_tecnica': 'Contraseñas, tokens o datos personales en logs del sistema',
                'impacto_potencial': 'Exposición de información sensible, violación de privacidad',
                'controles_recomendados': 'Sanitización de logs, políticas de logging, enmascaramiento de datos'
            },
            {
                'nombre': 'Falta de Cifrado en Reposo',
                'descripcion': 'Datos almacenados sin cifrado en discos y bases de datos',
                'categoria': 'Datos',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-311',
                'descripcion_tecnica': 'Información sensible almacenada en texto plano',
                'impacto_potencial': 'Acceso no autorizado a datos en caso de robo o pérdida',
                'controles_recomendados': 'Cifrado de discos, cifrado de bases de datos, gestión de claves'
            },
            
            # VULNERABILIDADES DE CONFIGURACIÓN
            {
                'nombre': 'Configuraciones por Defecto',
                'descripcion': 'Sistemas con configuraciones de seguridad por defecto',
                'categoria': 'Configuración',
                'severidad': 'Media',
                'cve_referencia': 'CWE-1188',
                'descripcion_tecnica': 'Contraseñas y configuraciones predeterminadas no modificadas',
                'impacto_potencial': 'Acceso no autorizado mediante credenciales conocidas',
                'controles_recomendados': 'Hardening de sistemas, cambio de credenciales por defecto, configuración segura'
            },
            {
                'nombre': 'Falta de Hardening',
                'descripcion': 'Sistemas sin configuración de seguridad adecuada',
                'categoria': 'Configuración',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-16',
                'descripcion_tecnica': 'Servicios innecesarios habilitados, configuraciones permisivas',
                'impacto_potencial': 'Superficie de ataque ampliada, acceso no autorizado',
                'controles_recomendados': 'Guías de hardening, configuración basada en estándares, auditorías de configuración'
            },
            
            # VULNERABILIDADES DE MONITOREO Y DETECCIÓN
            {
                'nombre': 'Falta de Monitoreo de Seguridad',
                'descripcion': 'Ausencia de sistemas de monitoreo y detección de incidentes',
                'categoria': 'Monitoreo',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-778',
                'descripcion_tecnica': 'No hay sistemas de SIEM, logging insuficiente o inexistente',
                'impacto_potencial': 'Detección tardía de incidentes, respuesta inadecuada',
                'controles_recomendados': 'SIEM, logging centralizado, alertas automáticas, análisis de comportamiento'
            },
            {
                'nombre': 'Logs Insuficientes',
                'descripcion': 'Registro inadecuado de eventos de seguridad',
                'categoria': 'Monitoreo',
                'severidad': 'Media',
                'cve_referencia': 'CWE-778',
                'descripcion_tecnica': 'Falta de logging de eventos críticos de seguridad',
                'impacto_potencial': 'Dificultad para investigar incidentes, falta de evidencia',
                'controles_recomendados': 'Políticas de logging, retención de logs, análisis forense'
            },
            
            # VULNERABILIDADES DE RESPALDO Y RECUPERACIÓN
            {
                'nombre': 'Falta de Respaldos',
                'descripcion': 'Ausencia de estrategia de respaldo y recuperación',
                'categoria': 'Respaldo',
                'severidad': 'Crítica',
                'cve_referencia': 'CWE-654',
                'descripcion_tecnica': 'No hay respaldos regulares de datos críticos',
                'impacto_potencial': 'Pérdida permanente de datos, interrupción de servicios',
                'controles_recomendados': 'Respaldos automáticos, almacenamiento fuera del sitio, pruebas de recuperación'
            },
            {
                'nombre': 'Respaldos No Verificados',
                'descripcion': 'Respaldos que no han sido probados para recuperación',
                'categoria': 'Respaldo',
                'severidad': 'Alta',
                'cve_referencia': 'CWE-654',
                'descripcion_tecnica': 'Respaldos corruptos o incompletos sin verificación',
                'impacto_potencial': 'Falla en la recuperación durante incidentes',
                'controles_recomendados': 'Pruebas regulares de recuperación, verificación de integridad'
            }
        ]
        
        # Crear tabla de vulnerabilidades si no existe
        create_table_sql = """
        CREATE TABLE IF NOT EXISTS vulnerabilidades (
            id_vulnerabilidad INT AUTO_INCREMENT PRIMARY KEY,
            nombre VARCHAR(255) NOT NULL,
            descripcion TEXT,
            categoria VARCHAR(100),
            severidad ENUM('Baja', 'Media', 'Alta', 'Crítica'),
            cve_referencia VARCHAR(50),
            descripcion_tecnica TEXT,
            impacto_potencial TEXT,
            controles_recomendados TEXT,
            fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )
        """
        
        db.session.execute(db.text(create_table_sql))
        
        # Insertar vulnerabilidades
        for vuln_data in vulnerabilidades_data:
            insert_sql = """
            INSERT INTO vulnerabilidades 
            (nombre, descripcion, categoria, severidad, cve_referencia, descripcion_tecnica, impacto_potencial, controles_recomendados)
            VALUES (:nombre, :descripcion, :categoria, :severidad, :cve_referencia, :descripcion_tecnica, :impacto_potencial, :controles_recomendados)
            """
            
            db.session.execute(db.text(insert_sql), {
                'nombre': vuln_data['nombre'],
                'descripcion': vuln_data['descripcion'],
                'categoria': vuln_data['categoria'],
                'severidad': vuln_data['severidad'],
                'cve_referencia': vuln_data['cve_referencia'],
                'descripcion_tecnica': vuln_data['descripcion_tecnica'],
                'impacto_potencial': vuln_data['impacto_potencial'],
                'controles_recomendados': vuln_data['controles_recomendados']
            })
        
        try:
            db.session.commit()
            print(f"✅ Se cargaron {len(vulnerabilidades_data)} vulnerabilidades clasificadas")
            print("\n📋 Resumen de vulnerabilidades cargadas:")
            for i, vuln_data in enumerate(vulnerabilidades_data, 1):
                print(f"  {i}. {vuln_data['nombre']} ({vuln_data['categoria']} - {vuln_data['severidad']})")
        except Exception as e:
            db.session.rollback()
            print(f"❌ Error al cargar vulnerabilidades: {e}")

if __name__ == "__main__":
    load_vulnerabilidades()



















