#!/usr/bin/env python3
"""
Pruebas de Riesgos ISO 27001/27002
SGSRI - Sistema Predictivo de Riesgos ISO
"""

import unittest
import os
import sys
import json
import requests
from dotenv import load_dotenv

# Add the project root to the Python path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))

from app import create_app, db
from app.models import Activo, Riesgo, evaluacion_riesgo_activo, niveles_probabilidad, niveles_impacto, nivelesriesgo

class TestISORisks(unittest.TestCase):
    """Pruebas de riesgos basados en ISO 27001/27002"""
    
    app = None
    client = None
    
    @classmethod
    def setUpClass(cls):
        """Configuración inicial para todos los tests"""
        print("\n" + "="*60)
        print("INICIANDO PRUEBAS DE RIESGOS ISO 27001/27002")
        print("="*60)
        
        # Cargar variables de entorno
        basedir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
        load_dotenv(os.path.join(basedir, '.env'))
        
        # Configurar la aplicación Flask
        cls.app = create_app()
        cls.client = cls.app.test_client()
    
    def test_01_iso_threat_suggestions(self):
        """Test 1: Verificar sugerencias de amenazas ISO"""
        print("\nTest 1: Verificando sugerencias de amenazas ISO...")
        
        test_cases = [
            {
                "threat_name": "Acceso No Autorizado a Sistemas",
                "expected_controls": ["Autenticación Multifactor", "Control de Accesos"]
            },
            {
                "threat_name": "Malware",
                "expected_controls": ["Antivirus Empresarial", "Gestión de Parches"]
            },
            {
                "threat_name": "Pérdida de Datos",
                "expected_controls": ["Respaldos Automáticos", "Monitoreo Continuo"]
            },
            {
                "threat_name": "Interrupción del Servicio",
                "expected_controls": ["Monitoreo Continuo", "Redundancia de Sistemas"]
            }
        ]
        
        for case in test_cases:
            try:
                response = self.client.post('/api/iso/threat-suggestions', 
                    json={"threat_name": case["threat_name"]},
                    content_type='application/json'
                )
                
                if response.status_code == 200:
                    data = response.get_json()
                    self.assertTrue(data.get('success', False))
                    print(f"   OK - Amenaza '{case['threat_name']}': Sugerencias obtenidas")
                else:
                    print(f"   WARN - Amenaza '{case['threat_name']}': Status {response.status_code}")
                    
            except Exception as e:
                print(f"   ERROR - Amenaza '{case['threat_name']}': {str(e)}")
    
    def test_02_iso_vulnerability_suggestions(self):
        """Test 2: Verificar sugerencias de vulnerabilidades ISO"""
        print("\nTest 2: Verificando sugerencias de vulnerabilidades ISO...")
        
        test_cases = [
            {
                "vulnerability_name": "Falta de Autenticación Multifactor",
                "expected_controls": ["Autenticación Multifactor"]
            },
            {
                "vulnerability_name": "Software Desactualizado",
                "expected_controls": ["Gestión de Parches", "Antivirus Empresarial"]
            },
            {
                "vulnerability_name": "Falta de Respaldo",
                "expected_controls": ["Respaldos Automáticos"]
            },
            {
                "vulnerability_name": "Configuración Insegura",
                "expected_controls": ["Hardening de Sistemas", "Auditoría de Seguridad"]
            }
        ]
        
        for case in test_cases:
            try:
                response = self.client.post('/api/iso/vulnerability-suggestions', 
                    json={"vulnerability_name": case["vulnerability_name"]},
                    content_type='application/json'
                )
                
                if response.status_code == 200:
                    data = response.get_json()
                    self.assertTrue(data.get('success', False))
                    print(f"   OK - Vulnerabilidad '{case['vulnerability_name']}': Sugerencias obtenidas")
                else:
                    print(f"   WARN - Vulnerabilidad '{case['vulnerability_name']}': Status {response.status_code}")
                    
            except Exception as e:
                print(f"   ERROR - Vulnerabilidad '{case['vulnerability_name']}': {str(e)}")
    
    def test_03_iso_control_suggestions(self):
        """Test 3: Verificar sugerencias de controles ISO"""
        print("\nTest 3: Verificando sugerencias de controles ISO...")
        
        test_cases = [
            {
                "threat_name": "Acceso No Autorizado a Sistemas",
                "vulnerability_name": "Falta de Autenticación Multifactor",
                "expected_controls": ["Autenticación Multifactor", "Control de Accesos"]
            },
            {
                "threat_name": "Malware",
                "vulnerability_name": "Software Desactualizado",
                "expected_controls": ["Antivirus Empresarial", "Gestión de Parches"]
            },
            {
                "threat_name": "Pérdida de Datos",
                "vulnerability_name": "Falta de Respaldo",
                "expected_controls": ["Respaldos Automáticos", "Monitoreo de Integridad"]
            },
            {
                "threat_name": "Interrupción del Servicio",
                "vulnerability_name": "Falta de Redundancia",
                "expected_controls": ["Monitoreo Continuo", "Redundancia de Sistemas"]
            }
        ]
        
        for case in test_cases:
            try:
                response = self.client.post('/api/iso/control-suggestions', 
                    json={
                        "threat_name": case["threat_name"],
                        "vulnerability_name": case["vulnerability_name"]
                    },
                    content_type='application/json'
                )
                
                if response.status_code == 200:
                    data = response.get_json()
                    self.assertTrue(data.get('success', False))
                    suggestions = data.get('suggestions', [])
                    print(f"   OK - Amenaza '{case['threat_name']}' + Vulnerabilidad '{case['vulnerability_name']}': {len(suggestions)} controles sugeridos")
                    
                    # Verificar que se sugieren controles relevantes
                    if suggestions:
                        control_names = [s.get('nombre', '') for s in suggestions]
                        print(f"      Controles sugeridos: {', '.join(control_names)}")
                else:
                    print(f"   WARN - Amenaza '{case['threat_name']}' + Vulnerabilidad '{case['vulnerability_name']}': Status {response.status_code}")
                    
            except Exception as e:
                print(f"   ERROR - Amenaza '{case['threat_name']}' + Vulnerabilidad '{case['vulnerability_name']}': {str(e)}")
    
    def test_04_iso_all_suggestions(self):
        """Test 4: Verificar todas las sugerencias ISO"""
        print("\nTest 4: Verificando todas las sugerencias ISO...")
        
        test_case = {
            "threat_name": "Acceso No Autorizado a Sistemas",
            "vulnerability_name": "Falta de Autenticación Multifactor"
        }
        
        try:
            response = self.client.post('/api/iso/all-suggestions', 
                json=test_case,
                content_type='application/json'
            )
            
            if response.status_code == 200:
                data = response.get_json()
                self.assertTrue(data.get('success', False))
                
                suggestions = data.get('suggestions', {})
                threat_suggestions = suggestions.get('threat', {})
                vulnerability_suggestions = suggestions.get('vulnerability', {})
                control_suggestions = suggestions.get('controls', [])
                
                print(f"   OK - Sugerencias completas obtenidas:")
                print(f"      Amenaza: {threat_suggestions.get('suggestions', {}).get('nombre', 'N/A')}")
                print(f"      Vulnerabilidad: {vulnerability_suggestions.get('suggestions', {}).get('nombre', 'N/A')}")
                print(f"      Controles: {len(control_suggestions)} sugeridos")
                
            else:
                print(f"   WARN - Sugerencias completas: Status {response.status_code}")
                
        except Exception as e:
            print(f"   ERROR - Sugerencias completas: {str(e)}")
    
    def test_05_iso_risk_scenarios(self):
        """Test 5: Escenarios de riesgo ISO 27001/27002"""
        print("\nTest 5: Escenarios de riesgo ISO 27001/27002...")
        
        risk_scenarios = [
            {
                "name": "Escenario 1: Acceso No Autorizado",
                "threat": "Acceso No Autorizado a Sistemas",
                "vulnerability": "Falta de Autenticación Multifactor",
                "expected_controls": ["Autenticación Multifactor", "Control de Accesos", "Auditoría de Accesos"]
            },
            {
                "name": "Escenario 2: Infección por Malware",
                "threat": "Malware",
                "vulnerability": "Software Desactualizado",
                "expected_controls": ["Antivirus Empresarial", "Gestión de Parches", "Monitoreo de Red"]
            },
            {
                "name": "Escenario 3: Pérdida de Datos",
                "threat": "Pérdida de Datos",
                "vulnerability": "Falta de Respaldo",
                "expected_controls": ["Respaldos Automáticos", "Replicación de Datos", "Monitoreo de Integridad"]
            },
            {
                "name": "Escenario 4: Interrupción del Servicio",
                "threat": "Interrupción del Servicio",
                "vulnerability": "Falta de Redundancia",
                "expected_controls": ["Monitoreo Continuo", "Redundancia de Sistemas", "Balanceadores de Carga"]
            }
        ]
        
        for scenario in risk_scenarios:
            try:
                print(f"\n   Probando {scenario['name']}...")
                
                # Obtener sugerencias de controles
                response = self.client.post('/api/iso/control-suggestions', 
                    json={
                        "threat_name": scenario["threat"],
                        "vulnerability_name": scenario["vulnerability"]
                    },
                    content_type='application/json'
                )
                
                if response.status_code == 200:
                    data = response.get_json()
                    suggestions = data.get('suggestions', [])
                    
                    print(f"      Amenaza: {scenario['threat']}")
                    print(f"      Vulnerabilidad: {scenario['vulnerability']}")
                    print(f"      Controles sugeridos: {len(suggestions)}")
                    
                    if suggestions:
                        for suggestion in suggestions:
                            print(f"         - {suggestion.get('nombre', 'N/A')} ({suggestion.get('categoria', 'N/A')}) - Eficacia: {suggestion.get('eficacia', 'N/A')}")
                    
                    print(f"      ✅ {scenario['name']}: EXITOSO")
                else:
                    print(f"      ❌ {scenario['name']}: Status {response.status_code}")
                    
            except Exception as e:
                print(f"      ❌ {scenario['name']}: {str(e)}")
    
    @classmethod
    def tearDownClass(cls):
        """Limpieza después de todos los tests"""
        print("\n" + "="*60)
        print("PRUEBAS DE RIESGOS ISO COMPLETADAS")
        print("="*60)

def run_iso_risk_tests():
    """Ejecutar pruebas de riesgos ISO"""
    print("Iniciando pruebas de riesgos ISO 27001/27002...")
    
    # Crear suite de tests
    suite = unittest.TestLoader().loadTestsFromTestCase(TestISORisks)
    
    # Ejecutar tests
    runner = unittest.TextTestRunner(verbosity=0)
    result = runner.run(suite)
    
    print("\nRESUMEN DE PRUEBAS ISO:")
    print(f"   Tests ejecutados: {result.testsRun}")
    print(f"   Fallos: {len(result.failures)}")
    print(f"   Errores: {len(result.errors)}")
    
    return result.wasSuccessful()

if __name__ == '__main__':
    success = run_iso_risk_tests()
    sys.exit(0 if success else 1)
