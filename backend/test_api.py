#!/usr/bin/env python3
"""
Script de pruebas completo para el API SGRI
Prueba todos los endpoints y funcionalidades
"""

import requests
import json
import time
from datetime import datetime, date

# Configuración
BASE_URL = "http://localhost:5000/api"
HEADERS = {"Content-Type": "application/json"}

def print_test_result(test_name, success, response=None, error=None):
    """Imprime el resultado de una prueba"""
    status = "✅ PASS" if success else "❌ FAIL"
    print(f"{status} - {test_name}")
    if response:
        print(f"   Status: {response.status_code}")
        if response.status_code < 400:
            try:
                data = response.json()
                if isinstance(data, list):
                    print(f"   Respuesta: {len(data)} elementos")
                else:
                    print(f"   Respuesta: {data}")
            except:
                print(f"   Respuesta: {response.text[:100]}...")
    if error:
        print(f"   Error: {error}")
    print()

def test_health_check():
    """Probar endpoint de health check"""
    try:
        response = requests.get(f"{BASE_URL}/health")
        success = response.status_code == 200
        print_test_result("Health Check", success, response)
        return success
    except Exception as e:
        print_test_result("Health Check", False, error=str(e))
        return False

def test_activos_endpoints():
    """Probar todos los endpoints de activos"""
    print("=== PRUEBAS DE ACTIVOS ===")
    
    # 1. Obtener todos los activos
    try:
        response = requests.get(f"{BASE_URL}/activos/")
        success = response.status_code == 200
        print_test_result("GET /activos/", success, response)
    except Exception as e:
        print_test_result("GET /activos/", False, error=str(e))
    
    # 2. Crear un nuevo activo
    nuevo_activo = {
        "Nombre": "Servidor Web de Prueba",
        "Descripcion": "Servidor web para pruebas del API",
        "Tipo_Activo": "Infraestructura",
        "subtipo_activo": "Servidor",
        "Nivel_Clasificacion_Confidencialidad": "Uso Interno",
        "Nivel_Clasificacion_Integridad": "Media",
        "Nivel_Clasificacion_Disponibilidad": "Media",
        "nivel_criticidad_negocio": "Alto",
        "estado_activo": "Activo",
        "requiere_backup": True,
        "frecuencia_backup_general": "Diario",
        "tiempo_retencion_general": "30 días",
        "fecha_adquisicion": "2024-01-15"
    }
    
    try:
        response = requests.post(f"{BASE_URL}/activos/", 
                               headers=HEADERS, 
                               data=json.dumps(nuevo_activo))
        success = response.status_code == 201
        print_test_result("POST /activos/", success, response)
        
        if success:
            activo_data = response.json()
            activo_id = activo_data.get('ID_Activo')
            
            # 3. Obtener activo específico
            try:
                response = requests.get(f"{BASE_URL}/activos/{activo_id}")
                success = response.status_code == 200
                print_test_result(f"GET /activos/{activo_id}", success, response)
            except Exception as e:
                print_test_result(f"GET /activos/{activo_id}", False, error=str(e))
            
            # 4. Actualizar activo
            update_data = {
                "Descripcion": "Servidor web actualizado para pruebas",
                "nivel_criticidad_negocio": "Crítico"
            }
            try:
                response = requests.put(f"{BASE_URL}/activos/{activo_id}", 
                                      headers=HEADERS, 
                                      data=json.dumps(update_data))
                success = response.status_code == 200
                print_test_result(f"PUT /activos/{activo_id}", success, response)
            except Exception as e:
                print_test_result(f"PUT /activos/{activo_id}", False, error=str(e))
            
            return activo_id
    except Exception as e:
        print_test_result("POST /activos/", False, error=str(e))
        return None
    
    # 5. Obtener tipos de activo
    try:
        response = requests.get(f"{BASE_URL}/activos/tipos")
        success = response.status_code == 200
        print_test_result("GET /activos/tipos", success, response)
    except Exception as e:
        print_test_result("GET /activos/tipos", False, error=str(e))
    
    # 6. Obtener estados de activo
    try:
        response = requests.get(f"{BASE_URL}/activos/estados")
        success = response.status_code == 200
        print_test_result("GET /activos/estados", success, response)
    except Exception as e:
        print_test_result("GET /activos/estados", False, error=str(e))

def test_dashboard_endpoints():
    """Probar todos los endpoints del dashboard"""
    print("=== PRUEBAS DE DASHBOARD ===")
    
    endpoints = [
        "/dashboard/resumen",
        "/dashboard/actividad-reciente",
        "/dashboard/riesgos-altos",
        "/dashboard/incidentes-pendientes",
        "/dashboard/activos-criticos",
        "/dashboard/tendencias",
        "/dashboard/alertas"
    ]
    
    for endpoint in endpoints:
        try:
            response = requests.get(f"{BASE_URL}{endpoint}")
            success = response.status_code == 200
            print_test_result(f"GET {endpoint}", success, response)
        except Exception as e:
            print_test_result(f"GET {endpoint}", False, error=str(e))

def test_riesgos_endpoints():
    """Probar endpoints de riesgos"""
    print("=== PRUEBAS DE RIESGOS ===")
    
    # 1. Obtener todos los riesgos
    try:
        response = requests.get(f"{BASE_URL}/riesgos/")
        success = response.status_code == 200
        print_test_result("GET /riesgos/", success, response)
    except Exception as e:
        print_test_result("GET /riesgos/", False, error=str(e))
    
    # 2. Crear un nuevo riesgo
    nuevo_riesgo = {
        "nombre_riesgo": "Pérdida de datos de prueba",
        "descripcion": "Riesgo de pérdida de datos por fallo del sistema de prueba",
        "tipo_riesgo": "Técnico",
        "nivel_riesgo": "Alto",
        "estado": "Activo"
    }
    
    try:
        response = requests.post(f"{BASE_URL}/riesgos/", 
                               headers=HEADERS, 
                               data=json.dumps(nuevo_riesgo))
        success = response.status_code == 201
        print_test_result("POST /riesgos/", success, response)
        
        if success:
            riesgo_data = response.json()
            riesgo_id = riesgo_data.get('id_riesgo')
            
            # 3. Obtener riesgo específico
            try:
                response = requests.get(f"{BASE_URL}/riesgos/{riesgo_id}")
                success = response.status_code == 200
                print_test_result(f"GET /riesgos/{riesgo_id}", success, response)
            except Exception as e:
                print_test_result(f"GET /riesgos/{riesgo_id}", False, error=str(e))
            
            return riesgo_id
    except Exception as e:
        print_test_result("POST /riesgos/", False, error=str(e))
        return None
    
    # 4. Obtener tipos de riesgo
    try:
        response = requests.get(f"{BASE_URL}/riesgos/tipos")
        success = response.status_code == 200
        print_test_result("GET /riesgos/tipos", success, response)
    except Exception as e:
        print_test_result("GET /riesgos/tipos", False, error=str(e))
    
    # 5. Obtener niveles de riesgo
    try:
        response = requests.get(f"{BASE_URL}/riesgos/niveles")
        success = response.status_code == 200
        print_test_result("GET /riesgos/niveles", success, response)
    except Exception as e:
        print_test_result("GET /riesgos/niveles", False, error=str(e))

def test_incidentes_endpoints():
    """Probar endpoints de incidentes"""
    print("=== PRUEBAS DE INCIDENTES ===")
    
    # 1. Obtener todos los incidentes
    try:
        response = requests.get(f"{BASE_URL}/incidentes/")
        success = response.status_code == 200
        print_test_result("GET /incidentes/", success, response)
    except Exception as e:
        print_test_result("GET /incidentes/", False, error=str(e))
    
    # 2. Crear un nuevo incidente
    nuevo_incidente = {
        "titulo": "Incidente de prueba del API",
        "descripcion": "Incidente creado para probar el funcionamiento del API",
        "tipo_incidente": "Disponibilidad",
        "severidad": "Media",
        "estado": "Abierto",
        "responsable": "Equipo de Pruebas",
        "acciones_correctivas": "Verificar logs del sistema"
    }
    
    try:
        response = requests.post(f"{BASE_URL}/incidentes/", 
                               headers=HEADERS, 
                               data=json.dumps(nuevo_incidente))
        success = response.status_code == 201
        print_test_result("POST /incidentes/", success, response)
        
        if success:
            incidente_data = response.json()
            incidente_id = incidente_data.get('id_incidente')
            
            # 3. Obtener incidente específico
            try:
                response = requests.get(f"{BASE_URL}/incidentes/{incidente_id}")
                success = response.status_code == 200
                print_test_result(f"GET /incidentes/{incidente_id}", success, response)
            except Exception as e:
                print_test_result(f"GET /incidentes/{incidente_id}", False, error=str(e))
            
            return incidente_id
    except Exception as e:
        print_test_result("POST /incidentes/", False, error=str(e))
        return None
    
    # 4. Obtener tipos de incidente
    try:
        response = requests.get(f"{BASE_URL}/incidentes/tipos")
        success = response.status_code == 200
        print_test_result("GET /incidentes/tipos", success, response)
    except Exception as e:
        print_test_result("GET /incidentes/tipos", False, error=str(e))
    
    # 5. Obtener severidades
    try:
        response = requests.get(f"{BASE_URL}/incidentes/severidades")
        success = response.status_code == 200
        print_test_result("GET /incidentes/severidades", success, response)
    except Exception as e:
        print_test_result("GET /incidentes/severidades", False, error=str(e))
    
    # 6. Obtener estados de incidente
    try:
        response = requests.get(f"{BASE_URL}/incidentes/estados")
        success = response.status_code == 200
        print_test_result("GET /incidentes/estados", success, response)
    except Exception as e:
        print_test_result("GET /incidentes/estados", False, error=str(e))

def test_usuarios_endpoints():
    """Probar endpoints de usuarios"""
    print("=== PRUEBAS DE USUARIOS ===")
    
    # 1. Obtener todos los usuarios
    try:
        response = requests.get(f"{BASE_URL}/usuarios/")
        success = response.status_code == 200
        print_test_result("GET /usuarios/", success, response)
    except Exception as e:
        print_test_result("GET /usuarios/", False, error=str(e))
    
    # 2. Crear un nuevo usuario
    nuevo_usuario = {
        "nombre": "Usuario de Prueba",
        "email": "prueba@test.com",
        "departamento": "TI",
        "rol": "Administrador"
    }
    
    try:
        response = requests.post(f"{BASE_URL}/usuarios/", 
                               headers=HEADERS, 
                               data=json.dumps(nuevo_usuario))
        success = response.status_code == 201
        print_test_result("POST /usuarios/", success, response)
        
        if success:
            usuario_data = response.json()
            usuario_id = usuario_data.get('id_usuario')
            
            # 3. Obtener usuario específico
            try:
                response = requests.get(f"{BASE_URL}/usuarios/{usuario_id}")
                success = response.status_code == 200
                print_test_result(f"GET /usuarios/{usuario_id}", success, response)
            except Exception as e:
                print_test_result(f"GET /usuarios/{usuario_id}", False, error=str(e))
            
            return usuario_id
    except Exception as e:
        print_test_result("POST /usuarios/", False, error=str(e))
        return None
    
    # 4. Obtener departamentos
    try:
        response = requests.get(f"{BASE_URL}/usuarios/departamentos")
        success = response.status_code == 200
        print_test_result("GET /usuarios/departamentos", success, response)
    except Exception as e:
        print_test_result("GET /usuarios/departamentos", False, error=str(e))
    
    # 5. Obtener roles
    try:
        response = requests.get(f"{BASE_URL}/usuarios/roles")
        success = response.status_code == 200
        print_test_result("GET /usuarios/roles", success, response)
    except Exception as e:
        print_test_result("GET /usuarios/roles", False, error=str(e))

def main():
    """Función principal que ejecuta todas las pruebas"""
    print("🚀 INICIANDO PRUEBAS COMPLETAS DEL API SGRI")
    print("=" * 50)
    
    # Esperar un momento para que el servidor esté listo
    print("Esperando que el servidor esté listo...")
    time.sleep(3)
    
    # Probar health check primero
    if not test_health_check():
        print("❌ El servidor no está respondiendo. Verifica que esté ejecutándose.")
        return
    
    # Ejecutar todas las pruebas
    test_activos_endpoints()
    test_dashboard_endpoints()
    test_riesgos_endpoints()
    test_incidentes_endpoints()
    test_usuarios_endpoints()
    
    print("=" * 50)
    print("✅ PRUEBAS COMPLETADAS")
    print("Revisa los resultados arriba para ver el estado de cada endpoint.")

if __name__ == "__main__":
    main()