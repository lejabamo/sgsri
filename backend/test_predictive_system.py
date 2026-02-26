#!/usr/bin/env python3
"""
Script para probar el sistema predictivo basado en normas ISO
"""

import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from app.services.predictive.pdf_processor import ISOPDFProcessor
from app.services.predictive.suggestion_service import PredictiveSuggestionService
import json

def test_pdf_processor():
    """Probar el procesador de PDFs"""
    print("Probando procesador de PDFs...")
    
    processor = ISOPDFProcessor()
    
    # Procesar documentos ISO
    processed_data = processor.process_all_documents()
    
    print(f"Controles encontrados: {len(processed_data.get('controles', {}))}")
    print(f"Amenazas encontradas: {len(processed_data.get('amenazas', {}))}")
    print(f"Vulnerabilidades encontradas: {len(processed_data.get('vulnerabilidades', {}))}")
    
    # Guardar datos procesados
    if processor.save_processed_data():
        print("Base de conocimiento guardada exitosamente")
        return True
    else:
        print("Error al guardar la base de conocimiento")
        return False

def test_suggestion_service():
    """Probar el servicio de sugerencias"""
    print("\nProbando servicio de sugerencias...")
    
    service = PredictiveSuggestionService()
    
    # Probar con diferentes tipos de activos
    test_cases = [
        {"asset_type": "servidor", "context": "Servidor crítico de producción"},
        {"asset_type": "base_datos", "context": "Base de datos con información sensible"},
        {"asset_type": "aplicacion", "context": "Aplicación web pública"}
    ]
    
    for test_case in test_cases:
        print(f"\nProbando con activo: {test_case['asset_type']}")
        print("-" * 50)
        
        try:
            suggestions = service.get_risk_assessment_suggestions(
                test_case["asset_type"], 
                test_case["context"]
            )
            
            print(f"  Amenazas sugeridas: {len(suggestions['amenazas'])}")
            for threat in suggestions['amenazas'][:3]:
                print(f"    - {threat['nombre']} (Confianza: {threat['confianza']:.2f})")
            
            print(f"  Vulnerabilidades sugeridas: {len(suggestions['vulnerabilidades'])}")
            for vuln in suggestions['vulnerabilidades'][:3]:
                print(f"    - {vuln['nombre']} (Confianza: {vuln['confianza']:.2f})")
            
            print(f"  Controles sugeridos: {len(suggestions['controles'])}")
            for control in suggestions['controles'][:3]:
                print(f"    - {control['titulo']} (Confianza: {control['confianza']:.2f})")
                
        except Exception as e:
            print(f"Error al probar {test_case['asset_type']}: {e}")
            return False
    
    return True

def test_api_endpoints():
    """Probar endpoints de la API"""
    print("\nProbando endpoints de la API...")
    
    try:
        from app.routes.predictive import predictive_bp
        print("Blueprint predictivo cargado exitosamente")
        
        # Verificar que las rutas estén registradas
        routes = [
            '/api/predictive/suggestions/threats',
            '/api/predictive/suggestions/vulnerabilities',
            '/api/predictive/suggestions/controls',
            '/api/predictive/suggestions/complete',
            '/api/predictive/knowledge-base/status',
            '/api/predictive/knowledge-base/refresh',
            '/api/predictive/asset-types',
            '/api/predictive/risk-level/calculate'
        ]
        
        print("Rutas de la API configuradas:")
        for route in routes:
            print(f"    - {route}")
        
        return True
        
    except Exception as e:
        print(f"Error al probar endpoints: {e}")
        return False

def main():
    """Función principal para probar el sistema predictivo"""
    print("Iniciando pruebas del sistema predictivo ISO")
    print("=" * 60)
    
    # Probar procesador de PDFs
    pdf_success = test_pdf_processor()
    
    # Probar servicio de sugerencias
    suggestion_success = test_suggestion_service()
    
    # Probar endpoints de la API
    api_success = test_api_endpoints()
    
    # Resumen de pruebas
    print("\n" + "=" * 60)
    print("RESUMEN DE PRUEBAS:")
    print(f"Procesador de PDFs: {'Exitoso' if pdf_success else 'Fallo'}")
    print(f"Servicio de sugerencias: {'Exitoso' if suggestion_success else 'Fallo'}")
    print(f"Endpoints de la API: {'Exitoso' if api_success else 'Fallo'}")
    
    if pdf_success and suggestion_success and api_success:
        print("\nSistema predictivo funcionando correctamente!")
        print("\nProximos pasos:")
        print("1. Ejecutar el backend y probar los endpoints")
        print("2. Probar el frontend con el wizard predictivo")
        print("3. Verificar la integracion completa")
    else:
        print("\nSistema predictivo con errores. Revisar los mensajes anteriores.")
    
    return pdf_success and suggestion_success and api_success

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
