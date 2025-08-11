from flask import Blueprint, request, jsonify
from ..models import db, Riesgo, RiesgoActivo, Activo
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime

riesgos_bp = Blueprint('riesgos', __name__)

@riesgos_bp.route('/', methods=['GET'])
def get_riesgos():
    """Obtener todos los riesgos con filtros opcionales"""
    try:
        # Parámetros de filtrado
        tipo_riesgo = request.args.get('tipo_riesgo')
        nivel_riesgo = request.args.get('nivel_riesgo')
        estado = request.args.get('estado')
        
        query = Riesgo.query
        
        if tipo_riesgo:
            query = query.filter(Riesgo.tipo_riesgo == tipo_riesgo)
        if nivel_riesgo:
            query = query.filter(Riesgo.nivel_riesgo == nivel_riesgo)
        if estado:
            query = query.filter(Riesgo.estado == estado)
        
        riesgos = query.all()
        return jsonify([riesgo.to_dict() for riesgo in riesgos]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/<int:riesgo_id>', methods=['GET'])
def get_riesgo(riesgo_id):
    """Obtener un riesgo específico por ID"""
    try:
        riesgo = Riesgo.query.get_or_404(riesgo_id)
        return jsonify(riesgo.to_dict()), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/', methods=['POST'])
def create_riesgo():
    """Crear un nuevo riesgo"""
    try:
        data = request.json
        if not data:
            return jsonify({'error': 'No se proporcionaron datos'}), 400
        
        # Validaciones básicas
        if not data.get('nombre_riesgo'):
            return jsonify({'error': 'El nombre del riesgo es obligatorio'}), 400
        
        riesgo = Riesgo(
            nombre_riesgo=data.get('nombre_riesgo'),
            descripcion=data.get('descripcion'),
            tipo_riesgo=data.get('tipo_riesgo'),
            nivel_riesgo=data.get('nivel_riesgo'),
            estado=data.get('estado', 'Activo')
        )
        
        db.session.add(riesgo)
        db.session.commit()
        
        return jsonify(riesgo.to_dict()), 201
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/<int:riesgo_id>', methods=['PUT'])
def update_riesgo(riesgo_id):
    """Actualizar un riesgo existente"""
    try:
        riesgo = Riesgo.query.get_or_404(riesgo_id)
        data = request.json
        
        if not data:
            return jsonify({'error': 'No se proporcionaron datos'}), 400
        
        # Actualizar campos
        if 'nombre_riesgo' in data:
            riesgo.nombre_riesgo = data['nombre_riesgo']
        if 'descripcion' in data:
            riesgo.descripcion = data['descripcion']
        if 'tipo_riesgo' in data:
            riesgo.tipo_riesgo = data['tipo_riesgo']
        if 'nivel_riesgo' in data:
            riesgo.nivel_riesgo = data['nivel_riesgo']
        if 'estado' in data:
            riesgo.estado = data['estado']
        
        db.session.commit()
        return jsonify(riesgo.to_dict()), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/<int:riesgo_id>', methods=['DELETE'])
def delete_riesgo(riesgo_id):
    """Eliminar un riesgo"""
    try:
        riesgo = Riesgo.query.get_or_404(riesgo_id)
        db.session.delete(riesgo)
        db.session.commit()
        return jsonify({'message': 'Riesgo eliminado correctamente'}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/tipos', methods=['GET'])
def get_tipos_riesgo():
    """Obtener todos los tipos de riesgo únicos"""
    try:
        tipos = db.session.query(Riesgo.tipo_riesgo).distinct().all()
        return jsonify([tipo[0] for tipo in tipos if tipo[0]]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/niveles', methods=['GET'])
def get_niveles_riesgo():
    """Obtener todos los niveles de riesgo únicos"""
    try:
        niveles = db.session.query(Riesgo.nivel_riesgo).distinct().all()
        return jsonify([nivel[0] for nivel in niveles if nivel[0]]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/<int:riesgo_id>/activos', methods=['GET'])
def get_activos_riesgo(riesgo_id):
    """Obtener los activos asociados a un riesgo"""
    try:
        riesgo = Riesgo.query.get_or_404(riesgo_id)
        activos = []
        for riesgo_activo in riesgo.activos:
            activo_data = riesgo_activo.activo.to_dict()
            activo_data.update({
                'probabilidad': riesgo_activo.probabilidad,
                'impacto': riesgo_activo.impacto,
                'nivel_riesgo_calculado': riesgo_activo.nivel_riesgo_calculado,
                'medidas_mitigacion': riesgo_activo.medidas_mitigacion,
                'fecha_evaluacion': riesgo_activo.fecha_evaluacion.isoformat() if riesgo_activo.fecha_evaluacion else None
            })
            activos.append(activo_data)
        return jsonify(activos), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/<int:riesgo_id>/activos/<int:activo_id>', methods=['POST'])
def asociar_riesgo_activo(riesgo_id, activo_id):
    """Asociar un riesgo a un activo con evaluación"""
    try:
        riesgo = Riesgo.query.get_or_404(riesgo_id)
        activo = Activo.query.get_or_404(activo_id)
        data = request.json
        
        if not data:
            return jsonify({'error': 'No se proporcionaron datos'}), 400
        
        # Validaciones
        if not data.get('probabilidad') or not data.get('impacto'):
            return jsonify({'error': 'La probabilidad e impacto son obligatorios'}), 400
        
        probabilidad = int(data['probabilidad'])
        impacto = int(data['impacto'])
        
        if not (1 <= probabilidad <= 5) or not (1 <= impacto <= 5):
            return jsonify({'error': 'La probabilidad e impacto deben estar entre 1 y 5'}), 400
        
        # Verificar si ya existe la asociación
        riesgo_activo_existente = RiesgoActivo.query.filter_by(
            id_riesgo=riesgo_id, 
            ID_Activo=activo_id
        ).first()
        
        if riesgo_activo_existente:
            return jsonify({'error': 'El riesgo ya está asociado a este activo'}), 400
        
        # Calcular nivel de riesgo
        nivel_riesgo = 'Bajo'
        riesgo_total = probabilidad * impacto
        if riesgo_total > 12:
            nivel_riesgo = 'Alto'
        elif riesgo_total > 4:
            nivel_riesgo = 'Medio'
        
        riesgo_activo = RiesgoActivo(
            id_riesgo=riesgo_id,
            ID_Activo=activo_id,
            probabilidad=probabilidad,
            impacto=impacto,
            nivel_riesgo_calculado=nivel_riesgo,
            medidas_mitigacion=data.get('medidas_mitigacion'),
            fecha_evaluacion=datetime.utcnow()
        )
        
        db.session.add(riesgo_activo)
        db.session.commit()
        
        return jsonify({
            'message': 'Riesgo asociado correctamente al activo',
            'nivel_riesgo_calculado': nivel_riesgo,
            'riesgo_total': riesgo_total
        }), 201
    except ValueError as e:
        return jsonify({'error': f'Error en formato de datos: {str(e)}'}), 400
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/<int:riesgo_id>/activos/<int:activo_id>', methods=['PUT'])
def actualizar_evaluacion_riesgo(riesgo_id, activo_id):
    """Actualizar la evaluación de un riesgo en un activo"""
    try:
        riesgo_activo = RiesgoActivo.query.filter_by(
            id_riesgo=riesgo_id, 
            ID_Activo=activo_id
        ).first_or_404()
        
        data = request.json
        if not data:
            return jsonify({'error': 'No se proporcionaron datos'}), 400
        
        # Actualizar campos
        if 'probabilidad' in data:
            probabilidad = int(data['probabilidad'])
            if not (1 <= probabilidad <= 5):
                return jsonify({'error': 'La probabilidad debe estar entre 1 y 5'}), 400
            riesgo_activo.probabilidad = probabilidad
        
        if 'impacto' in data:
            impacto = int(data['impacto'])
            if not (1 <= impacto <= 5):
                return jsonify({'error': 'El impacto debe estar entre 1 y 5'}), 400
            riesgo_activo.impacto = impacto
        
        if 'medidas_mitigacion' in data:
            riesgo_activo.medidas_mitigacion = data['medidas_mitigacion']
        
        # Recalcular nivel de riesgo
        if riesgo_activo.probabilidad and riesgo_activo.impacto:
            riesgo_total = riesgo_activo.probabilidad * riesgo_activo.impacto
            if riesgo_total > 12:
                riesgo_activo.nivel_riesgo_calculado = 'Alto'
            elif riesgo_total > 4:
                riesgo_activo.nivel_riesgo_calculado = 'Medio'
            else:
                riesgo_activo.nivel_riesgo_calculado = 'Bajo'
        
        riesgo_activo.fecha_evaluacion = datetime.utcnow()
        db.session.commit()
        
        return jsonify({
            'message': 'Evaluación actualizada correctamente',
            'nivel_riesgo_calculado': riesgo_activo.nivel_riesgo_calculado,
            'riesgo_total': riesgo_activo.probabilidad * riesgo_activo.impacto if riesgo_activo.probabilidad and riesgo_activo.impacto else None
        }), 200
    except ValueError as e:
        return jsonify({'error': f'Error en formato de datos: {str(e)}'}), 400
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/<int:riesgo_id>/activos/<int:activo_id>', methods=['DELETE'])
def desasociar_riesgo_activo(riesgo_id, activo_id):
    """Desasociar un riesgo de un activo"""
    try:
        riesgo_activo = RiesgoActivo.query.filter_by(
            id_riesgo=riesgo_id, 
            ID_Activo=activo_id
        ).first_or_404()
        
        db.session.delete(riesgo_activo)
        db.session.commit()
        
        return jsonify({'message': 'Riesgo desasociado correctamente del activo'}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500 