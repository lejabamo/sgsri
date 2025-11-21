#!/usr/bin/env python3
"""
Generador de Datos de Prueba para Test Manual
SGSRI - Sistema Predictivo de Riesgos ISO
"""

import sys
import os
from datetime import datetime, timedelta

# Agregar el directorio del proyecto al path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import create_app
from app.models import Activo, evaluacion_riesgo_activo, Riesgo, niveles_probabilidad, niveles_impacto, nivelesriesgo
from app import db

def generate_test_scenarios():
    """Generar escenarios de prueba específicos"""
    print("Generando escenarios de prueba para test manual...")
    
    app = create_app()
    with app.app_context():
        try:
            # Obtener datos existentes
            activos = Activo.query.all()
            riesgos = Riesgo.query.all()
            
            print(f"Activos disponibles: {len(activos)}")
            print(f"Riesgos disponibles: {len(riesgos)}")
            
            # Generar escenarios de prueba
            scenarios = []
            
            # Escenario 1: Activo con riesgo de DDoS
            scenario_1 = {
                'activo': 'SERVIDOR-WEB-01',
                'tipo': 'Hardware',
                'criticidad': 'Alto',
                'amenaza': 'Ataque de denegación de servicio (DDoS)',
                'vulnerabilidad': 'Falta de protección contra DDoS',
                'descripcion': 'El servidor web está expuesto a ataques DDoS que pueden interrumpir el servicio',
                'probabilidad_inherente': 'Probable',
                'impacto_inherente': 'Mayor',
                'justificacion_inherente': 'Los ataques DDoS son frecuentes y pueden causar interrupciones significativas',
                'controles_sugeridos': [
                    'Implementar protección DDoS (Cloudflare/AWS Shield)',
                    'Configurar balanceadores de carga',
                    'Monitoreo de tráfico en tiempo real',
                    'Plan de respuesta a incidentes'
                ],
                'probabilidad_residual': 'Posible',
                'impacto_residual': 'Moderado',
                'justificacion_residual': 'Con protecciones implementadas, el riesgo se reduce pero no se elimina',
                'tratamiento': 'Mitigar',
                'responsable': 'Equipo de Seguridad',
                'presupuesto': '$10,000'
            }
            
            # Escenario 2: Activo con riesgo de acceso no autorizado
            scenario_2 = {
                'activo': 'BASE-DATOS-01',
                'tipo': 'Hardware',
                'criticidad': 'Crítico',
                'amenaza': 'Acceso no autorizado a base de datos',
                'vulnerabilidad': 'Falta de autenticación multifactor',
                'descripcion': 'Riesgo de acceso no autorizado a datos sensibles debido a la ausencia de autenticación de dos factores',
                'probabilidad_inherente': 'Ocasional',
                'impacto_inherente': 'Catastrófico',
                'justificacion_inherente': 'El acceso no autorizado puede ocurrir ocasionalmente pero tendría consecuencias catastróficas',
                'controles_sugeridos': [
                    'Implementar autenticación multifactor',
                    'Cifrado de datos en reposo',
                    'Auditoría de accesos',
                    'Segregación de redes'
                ],
                'probabilidad_residual': 'Improbable',
                'impacto_residual': 'Mayor',
                'justificacion_residual': 'Con controles implementados, la probabilidad se reduce significativamente',
                'tratamiento': 'Mitigar',
                'responsable': 'Equipo de Seguridad',
                'presupuesto': '$15,000'
            }
            
            # Escenario 3: Activo con riesgo de malware
            scenario_3 = {
                'activo': 'ESTACION-TRABAJO-01',
                'tipo': 'Hardware',
                'criticidad': 'Medio',
                'amenaza': 'Infección por malware',
                'vulnerabilidad': 'Falta de antivirus actualizado',
                'descripcion': 'Las estaciones de trabajo están expuestas a infecciones por malware debido a la falta de protección antivirus',
                'probabilidad_inherente': 'Frecuente',
                'impacto_inherente': 'Moderado',
                'justificacion_inherente': 'El malware es frecuente pero el impacto en estaciones individuales es moderado',
                'controles_sugeridos': [
                    'Instalar antivirus empresarial',
                    'Actualizaciones automáticas',
                    'Políticas de uso de USB',
                    'Capacitación de usuarios'
                ],
                'probabilidad_residual': 'Ocasional',
                'impacto_residual': 'Menor',
                'justificacion_residual': 'Con antivirus y políticas, el riesgo se reduce considerablemente',
                'tratamiento': 'Mitigar',
                'responsable': 'Equipo de TI',
                'presupuesto': '$3,000'
            }
            
            scenarios = [scenario_1, scenario_2, scenario_3]
            
            # Guardar escenarios en archivo
            save_scenarios_to_file(scenarios)
            
            print("Escenarios de prueba generados exitosamente")
            return scenarios
            
        except Exception as e:
            print(f"Error generando escenarios: {str(e)}")
            return []

def save_scenarios_to_file(scenarios):
    """Guardar escenarios en archivo para referencia"""
    try:
        os.makedirs('backend/tests', exist_ok=True)
        
        with open('backend/tests/test_scenarios.json', 'w', encoding='utf-8') as f:
            import json
            json.dump(scenarios, f, indent=2, ensure_ascii=False, default=str)
        
        print("Escenarios guardados en: backend/tests/test_scenarios.json")
        
    except Exception as e:
        print(f"Error guardando escenarios: {str(e)}")

def print_test_instructions():
    """Imprimir instrucciones para el test manual"""
    print("\n" + "="*80)
    print("INSTRUCCIONES PARA TEST MANUAL")
    print("="*80)
    
    print("\n1. LANZAR EL SISTEMA:")
    print("   Terminal 1: cd backend && python run.py")
    print("   Terminal 2: cd frontend && npm run dev")
    print("   URL: http://localhost:5173/wizard")
    
    print("\n2. ESCENARIOS DE PRUEBA:")
    print("   - Escenario 1: Evaluación completa de activo nuevo")
    print("   - Escenario 2: Evaluación parcial (estado naranja)")
    print("   - Escenario 3: Predicción de riesgo")
    print("   - Escenario 4: Exportación PDF")
    print("   - Escenario 5: Consulta de conocimiento")
    
    print("\n3. DATOS DE PRUEBA ESPECÍFICOS:")
    print("   Ver archivo: backend/tests/manual_test_scenarios.md")
    
    print("\n4. CRITERIOS DE EVALUACIÓN:")
    print("   - Funcionalidad Básica (40 puntos)")
    print("   - Calidad de Predicciones (30 puntos)")
    print("   - Experiencia de Usuario (20 puntos)")
    print("   - Robustez del Sistema (10 puntos)")
    
    print("\n5. REPORTE FINAL:")
    print("   - Escenarios completados: ✅/❌")
    print("   - Problemas encontrados")
    print("   - Sugerencias de mejora")
    print("   - Calificación: X/100")
    print("   - Recomendación: Proceder/No proceder")
    
    print("\n" + "="*80)
    print("¡LISTO PARA COMENZAR LAS PRUEBAS MANUALES!")
    print("="*80)

def main():
    """Función principal"""
    print("Generador de Datos de Prueba - SGSRI")
    print("="*50)
    
    # Generar escenarios
    scenarios = generate_test_scenarios()
    
    if scenarios:
        print(f"\nEscenarios generados: {len(scenarios)}")
        for i, scenario in enumerate(scenarios, 1):
            print(f"  {i}. {scenario['activo']} - {scenario['amenaza']}")
    
    # Imprimir instrucciones
    print_test_instructions()
    
    return scenarios

if __name__ == "__main__":
    main()
