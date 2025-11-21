#!/usr/bin/env python3
"""
Obtener información de activo específico para test manual
SGSRI - Sistema Predictivo de Riesgos ISO
"""

import sys
import os

# Agregar el directorio del proyecto al path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import create_app, db
from app.models import Activo, evaluacion_riesgo_activo, Riesgo

def get_activo_for_test():
    """Obtener un activo específico para el test manual"""
    app = create_app()
    with app.app_context():
        try:
            # Obtener activos no evaluados
            activos_evaluados = db.session.query(evaluacion_riesgo_activo.ID_Activo).distinct().all()
            activos_evaluados_ids = [a[0] for a in activos_evaluados]
            
            # Buscar activos no evaluados
            activos_no_evaluados = Activo.query.filter(
                ~Activo.ID_Activo.in_(activos_evaluados_ids)
            ).limit(5).all()
            
            print("ACTIVOS DISPONIBLES PARA TEST MANUAL:")
            print("="*50)
            
            for i, activo in enumerate(activos_no_evaluados, 1):
                print(f"{i}. ID: {activo.ID_Activo}")
                print(f"   Nombre: {activo.Nombre}")
                print(f"   Tipo: {activo.Tipo_Activo}")
                print(f"   Criticidad: {activo.nivel_criticidad_negocio}")
                print(f"   Estado: {activo.estado_activo}")
                print()
            
            # Seleccionar el primer activo para el test
            if activos_no_evaluados:
                activo_test = activos_no_evaluados[0]
                print("ACTIVO SELECCIONADO PARA TEST:")
                print("="*40)
                print(f"ID: {activo_test.ID_Activo}")
                print(f"Nombre: {activo_test.Nombre}")
                print(f"Tipo: {activo_test.Tipo_Activo}")
                print(f"Criticidad: {activo_test.nivel_criticidad_negocio}")
                print(f"Estado: {activo_test.estado_activo}")
                
                return activo_test
            else:
                print("No hay activos disponibles para test")
                return None
                
        except Exception as e:
            print(f"Error obteniendo activo: {str(e)}")
            return None

def get_riesgos_disponibles():
    """Obtener riesgos disponibles para el test"""
    app = create_app()
    with app.app_context():
        try:
            riesgos = Riesgo.query.limit(5).all()
            
            print("\nRIESGOS DISPONIBLES:")
            print("="*30)
            
            for i, riesgo in enumerate(riesgos, 1):
                print(f"{i}. {riesgo.Nombre}")
                print(f"   Descripción: {riesgo.Descripcion[:100]}...")
                print()
            
            return riesgos
            
        except Exception as e:
            print(f"Error obteniendo riesgos: {str(e)}")
            return []

def main():
    """Función principal"""
    print("OBTENIENDO INFORMACIÓN PARA TEST MANUAL")
    print("="*50)
    
    # Obtener activo para test
    activo = get_activo_for_test()
    
    # Obtener riesgos disponibles
    riesgos = get_riesgos_disponibles()
    
    if activo:
        print(f"\nRECOMENDACIÓN PARA TEST:")
        print(f"Activo: {activo.Nombre} (ID: {activo.ID_Activo})")
        print(f"Tipo: {activo.Tipo_Activo}")
        print(f"Criticidad: {activo.nivel_criticidad_negocio}")
        
        # Sugerir amenaza y vulnerabilidad basada en el tipo de activo
        if "SERVIDOR" in activo.Nombre.upper() or "WEB" in activo.Nombre.upper():
            print(f"\nAMENAZA SUGERIDA: Ataque de denegación de servicio (DDoS)")
            print(f"VULNERABILIDAD SUGERIDA: Falta de protección contra DDoS")
            print(f"DESCRIPCIÓN: El servidor está expuesto a ataques DDoS que pueden interrumpir el servicio")
        elif "BASE" in activo.Nombre.upper() or "DATOS" in activo.Nombre.upper():
            print(f"\nAMENAZA SUGERIDA: Acceso no autorizado a base de datos")
            print(f"VULNERABILIDAD SUGERIDA: Falta de autenticación multifactor")
            print(f"DESCRIPCIÓN: Riesgo de acceso no autorizado a datos sensibles")
        else:
            print(f"\nAMENAZA SUGERIDA: Acceso no autorizado a sistemas")
            print(f"VULNERABILIDAD SUGERIDA: Falta de autenticación multifactor")
            print(f"DESCRIPCIÓN: Riesgo de acceso no autorizado debido a la ausencia de autenticación de dos factores")
        
        print(f"\nPREDICCIÓN ESPERADA:")
        print(f"- Nivel de Riesgo: Alto")
        print(f"- Probabilidad: Ocasional (Nivel 3)")
        print(f"- Impacto: Moderado (Nivel 3)")
        print(f"- Controles sugeridos: Autenticación multifactor, Monitoreo, Auditoría")
    
    return activo, riesgos

if __name__ == "__main__":
    main()
