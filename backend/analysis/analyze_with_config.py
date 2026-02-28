#!/usr/bin/env python3
"""
Análisis de Calidad de Datos usando configuración del proyecto
SGSRI - Sistema Predictivo de Riesgos ISO
"""

import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import create_app
from app.models import Activo, evaluacion_riesgo_activo, Riesgo, niveles_probabilidad, niveles_impacto, nivelesriesgo
from sqlalchemy import text
import pandas as pd
from datetime import datetime
import json

def analyze_data_quality():
    """Análisis de calidad de datos usando la configuración del proyecto"""
    print("Iniciando analisis de calidad de datos...")
    print("=" * 60)
    
    app = create_app()
    with app.app_context():
        results = {}
        
        # 1. Análisis de Activos
        print("Analizando activos...")
        activos = Activo.query.all()
        activos_data = {
            'total_activos': len(activos),
            'tipos_activo': {},
            'niveles_criticidad': {},
            'estados_activo': {},
            'completitud_datos': {
                'nombre_completo': 0,
                'tipo_completo': 0,
                'criticidad_completa': 0
            }
        }
        
        # Contar tipos, niveles y estados
        for activo in activos:
            # Tipos de activo
            tipo = activo.Tipo_Activo or 'Sin tipo'
            activos_data['tipos_activo'][tipo] = activos_data['tipos_activo'].get(tipo, 0) + 1
            
            # Niveles de criticidad
            criticidad = activo.nivel_criticidad_negocio or 'Sin criticidad'
            activos_data['niveles_criticidad'][criticidad] = activos_data['niveles_criticidad'].get(criticidad, 0) + 1
            
            # Estados de activo
            estado = activo.estado_activo or 'Sin estado'
            activos_data['estados_activo'][estado] = activos_data['estados_activo'].get(estado, 0) + 1
        
        # Calcular completitud
        activos_data['completitud_datos']['nombre_completo'] = sum(1 for a in activos if a.Nombre) / len(activos) * 100
        activos_data['completitud_datos']['tipo_completo'] = sum(1 for a in activos if a.Tipo_Activo) / len(activos) * 100
        activos_data['completitud_datos']['criticidad_completa'] = sum(1 for a in activos if a.nivel_criticidad_negocio) / len(activos) * 100
        
        results['activos'] = activos_data
        print(f"Activos analizados: {len(activos)}")
        
        # 2. Análisis de Evaluaciones
        print("Analizando evaluaciones...")
        evaluaciones = evaluacion_riesgo_activo.query.all()
        eval_data = {
            'total_evaluaciones': len(evaluaciones),
            'activos_evaluados': len(set(e.ID_Activo for e in evaluaciones)),
            'riesgos_evaluados': len(set(e.ID_Riesgo for e in evaluaciones)),
            'completitud_evaluaciones': {
                'fecha_inherente': 0,
                'fecha_residual': 0,
                'justificacion_inherente': 0,
                'justificacion_residual': 0
            }
        }
        
        # Calcular completitud de evaluaciones
        if evaluaciones:
            eval_data['completitud_evaluaciones']['fecha_inherente'] = sum(1 for e in evaluaciones if e.fecha_evaluacion_inherente) / len(evaluaciones) * 100
            eval_data['completitud_evaluaciones']['fecha_residual'] = sum(1 for e in evaluaciones if e.fecha_evaluacion_residual) / len(evaluaciones) * 100
            eval_data['completitud_evaluaciones']['justificacion_inherente'] = sum(1 for e in evaluaciones if e.justificacion_evaluacion_inherente) / len(evaluaciones) * 100
            eval_data['completitud_evaluaciones']['justificacion_residual'] = sum(1 for e in evaluaciones if e.justificacion_evaluacion_residual) / len(evaluaciones) * 100
        
        results['evaluaciones'] = eval_data
        print(f"Evaluaciones analizadas: {len(evaluaciones)}")
        
        # 3. Análisis de Riesgos
        print("Analizando riesgos...")
        riesgos = Riesgo.query.all()
        riesgos_data = {
            'total_riesgos': len(riesgos),
            'completitud_datos': {
                'nombre_completo': 0,
                'descripcion_completa': 0
            },
            'longitud_descripciones': {
                'promedio': 0,
                'minima': 0,
                'maxima': 0
            }
        }
        
        if riesgos:
            riesgos_data['completitud_datos']['nombre_completo'] = sum(1 for r in riesgos if r.Nombre) / len(riesgos) * 100
            riesgos_data['completitud_datos']['descripcion_completa'] = sum(1 for r in riesgos if r.Descripcion) / len(riesgos) * 100
            
            # Longitud de descripciones
            descripciones = [len(r.Descripcion or '') for r in riesgos if r.Descripcion]
            if descripciones:
                riesgos_data['longitud_descripciones']['promedio'] = sum(descripciones) / len(descripciones)
                riesgos_data['longitud_descripciones']['minima'] = min(descripciones)
                riesgos_data['longitud_descripciones']['maxima'] = max(descripciones)
        
        results['riesgos'] = riesgos_data
        print(f"Riesgos analizados: {len(riesgos)}")
        
        # 4. Análisis de Niveles
        print("Analizando niveles...")
        niveles_prob = niveles_probabilidad.query.all()
        niveles_imp = niveles_impacto.query.all()
        niveles_riesgo = nivelesriesgo.query.all()
        
        niveles_data = {
            'niveles_probabilidad': {
                'total': len(niveles_prob),
                'nombres': [n.Nombre for n in niveles_prob]
            },
            'niveles_impacto': {
                'total': len(niveles_imp),
                'nombres': [n.Nombre for n in niveles_imp]
            },
            'niveles_riesgo': {
                'total': len(niveles_riesgo),
                'nombres': [n.Nombre for n in niveles_riesgo]
            }
        }
        
        results['niveles'] = niveles_data
        print(f"Niveles analizados: Prob={len(niveles_prob)}, Imp={len(niveles_imp)}, Riesgo={len(niveles_riesgo)}")
        
        # 5. Calcular puntuación de preparación para ML
        print("Calculando puntuacion de preparacion para ML...")
        
        scores = {
            'activos': 0,
            'evaluaciones': 0,
            'riesgos': 0,
            'niveles': 0
        }
        
        # Puntuación de activos (máximo 25 puntos)
        scores['activos'] += min(10, activos_data['total_activos'] / 10)  # 10 puntos por 100 activos
        scores['activos'] += min(15, sum(activos_data['completitud_datos'].values()) / 4)  # 15 puntos por completitud
        
        # Puntuación de evaluaciones (máximo 40 puntos)
        scores['evaluaciones'] += min(20, eval_data['total_evaluaciones'] * 2)  # 20 puntos por 10 evaluaciones
        scores['evaluaciones'] += min(20, sum(eval_data['completitud_evaluaciones'].values()) / 4)  # 20 puntos por completitud
        
        # Puntuación de riesgos (máximo 20 puntos)
        scores['riesgos'] += min(10, riesgos_data['total_riesgos'] / 5)  # 10 puntos por 5 riesgos
        scores['riesgos'] += min(10, sum(riesgos_data['completitud_datos'].values()) / 2)  # 10 puntos por completitud
        
        # Puntuación de niveles (máximo 15 puntos)
        scores['niveles'] += min(5, niveles_data['niveles_probabilidad']['total'])
        scores['niveles'] += min(5, niveles_data['niveles_impacto']['total'])
        scores['niveles'] += min(5, niveles_data['niveles_riesgo']['total'])
        
        total_score = sum(scores.values())
        max_score = 100
        
        ml_readiness = {
            'puntuacion_total': total_score,
            'puntuacion_maxima': max_score,
            'porcentaje': (total_score / max_score) * 100,
            'categoria': categorize_readiness((total_score / max_score) * 100),
            'scores_detallados': scores,
            'recomendaciones': generate_recommendations(scores)
        }
        
        results['ml_readiness'] = ml_readiness
        print(f"Puntuacion ML: {ml_readiness['porcentaje']:.1f}% ({ml_readiness['categoria']})")
        
        # 6. Guardar reporte
        report = {
            'fecha_analisis': datetime.now().isoformat(),
            'resultados': results
        }
        
        os.makedirs('backend/analysis/reports', exist_ok=True)
        filepath = 'backend/analysis/reports/data_quality_report.json'
        
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(report, f, indent=2, ensure_ascii=False, default=str)
        
        print("=" * 60)
        print("Analisis completo finalizado")
        print(f"Puntuacion ML: {ml_readiness['porcentaje']:.1f}%")
        print(f"Reporte: {filepath}")
        
        return results

def categorize_readiness(percentage):
    """Categorizar el nivel de preparación"""
    if percentage >= 80:
        return "Excelente - Listo para ML"
    elif percentage >= 60:
        return "Bueno - Preparacion moderada"
    elif percentage >= 40:
        return "Regular - Necesita mejoras"
    else:
        return "Bajo - Requiere trabajo significativo"

def generate_recommendations(scores):
    """Generar recomendaciones basadas en los scores"""
    recommendations = []
    
    if scores['activos'] < 15:
        recommendations.append("Aumentar la completitud de datos de activos")
    
    if scores['evaluaciones'] < 25:
        recommendations.append("Necesario mas evaluaciones para entrenar modelos ML")
    
    if scores['riesgos'] < 10:
        recommendations.append("Mejorar la calidad de descripciones de riesgos")
    
    if scores['niveles'] < 10:
        recommendations.append("Verificar configuracion de niveles de evaluacion")
    
    return recommendations

if __name__ == "__main__":
    analyze_data_quality()
