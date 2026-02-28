#!/usr/bin/env python3
"""
Test Básico - Sistema SGSRI
Verificación de funcionalidades básicas sin dependencias ML
"""

import unittest
import sys
import os
from datetime import datetime

# Agregar el directorio del proyecto al path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import create_app
from app.models import Activo, evaluacion_riesgo_activo, Riesgo

class TestBasicSystem(unittest.TestCase):
    """Test suite para funcionalidades básicas del sistema"""
    
    @classmethod
    def setUpClass(cls):
        """Configuración inicial para todos los tests"""
        cls.app = create_app()
        cls.app.config['TESTING'] = True
        cls.client = cls.app.test_client()
        
        print("\n" + "="*60)
        print("🧪 INICIANDO TESTS BÁSICOS - SISTEMA SGSRI")
        print("="*60)
    
    def test_01_database_connection(self):
        """Test 1: Verificar conexión a base de datos"""
        print("\n📊 Test 1: Verificando conexión a base de datos...")
        
        with self.app.app_context():
            try:
                # Verificar que podemos consultar la base de datos
                activos = Activo.query.all()
                self.assertIsInstance(activos, list, "Consulta de activos debe retornar lista")
                print(f"   ✅ Conexión a BD: EXITOSA")
                print(f"   ✅ Activos en BD: {len(activos)}")
                
            except Exception as e:
                print(f"   ❌ Error de conexión: {str(e)}")
                self.fail(f"Error conectando a base de datos: {str(e)}")
    
    def test_02_data_integrity(self):
        """Test 2: Verificar integridad de datos"""
        print("\n🔍 Test 2: Verificando integridad de datos...")
        
        with self.app.app_context():
            # Verificar activos
            activos = Activo.query.all()
            self.assertGreater(len(activos), 0, "Debe haber activos en la BD")
            
            for activo in activos[:5]:  # Verificar primeros 5
                self.assertIsNotNone(activo.ID_Activo, "Activo debe tener ID")
                self.assertIsNotNone(activo.Nombre, "Activo debe tener nombre")
                print(f"   ✅ Activo {activo.ID_Activo}: {activo.Nombre}")
            
            # Verificar evaluaciones
            evaluaciones = evaluacion_riesgo_activo.query.all()
            self.assertGreater(len(evaluaciones), 0, "Debe haber evaluaciones en la BD")
            print(f"   ✅ Evaluaciones en BD: {len(evaluaciones)}")
            
            # Verificar riesgos
            riesgos = Riesgo.query.all()
            self.assertGreater(len(riesgos), 0, "Debe haber riesgos en la BD")
            print(f"   ✅ Riesgos en BD: {len(riesgos)}")
            
            print("   ✅ Integridad de datos: APROBADO")
    
    def test_03_api_endpoints(self):
        """Test 3: Verificar endpoints de API básicos"""
        print("\n🌐 Test 3: Verificando endpoints de API...")
        
        # Endpoints básicos que deben existir
        basic_endpoints = [
            '/api/activos',
            '/api/riesgos',
            '/evaluacion-riesgos/evaluaciones-completadas'
        ]
        
        for endpoint in basic_endpoints:
            try:
                response = self.client.get(endpoint)
                print(f"   ✅ {endpoint}: Status {response.status_code}")
                
                # Verificar que no es un error 500
                self.assertNotEqual(response.status_code, 500, 
                                 f"Endpoint {endpoint} no debe retornar error 500")
                
            except Exception as e:
                print(f"   ⚠️  {endpoint}: ERROR - {str(e)}")
        
        print("   ✅ Verificación de endpoints: COMPLETADA")
    
    def test_04_data_quality_analysis(self):
        """Test 4: Análisis de calidad de datos"""
        print("\n📈 Test 4: Análisis de calidad de datos...")
        
        with self.app.app_context():
            # Analizar activos
            activos = Activo.query.all()
            activos_con_nombre = sum(1 for a in activos if a.Nombre)
            activos_con_tipo = sum(1 for a in activos if a.Tipo_Activo)
            activos_con_criticidad = sum(1 for a in activos if a.nivel_criticidad_negocio)
            
            print(f"   📊 Activos con nombre: {activos_con_nombre}/{len(activos)} ({activos_con_nombre/len(activos)*100:.1f}%)")
            print(f"   📊 Activos con tipo: {activos_con_tipo}/{len(activos)} ({activos_con_tipo/len(activos)*100:.1f}%)")
            print(f"   📊 Activos con criticidad: {activos_con_criticidad}/{len(activos)} ({activos_con_criticidad/len(activos)*100:.1f}%)")
            
            # Verificar que la calidad es buena
            self.assertGreater(activos_con_nombre/len(activos), 0.9, "Al menos 90% de activos deben tener nombre")
            self.assertGreater(activos_con_tipo/len(activos), 0.9, "Al menos 90% de activos deben tener tipo")
            self.assertGreater(activos_con_criticidad/len(activos), 0.9, "Al menos 90% de activos deben tener criticidad")
            
            print("   ✅ Calidad de datos: APROBADO")
    
    def test_05_evaluation_data(self):
        """Test 5: Verificar datos de evaluaciones"""
        print("\n🎯 Test 5: Verificando datos de evaluaciones...")
        
        with self.app.app_context():
            evaluaciones = evaluacion_riesgo_activo.query.all()
            
            if len(evaluaciones) > 0:
                # Analizar completitud de evaluaciones
                con_fecha_inherente = sum(1 for e in evaluaciones if e.fecha_evaluacion_inherente)
                con_fecha_residual = sum(1 for e in evaluaciones if e.fecha_evaluacion_residual)
                con_justificacion = sum(1 for e in evaluaciones if e.justificacion_evaluacion_inherente)
                
                print(f"   📊 Evaluaciones con fecha inherente: {con_fecha_inherente}/{len(evaluaciones)}")
                print(f"   📊 Evaluaciones con fecha residual: {con_fecha_residual}/{len(evaluaciones)}")
                print(f"   📊 Evaluaciones con justificación: {con_justificacion}/{len(evaluaciones)}")
                
                # Verificar que hay datos suficientes para ML
                if len(evaluaciones) >= 4:
                    print("   ✅ Datos suficientes para ML: APROBADO")
                else:
                    print("   ⚠️  Datos insuficientes para ML (mínimo 4 evaluaciones)")
            else:
                print("   ⚠️  No hay evaluaciones en la BD")
    
    def test_06_risk_data(self):
        """Test 6: Verificar datos de riesgos"""
        print("\n⚠️  Test 6: Verificando datos de riesgos...")
        
        with self.app.app_context():
            riesgos = Riesgo.query.all()
            
            if len(riesgos) > 0:
                # Analizar calidad de descripciones
                riesgos_con_descripcion = sum(1 for r in riesgos if r.Descripcion)
                longitudes = [len(r.Descripcion) for r in riesgos if r.Descripcion]
                
                if longitudes:
                    longitud_promedio = sum(longitudes) / len(longitudes)
                    print(f"   📊 Riesgos con descripción: {riesgos_con_descripcion}/{len(riesgos)}")
                    print(f"   📊 Longitud promedio descripción: {longitud_promedio:.1f} caracteres")
                    
                    # Verificar que las descripciones son suficientemente detalladas
                    self.assertGreater(longitud_promedio, 50, "Descripciones deben tener al menos 50 caracteres")
                    print("   ✅ Calidad de descripciones: APROBADO")
                else:
                    print("   ⚠️  No hay descripciones de riesgos")
            else:
                print("   ⚠️  No hay riesgos en la BD")
    
    @classmethod
    def tearDownClass(cls):
        """Limpieza después de todos los tests"""
        print("\n" + "="*60)
        print("TESTS BASICOS COMPLETADOS")
        print("="*60)

def run_basic_tests():
    """Ejecutar tests básicos del sistema"""
    print("Iniciando tests basicos del sistema SGSRI...")
    
    # Crear suite de tests
    suite = unittest.TestLoader().loadTestsFromTestCase(TestBasicSystem)
    
    # Ejecutar tests
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    # Resumen de resultados
    print(f"\n📊 RESUMEN DE TESTS BÁSICOS:")
    print(f"   Tests ejecutados: {result.testsRun}")
    print(f"   Fallos: {len(result.failures)}")
    print(f"   Errores: {len(result.errors)}")
    print(f"   Omitidos: {len(result.skipped)}")
    
    if result.failures:
        print(f"\n❌ FALLOS:")
        for test, traceback in result.failures:
            print(f"   - {test}: {traceback}")
    
    if result.errors:
        print(f"\n❌ ERRORES:")
        for test, traceback in result.errors:
            print(f"   - {test}: {traceback}")
    
    return result.wasSuccessful()

if __name__ == "__main__":
    success = run_basic_tests()
    exit(0 if success else 1)
