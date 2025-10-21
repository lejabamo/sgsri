#!/usr/bin/env python3
"""
Script de diagnóstico para identificar errores en el API
"""

import requests
import json
import traceback
from datetime import datetime

# Configuración
BASE_URL = "http://localhost:5000/api"
HEADERS = {"Content-Type": "application/json"}

def test_endpoint_with_debug(endpoint, method="GET", data=None):
    """Probar endpoint con información detallada de errores"""
    print(f"\n🔍 DEBUGGING: {method} {endpoint}")
    print("-" * 50)
    
    try:
        if method == "GET":
            response = requests.get(f"{BASE_URL}{endpoint}")
        elif method == "POST":
            response = requests.post(f"{BASE_URL}{endpoint}", headers=HEADERS, data=json.dumps(data))
        
        print(f"Status Code: {response.status_code}")
        print(f"Headers: {dict(response.headers)}")
        
        if response.status_code >= 400:
            print(f"❌ ERROR RESPONSE:")
            print(f"Text: {response.text}")
            try:
                error_data = response.json()
                print(f"JSON Error: {json.dumps(error_data, indent=2)}")
            except:
                print("No JSON error data")
        else:
            print(f"✅ SUCCESS:")
            try:
                data = response.json()
                if isinstance(data, list):
                    print(f"Response: {len(data)} elements")
                    if len(data) > 0:
                        print(f"First element: {data[0]}")
                else:
                    print(f"Response: {data}")
            except:
                print(f"Response: {response.text[:200]}...")
                
    except Exception as e:
        print(f"❌ EXCEPTION: {str(e)}")
        print(f"Traceback: {traceback.format_exc()}")

def main():
    """Función principal de diagnóstico"""
    print("🚀 DIAGNÓSTICO COMPLETO DEL API SGRI")
    print("=" * 60)
    
    # Probar endpoints que están fallando
    failing_endpoints = [
        ("/usuarios/", "GET"),
        ("/usuarios/", "POST", {
            "nombre": "Usuario Test",
            "email": "test@example.com",
            "departamento": "TI",
            "rol": "Admin"
        }),
        ("/usuarios/departamentos", "GET"),
        ("/usuarios/roles", "GET"),
        ("/riesgos/", "GET"),
        ("/riesgos/", "POST", {
            "nombre_riesgo": "Test Risk",
            "descripcion": "Test description",
            "tipo_riesgo": "Técnico",
            "nivel_riesgo": "Alto",
            "estado": "Activo"
        }),
        ("/riesgos/niveles", "GET"),
        ("/activos/", "POST", {
            "Nombre": "Test Asset",
            "Descripcion": "Test description",
            "Tipo_Activo": "Infraestructura",
            "nivel_criticidad_negocio": "Alto",
            "estado_activo": "Activo"
        }),
        ("/dashboard/resumen", "GET"),
        ("/dashboard/actividad-reciente", "GET"),
        ("/dashboard/riesgos-altos", "GET"),
        ("/dashboard/tendencias", "GET")
    ]
    
    for endpoint_info in failing_endpoints:
        if len(endpoint_info) == 2:
            endpoint, method = endpoint_info
            test_endpoint_with_debug(endpoint, method)
        else:
            endpoint, method, data = endpoint_info
            test_endpoint_with_debug(endpoint, method, data)
    
    print("\n" + "=" * 60)
    print("✅ DIAGNÓSTICO COMPLETADO")

if __name__ == "__main__":
    main()
