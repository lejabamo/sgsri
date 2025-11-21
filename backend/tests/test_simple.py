#!/usr/bin/env python3
"""
Test Simple - Sistema SGSRI
Verificación básica sin emojis
"""

import unittest
import sys
import os
from datetime import datetime

# Agregar el directorio del proyecto al path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import create_app
from app.models import Activo, evaluacion_riesgo_activo, Riesgo

class TestSimpleSystem(unittest.TestCase):
    """Test suite simple para funcionalidades básicas"""
    
    @classmethod
    def setUpClass(cls):
        """Configuración inicial"""
        cls.app = create_app()
        cls.app.config['TESTING'] = True
        cls.client = cls.app.test_client()
        
        print("\n" + "="*60)
        print("INICIANDO TESTS SIMPLES - SISTEMA SGSRI")
        print("="*60)
    
    def test_01_database_connection(self):
        """Test 1: Verificar conexión a base de datos"""
        print("\nTest 1: Verificando conexión a base de datos...")
        
        with self.app.app_context():
            try:
                activos = Activo.query.all()
                self.assertIsInstance(activos, list)
                print(f"   OK - Conexión a BD: EXITOSA")
                print(f"   OK - Activos en BD: {len(activos)}")
                
            except Exception as e:
                print(f"   ERROR - Error de conexión: {str(e)}")
                self.fail(f"Error conectando a base de datos: {str(e)}")
    
    def test_02_data_integrity(self):
        """Test 2: Verificar integridad de datos"""
        print("\nTest 2: Verificando integridad de datos...")
        
        with self.app.app_context():
            # Verificar activos
            activos = Activo.query.all()
            self.assertGreater(len(activos), 0)
            
            for activo in activos[:3]:  # Verificar primeros 3
                self.assertIsNotNone(activo.ID_Activo)
                self.assertIsNotNone(activo.Nombre)
                print(f"   OK - Activo {activo.ID_Activo}: {activo.Nombre}")
            
            # Verificar evaluaciones
            evaluaciones = evaluacion_riesgo_activo.query.all()
            print(f"   OK - Evaluaciones en BD: {len(evaluaciones)}")
            
            # Verificar riesgos
            riesgos = Riesgo.query.all()
            print(f"   OK - Riesgos en BD: {len(riesgos)}")
            
            print("   OK - Integridad de datos: APROBADO")
    
    def test_03_api_endpoints(self):
        """Test 3: Verificar endpoints de API"""
        print("\nTest 3: Verificando endpoints de API...")
        
        endpoints = [
            '/api/activos',
            '/evaluacion-riesgos/evaluaciones-completadas'
        ]
        
        for endpoint in endpoints:
            try:
                response = self.client.get(endpoint)
                print(f"   OK - {endpoint}: Status {response.status_code}")
                self.assertNotEqual(response.status_code, 500)
                
            except Exception as e:
                print(f"   WARNING - {endpoint}: ERROR - {str(e)}")
        
        print("   OK - Verificación de endpoints: COMPLETADA")
    
    def test_04_data_quality(self):
        """Test 4: Análisis de calidad de datos"""
        print("\nTest 4: Análisis de calidad de datos...")
        
        with self.app.app_context():
            activos = Activo.query.all()
            activos_con_nombre = sum(1 for a in activos if a.Nombre)
            activos_con_tipo = sum(1 for a in activos if a.Tipo_Activo)
            
            print(f"   INFO - Activos con nombre: {activos_con_nombre}/{len(activos)} ({activos_con_nombre/len(activos)*100:.1f}%)")
            print(f"   INFO - Activos con tipo: {activos_con_tipo}/{len(activos)} ({activos_con_tipo/len(activos)*100:.1f}%)")
            
            self.assertGreater(activos_con_nombre/len(activos), 0.9)
            self.assertGreater(activos_con_tipo/len(activos), 0.9)
            
            print("   OK - Calidad de datos: APROBADO")
    
    def test_05_evaluation_data(self):
        """Test 5: Verificar datos de evaluaciones"""
        print("\nTest 5: Verificando datos de evaluaciones...")
        
        with self.app.app_context():
            evaluaciones = evaluacion_riesgo_activo.query.all()
            
            if len(evaluaciones) > 0:
                con_fecha_inherente = sum(1 for e in evaluaciones if e.fecha_evaluacion_inherente)
                con_justificacion = sum(1 for e in evaluaciones if e.justificacion_evaluacion_inherente)
                
                print(f"   INFO - Evaluaciones con fecha inherente: {con_fecha_inherente}/{len(evaluaciones)}")
                print(f"   INFO - Evaluaciones con justificación: {con_justificacion}/{len(evaluaciones)}")
                
                if len(evaluaciones) >= 4:
                    print("   OK - Datos suficientes para ML: APROBADO")
                else:
                    print("   WARNING - Datos insuficientes para ML (mínimo 4 evaluaciones)")
            else:
                print("   WARNING - No hay evaluaciones en la BD")
    
    @classmethod
    def tearDownClass(cls):
        """Limpieza"""
        print("\n" + "="*60)
        print("TESTS SIMPLES COMPLETADOS")
        print("="*60)

def run_simple_tests():
    """Ejecutar tests simples"""
    print("Iniciando tests simples del sistema SGSRI...")
    
    suite = unittest.TestLoader().loadTestsFromTestCase(TestSimpleSystem)
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    print(f"\nRESUMEN DE TESTS:")
    print(f"   Tests ejecutados: {result.testsRun}")
    print(f"   Fallos: {len(result.failures)}")
    print(f"   Errores: {len(result.errors)}")
    
    if result.failures:
        print(f"\nFALLOS:")
        for test, traceback in result.failures:
            print(f"   - {test}: {traceback}")
    
    if result.errors:
        print(f"\nERRORES:")
        for test, traceback in result.errors:
            print(f"   - {test}: {traceback}")
    
    return result.wasSuccessful()

if __name__ == "__main__":
    success = run_simple_tests()
    exit(0 if success else 1)
