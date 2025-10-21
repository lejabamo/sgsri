from flask import Blueprint, request, jsonify
from ..models import db, Riesgo, Activo, evaluacion_riesgo_activo, controles_seguridad, nivelesriesgo
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import func, text
from datetime import datetime
import math

evaluacion_riesgos_bp = Blueprint('evaluacion_riesgos', __name__)

def calcular_nivel_riesgo(probabilidad_valor, impacto_valor):
    """Calcula el nivel de riesgo basado en probabilidad e impacto"""
    puntaje = probabilidad_valor * impacto_valor
    
    if puntaje <= 3:
        return 1  # Bajo
    elif puntaje <= 6:
        return 2  # Medio
    else:
        return 3  # Alto

@evaluacion_riesgos_bp.route('/niveles-probabilidad', methods=['GET'])
def get_niveles_probabilidad():
    """Obtener todos los niveles de probabilidad"""
    try:
        result = db.session.execute(text('SELECT ID_NivelProbabilidad, Nombre, Valor_Numerico, Descripcion FROM nivelesprobabilidad')).fetchall()
        return jsonify([{
            'id': row[0],
            'nombre': row[1],
            'valor': row[2],
            'descripcion': row[3],
            'color': '#6c757d'
        } for row in result]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/niveles-impacto', methods=['GET'])
def get_niveles_impacto():
    """Obtener todos los niveles de impacto"""
    try:
        result = db.session.execute(text('SELECT ID_NivelImpacto, Nombre, Valor_Numerico, Descripcion_Cualitativa FROM nivelesimpacto')).fetchall()
        return jsonify([{
            'id': row[0],
            'nombre': row[1],
            'valor': row[2],
            'descripcion': row[3],
            'color': '#6c757d'
        } for row in result]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/controles', methods=['GET'])
def get_controles():
    """Obtener todos los controles de seguridad"""
    try:
        controles = controles_seguridad.query.all()
        return jsonify([{
            'id': control.ID_Control,
            'nombre': control.Nombre,
            'descripcion': control.Descripcion,
            'categoria': control.Categoria,
            'tipo': control.Tipo,
            'eficacia_esperada': control.Eficacia_Esperada
        } for control in controles]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/riesgos-pendientes', methods=['GET'])
def get_riesgos_pendientes():
    """Obtener riesgos que no han sido evaluados"""
    try:
        # Obtener riesgos que no tienen evaluación
        riesgos_evaluados = db.session.query(evaluacion_riesgo_activo.ID_Riesgo).distinct().subquery()
        
        riesgos_pendientes = db.session.query(Riesgo).filter(
            ~Riesgo.ID_Riesgo.in_(db.session.query(riesgos_evaluados.c.ID_Riesgo))
        ).all()
        
        return jsonify([{
            'id': riesgo.ID_Riesgo,
            'nombre': riesgo.Nombre,
            'descripcion': riesgo.Descripcion,
            'tipo_riesgo': riesgo.tipo_riesgo,
            'estado': riesgo.Estado_Riesgo_General,
            'fecha_identificacion': riesgo.Fecha_Identificacion.isoformat() if riesgo.Fecha_Identificacion else None
        } for riesgo in riesgos_pendientes]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/evaluar', methods=['POST'])
def crear_evaluacion():
    """Crear una nueva evaluación de riesgo"""
    try:
        data = request.get_json()
        
        # Validar datos requeridos
        required_fields = ['id_riesgo', 'id_activo', 'probabilidad_inherente', 'impacto_inherente', 'justificacion_inherente']
        for field in required_fields:
            if field not in data:
                return jsonify({'error': f'Campo requerido: {field}'}), 400
        
        # Obtener valores de probabilidad e impacto
        prob_result = db.session.execute(text('SELECT Valor_Numerico FROM nivelesprobabilidad WHERE ID_NivelProbabilidad = :id'), {'id': data['probabilidad_inherente']}).fetchone()
        impacto_result = db.session.execute(text('SELECT Valor_Numerico FROM nivelesimpacto WHERE ID_NivelImpacto = :id'), {'id': data['impacto_inherente']}).fetchone()
        
        if not prob_result or not impacto_result:
            return jsonify({'error': 'Niveles de probabilidad o impacto no válidos'}), 400
        
        # Calcular nivel de riesgo inherente
        nivel_riesgo_inherente = calcular_nivel_riesgo(prob_result[0], impacto_result[0])
        
        # Crear evaluación inherente
        evaluacion = evaluacion_riesgo_activo(
            ID_Riesgo=data['id_riesgo'],
            ID_Activo=data['id_activo'],
            id_nivel_probabilidad_inherente=data['probabilidad_inherente'],
            id_nivel_impacto_inherente=data['impacto_inherente'],
            id_nivel_riesgo_inherente_calculado=nivel_riesgo_inherente,
            justificacion_evaluacion_inherente=data['justificacion_inherente'],
            fecha_evaluacion_inherente=datetime.now().date(),
            id_evaluador_inherente=1,  # TODO: Obtener del usuario autenticado
            fecha_creacion_registro=datetime.now()
        )
        
        # Si hay evaluación residual
        if 'probabilidad_residual' in data and 'impacto_residual' in data:
            prob_residual_result = db.session.execute(text('SELECT Valor_Numerico FROM nivelesprobabilidad WHERE ID_NivelProbabilidad = :id'), {'id': data['probabilidad_residual']}).fetchone()
            impacto_residual_result = db.session.execute(text('SELECT Valor_Numerico FROM nivelesimpacto WHERE ID_NivelImpacto = :id'), {'id': data['impacto_residual']}).fetchone()
            
            if prob_residual_result and impacto_residual_result:
                nivel_riesgo_residual = calcular_nivel_riesgo(prob_residual_result[0], impacto_residual_result[0])
                
                evaluacion.id_nivel_probabilidad_residual = data['probabilidad_residual']
                evaluacion.id_nivel_impacto_residual = data['impacto_residual']
                evaluacion.id_nivel_riesgo_residual_calculado = nivel_riesgo_residual
                evaluacion.justificacion_evaluacion_residual = data.get('justificacion_residual', '')
                evaluacion.fecha_evaluacion_residual = datetime.now().date()
                evaluacion.id_evaluador_residual = 1  # TODO: Obtener del usuario autenticado
        
        db.session.add(evaluacion)
        db.session.commit()
        
        return jsonify({
            'id': evaluacion.id_evaluacion_riesgo_activo,
            'nivel_riesgo_inherente': nivel_riesgo_inherente,
            'nivel_riesgo_residual': evaluacion.id_nivel_riesgo_residual_calculado,
            'message': 'Evaluación creada exitosamente'
        }), 201
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/matriz-riesgo', methods=['GET'])
def get_matriz_riesgo():
    """Obtener matriz de riesgo con conteos por nivel"""
    try:
        # Obtener todas las evaluaciones con sus niveles
        evaluaciones = db.session.query(
            evaluacion_riesgo_activo.id_nivel_riesgo_residual_calculado,
            func.count(evaluacion_riesgo_activo.id_evaluacion_riesgo_activo).label('count')
        ).group_by(evaluacion_riesgo_activo.id_nivel_riesgo_residual_calculado).all()
        
        # Obtener nombres de niveles
        niveles = {n.ID_NivelRiesgo: n.Nombre for n in nivelesriesgo.query.all()}
        
        matriz_data = {}
        for nivel_id, count in evaluaciones:
            nivel_nombre = niveles.get(nivel_id, f'Nivel_{nivel_id}')
            matriz_data[nivel_nombre] = count
        
        return jsonify(matriz_data), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/estadisticas', methods=['GET'])
def get_estadisticas_evaluacion():
    """Obtener estadísticas de evaluación de riesgos"""
    try:
        # Total de riesgos
        total_riesgos = Riesgo.query.count()
        
        # Riesgos evaluados
        riesgos_evaluados = db.session.query(evaluacion_riesgo_activo.ID_Riesgo).distinct().count()
        
        # Riesgos pendientes
        riesgos_pendientes = total_riesgos - riesgos_evaluados
        
        # Distribución por nivel de riesgo
        distribucion = db.session.query(
            nivelesriesgo.Nombre,
            func.count(evaluacion_riesgo_activo.id_evaluacion_riesgo_activo)
        ).join(
            evaluacion_riesgo_activo,
            nivelesriesgo.ID_NivelRiesgo == evaluacion_riesgo_activo.id_nivel_riesgo_residual_calculado
        ).group_by(nivelesriesgo.Nombre).all()
        
        distribucion_dict = {nivel: count for nivel, count in distribucion}
        
        # Porcentaje de evaluación
        porcentaje_evaluacion = (riesgos_evaluados / total_riesgos * 100) if total_riesgos > 0 else 0
        
        return jsonify({
            'total_riesgos': total_riesgos,
            'riesgos_evaluados': riesgos_evaluados,
            'riesgos_pendientes': riesgos_pendientes,
            'porcentaje_evaluacion': round(porcentaje_evaluacion, 2),
            'distribucion_niveles': distribucion_dict
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/evaluaciones', methods=['GET'])
def get_evaluaciones():
    """Obtener todas las evaluaciones con detalles"""
    try:
        evaluaciones = db.session.query(
            evaluacion_riesgo_activo,
            Riesgo.Nombre.label('riesgo_nombre'),
            Activo.Nombre.label('activo_nombre'),
            niveles_probabilidad.Nombre.label('prob_inherente_nombre'),
            niveles_impacto.Nombre.label('impacto_inherente_nombre'),
            nivelesriesgo.Nombre.label('nivel_riesgo_inherente_nombre')
        ).join(
            Riesgo, evaluacion_riesgo_activo.ID_Riesgo == Riesgo.ID_Riesgo
        ).join(
            Activo, evaluacion_riesgo_activo.ID_Activo == Activo.ID_Activo
        ).join(
            niveles_probabilidad, evaluacion_riesgo_activo.id_nivel_probabilidad_inherente == niveles_probabilidad.ID_NivelProbabilidad
        ).join(
            niveles_impacto, evaluacion_riesgo_activo.id_nivel_impacto_inherente == niveles_impacto.ID_NivelImpacto
        ).join(
            nivelesriesgo, evaluacion_riesgo_activo.id_nivel_riesgo_inherente_calculado == nivelesriesgo.ID_NivelRiesgo
        ).all()
        
        return jsonify([{
            'id': eval.id_evaluacion_riesgo_activo,
            'riesgo': {
                'id': eval.ID_Riesgo,
                'nombre': eval.riesgo_nombre
            },
            'activo': {
                'id': eval.ID_Activo,
                'nombre': eval.activo_nombre
            },
            'evaluacion_inherente': {
                'probabilidad': eval.prob_inherente_nombre,
                'impacto': eval.impacto_inherente_nombre,
                'nivel_riesgo': eval.nivel_riesgo_inherente_nombre
            },
            'fecha_evaluacion': eval.fecha_evaluacion_inherente.isoformat() if eval.fecha_evaluacion_inherente else None
        } for eval in evaluaciones]), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500
