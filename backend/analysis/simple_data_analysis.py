#!/usr/bin/env python3
"""
Análisis Simple de Calidad de Datos - Fase 0
SGSRI - Sistema Predictivo de Riesgos ISO
"""

import pandas as pd
import numpy as np
from sqlalchemy import create_engine, text
from datetime import datetime
import json
import os

class SimpleDataAnalyzer:
    def __init__(self, db_url):
        self.engine = create_engine(db_url)
        self.analysis_results = {}
        
    def analyze_activos(self):
        """Analizar calidad y patrones de los activos"""
        print("Analizando activos...")
        
        query = """
        SELECT 
            ID_Activo,
            Nombre,
            Tipo_Activo,
            nivel_criticidad_negocio,
            estado_activo,
            fecha_creacion,
            fecha_modificacion
        FROM Activo
        """
        
        df = pd.read_sql(query, self.engine)
        
        analysis = {
            'total_activos': len(df),
            'tipos_activo': df['Tipo_Activo'].value_counts().to_dict(),
            'niveles_criticidad': df['nivel_criticidad_negocio'].value_counts().to_dict(),
            'estados_activo': df['estado_activo'].value_counts().to_dict(),
            'completitud_datos': {
                'nombre_completo': df['Nombre'].notna().sum() / len(df) * 100,
                'tipo_completo': df['Tipo_Activo'].notna().sum() / len(df) * 100,
                'criticidad_completa': df['nivel_criticidad_negocio'].notna().sum() / len(df) * 100,
            }
        }
        
        self.analysis_results['activos'] = analysis
        print(f"Activos analizados: {analysis['total_activos']}")
        return analysis
    
    def analyze_evaluaciones(self):
        """Analizar calidad y patrones de las evaluaciones"""
        print("Analizando evaluaciones...")
        
        query = """
        SELECT 
            era.ID_Activo,
            era.ID_Riesgo,
            era.fecha_evaluacion_inherente,
            era.fecha_evaluacion_residual,
            era.id_nivel_probabilidad_inherente,
            era.id_nivel_impacto_inherente,
            era.id_nivel_riesgo_inherente_calculado,
            era.justificacion_evaluacion_inherente,
            era.justificacion_evaluacion_residual,
            a.Nombre as activo_nombre,
            r.Nombre as riesgo_nombre
        FROM evaluacion_riesgo_activo era
        LEFT JOIN Activo a ON era.ID_Activo = a.ID_Activo
        LEFT JOIN Riesgo r ON era.ID_Riesgo = r.ID_Riesgo
        """
        
        df = pd.read_sql(query, self.engine)
        
        analysis = {
            'total_evaluaciones': len(df),
            'activos_evaluados': df['ID_Activo'].nunique(),
            'riesgos_evaluados': df['ID_Riesgo'].nunique(),
            'completitud_evaluaciones': {
                'fecha_inherente': df['fecha_evaluacion_inherente'].notna().sum() / len(df) * 100,
                'fecha_residual': df['fecha_evaluacion_residual'].notna().sum() / len(df) * 100,
                'justificacion_inherente': df['justificacion_evaluacion_inherente'].notna().sum() / len(df) * 100,
                'justificacion_residual': df['justificacion_evaluacion_residual'].notna().sum() / len(df) * 100,
            }
        }
        
        self.analysis_results['evaluaciones'] = analysis
        print(f"Evaluaciones analizadas: {analysis['total_evaluaciones']}")
        return analysis
    
    def analyze_riesgos(self):
        """Analizar calidad y patrones de los riesgos"""
        print("Analizando riesgos...")
        
        query = """
        SELECT 
            ID_Riesgo,
            Nombre,
            Descripcion
        FROM Riesgo
        """
        
        df = pd.read_sql(query, self.engine)
        
        analysis = {
            'total_riesgos': len(df),
            'completitud_datos': {
                'nombre_completo': df['Nombre'].notna().sum() / len(df) * 100,
                'descripcion_completa': df['Descripcion'].notna().sum() / len(df) * 100,
            },
            'longitud_descripciones': {
                'promedio': df['Descripcion'].str.len().mean() if 'Descripcion' in df.columns else 0,
                'minima': df['Descripcion'].str.len().min() if 'Descripcion' in df.columns else 0,
                'maxima': df['Descripcion'].str.len().max() if 'Descripcion' in df.columns else 0,
            }
        }
        
        self.analysis_results['riesgos'] = analysis
        print(f"Riesgos analizados: {analysis['total_riesgos']}")
        return analysis
    
    def generate_ml_readiness_score(self):
        """Calcular puntuación de preparación para ML"""
        print("Calculando puntuacion de preparacion para ML...")
        
        scores = {
            'activos': 0,
            'evaluaciones': 0,
            'riesgos': 0
        }
        
        # Puntuación de activos (máximo 25 puntos)
        if 'activos' in self.analysis_results:
            activos = self.analysis_results['activos']
            scores['activos'] += min(10, activos['total_activos'] / 10)  # 10 puntos por 100 activos
            scores['activos'] += min(15, sum(activos['completitud_datos'].values()) / 4)  # 15 puntos por completitud
        
        # Puntuación de evaluaciones (máximo 40 puntos)
        if 'evaluaciones' in self.analysis_results:
            eval_data = self.analysis_results['evaluaciones']
            scores['evaluaciones'] += min(20, eval_data['total_evaluaciones'] * 2)  # 20 puntos por 10 evaluaciones
            scores['evaluaciones'] += min(20, sum(eval_data['completitud_evaluaciones'].values()) / 4)  # 20 puntos por completitud
        
        # Puntuación de riesgos (máximo 20 puntos)
        if 'riesgos' in self.analysis_results:
            riesgos = self.analysis_results['riesgos']
            scores['riesgos'] += min(10, riesgos['total_riesgos'] / 5)  # 10 puntos por 5 riesgos
            scores['riesgos'] += min(10, sum(riesgos['completitud_datos'].values()) / 2)  # 10 puntos por completitud
        
        total_score = sum(scores.values())
        max_score = 85  # Ajustado sin niveles
        
        ml_readiness = {
            'puntuacion_total': total_score,
            'puntuacion_maxima': max_score,
            'porcentaje': (total_score / max_score) * 100,
            'categoria': self._categorize_readiness((total_score / max_score) * 100),
            'scores_detallados': scores,
            'recomendaciones': self._generate_recommendations(scores)
        }
        
        self.analysis_results['ml_readiness'] = ml_readiness
        print(f"Puntuacion ML: {ml_readiness['porcentaje']:.1f}% ({ml_readiness['categoria']})")
        return ml_readiness
    
    def _categorize_readiness(self, percentage):
        """Categorizar el nivel de preparación"""
        if percentage >= 80:
            return "Excelente - Listo para ML"
        elif percentage >= 60:
            return "Bueno - Preparacion moderada"
        elif percentage >= 40:
            return "Regular - Necesita mejoras"
        else:
            return "Bajo - Requiere trabajo significativo"
    
    def _generate_recommendations(self, scores):
        """Generar recomendaciones basadas en los scores"""
        recommendations = []
        
        if scores['activos'] < 15:
            recommendations.append("Aumentar la completitud de datos de activos")
        
        if scores['evaluaciones'] < 25:
            recommendations.append("Necesario mas evaluaciones para entrenar modelos ML")
        
        if scores['riesgos'] < 10:
            recommendations.append("Mejorar la calidad de descripciones de riesgos")
        
        return recommendations
    
    def save_analysis_report(self, filename="data_quality_report.json"):
        """Guardar reporte de análisis"""
        report = {
            'fecha_analisis': datetime.now().isoformat(),
            'resultados': self.analysis_results
        }
        
        os.makedirs('backend/analysis/reports', exist_ok=True)
        filepath = f'backend/analysis/reports/{filename}'
        
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(report, f, indent=2, ensure_ascii=False, default=str)
        
        print(f"Reporte guardado en: {filepath}")
        return filepath
    
    def run_full_analysis(self):
        """Ejecutar análisis completo"""
        print("Iniciando analisis completo de calidad de datos...")
        print("=" * 60)
        
        try:
            self.analyze_activos()
            self.analyze_evaluaciones()
            self.analyze_riesgos()
            self.generate_ml_readiness_score()
            
            # Guardar reporte
            report_path = self.save_analysis_report()
            
            print("=" * 60)
            print("Analisis completo finalizado")
            print(f"Puntuacion ML: {self.analysis_results['ml_readiness']['porcentaje']:.1f}%")
            print(f"Reporte: {report_path}")
            
            return self.analysis_results
            
        except Exception as e:
            print(f"Error en analisis: {str(e)}")
            raise

def main():
    # Configuración de base de datos
    db_url = "mysql+mysqlconnector://root:123456@localhost:3306/sgri"
    
    # Ejecutar análisis
    analyzer = SimpleDataAnalyzer(db_url)
    results = analyzer.run_full_analysis()
    
    return results

if __name__ == "__main__":
    main()
