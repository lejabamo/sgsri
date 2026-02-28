#!/usr/bin/env python3
"""
Script para probar un endpoint específico y ver el error exacto
"""

import requests
import json

def test_single_endpoint():
    """Probar un endpoint específico"""
    BASE_URL = "http://localhost:5000/api"
    
    # Probar endpoint de usuarios
    print("🔍 Probando GET /api/usuarios/")
    try:
        response = requests.get(f"{BASE_URL}/usuarios/")
        print(f"Status: {response.status_code}")
        print(f"Headers: {dict(response.headers)}")
        print(f"Response: {response.text}")
        
        if response.status_code == 500:
            print("\n❌ Error 500 detectado")
            try:
                error_data = response.json()
                print(f"Error JSON: {json.dumps(error_data, indent=2)}")
            except:
                print("No se pudo parsear como JSON")
    except Exception as e:
        print(f"Exception: {e}")

if __name__ == "__main__":
    test_single_endpoint()
