from flask import Blueprint, request, jsonify
from ..models import db, Riesgo, RiesgoActivo, Activo
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import func
from datetime import datetime

riesgos_bp = Blueprint('riesgos', __name__)

@riesgos_bp.route('/', methods=['GET'])
def get_riesgos():
    """Obtener todos los riesgos con filtros opcionales"""
    try:
        # Parámetros de filtrado
        tipo_riesgo = request.args.get('tipo_riesgo')
        estado = request.args.get('estado')
        
        query = Riesgo.query
        
        if tipo_riesgo:
            query = query.filter(Riesgo.tipo_riesgo == tipo_riesgo)
        if estado:
            query = query.filter(Riesgo.Estado_Riesgo_General == estado)
        
        riesgos = query.all()
        return jsonify([riesgo.to_dict() for riesgo in riesgos]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@riesgos_bp.route('/<int:riesgo_id>', methods=['GET'])
def get_riesgo(riesgo_id):
    """Obtener un riesgo específico por ID"""
    try:
        riesgo = Riesgo.query.filter_by(ID_Riesgo=riesgo_id).first_or_404()
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
        if not data.get('Nombre'):
            return jsonify({'error': 'El nombre del riesgo es obligatorio'}), 400
        
        riesgo = Riesgo(
            Nombre=data.get('Nombre'),
            Descripcion=data.get('Descripcion'),
            tipo_riesgo=data.get('tipo_riesgo'),
            Estado_Riesgo_General=data.get('Estado_Riesgo_General', 'Identificado')
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

@riesgos_bp.route('/estados', methods=['GET'])
def get_estados_riesgo():
    """Obtener todos los estados de riesgo únicos"""
    try:
        estados = db.session.query(Riesgo.Estado_Riesgo_General).distinct().all()
        return jsonify([estado[0] for estado in estados if estado[0]]), 200
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

@riesgos_bp.route('/matriz-riesgo', methods=['GET'])
def get_matriz_riesgo():
    """Obtener datos para la matriz de riesgos"""
    try:
        # Obtener todos los riesgos
        riesgos = Riesgo.query.all()
        
        # Configuración de la matriz
        probabilidades = ['Frecuente', 'Ocasional', 'Posible', 'Improbable']
        impactos = ['Insignificante', 'Menor', 'Moderado', 'Mayor', 'Catastrófico']
        
        # Mapeo de niveles de riesgo
        def calcular_nivel_riesgo(probabilidad, impacto):
            prob_values = {'Improbable': 1, 'Posible': 2, 'Ocasional': 3, 'Frecuente': 4}
            impacto_values = {'Insignificante': 1, 'Menor': 2, 'Moderado': 3, 'Mayor': 4, 'Catastrófico': 5}
            
            score = prob_values.get(probabilidad, 1) * impacto_values.get(impacto, 1)
            
            if score <= 6:
                return 'BAJO'
            elif score <= 11:
                return 'MEDIO'
            else:
                return 'ALTO'
        
        # Procesar riesgos y agrupar por celda de matriz
        cells = []
        for prob in probabilidades:
            for impacto in impactos:
                # Filtrar riesgos por probabilidad e impacto
                riesgos_celda = [
                    r for r in riesgos 
                    if r.Probabilidad_Riesgo == prob and r.Impacto_Riesgo == impacto
                ]
                
                if riesgos_celda:
                    nivel = calcular_nivel_riesgo(prob, impacto)
                    risks_data = []
                    
                    for riesgo in riesgos_celda:
                        # Obtener información del activo asociado
                        activo = Activo.query.filter_by(ID_Activo=riesgo.ID_Activo).first()
                        
                        risks_data.append({
                            'id': riesgo.ID_Riesgo,
                            'nombre': riesgo.Nombre,
                            'nivel': nivel,
                            'propietario': activo.Propietario_Activo if activo else 'No asignado',
                            'fecha': riesgo.Fecha_Identificacion.strftime('%Y-%m-%d') if riesgo.Fecha_Identificacion else '',
                            'activo': activo.Nombre_Activo if activo else 'Activo no encontrado',
                            'proceso': activo.Proceso_Negocio if activo else 'No especificado'
                        })
                    
                    cells.append({
                        'probabilidad_key': prob,
                        'impacto_key': impacto,
                        'count': len(riesgos_celda),
                        'risks': risks_data
                    })
        
        # Calcular salud institucional
        total_riesgos = len(riesgos)
        if total_riesgos > 0:
            riesgos_bajos = sum(1 for r in riesgos if calcular_nivel_riesgo(r.Probabilidad_Riesgo, r.Impacto_Riesgo) == 'BAJO')
            riesgos_medios = sum(1 for r in riesgos if calcular_nivel_riesgo(r.Probabilidad_Riesgo, r.Impacto_Riesgo) == 'MEDIO')
            riesgos_altos = sum(1 for r in riesgos if calcular_nivel_riesgo(r.Probabilidad_Riesgo, r.Impacto_Riesgo) == 'ALTO')
            
            # Calcular score de salud (0-100, donde 100 es mejor)
            score = max(0, 100 - (riesgos_altos * 30 + riesgos_medios * 15))
            
            health = {
                'low': round((riesgos_bajos / total_riesgos) * 100, 1),
                'medium': round((riesgos_medios / total_riesgos) * 100, 1),
                'high': round((riesgos_altos / total_riesgos) * 100, 1),
                'score': round(score, 1)
            }
        else:
            health = {
                'low': 0,
                'medium': 0,
                'high': 0,
                'score': 100
            }
        
        return jsonify({
            'cells': cells,
            'health': health
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500