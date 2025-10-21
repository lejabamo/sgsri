from flask import Blueprint, request, jsonify
from ..models import db, Activo, UsuarioSistema
from ..auth.decorators import require_auth, operator_required, consultant_required
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime

activos_bp = Blueprint('activos', __name__)

@activos_bp.route('/', methods=['GET'])
# @consultant_required  # Temporalmente deshabilitado para desarrollo
def get_activos():
    """Obtener todos los activos con filtros opcionales"""
    try:
        # Parámetros de filtrado
        tipo_activo = request.args.get('tipo_activo')
        estado = request.args.get('estado')
        nivel_criticidad = request.args.get('nivel_criticidad')
        
        query = Activo.query
        
        if tipo_activo:
            query = query.filter(Activo.Tipo_Activo == tipo_activo)
        if estado:
            query = query.filter(Activo.estado_activo == estado)
        if nivel_criticidad:
            query = query.filter(Activo.nivel_criticidad_negocio == nivel_criticidad)
        
        activos = query.all()
        return jsonify([activo.to_dict() for activo in activos]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@activos_bp.route('/stats', methods=['GET'])
def get_activos_stats():
    """Estadísticas normalizadas para KPIs de gestión de activos.

    - en_produccion: estado_activo ∈ {'En produccion','En producción','Producción','Productivo'} (case/tilde insensitive)
    - alta_criticidad: nivel_criticidad_negocio ∈ {'Crítico','Critico','Muy Alto','Alto'} (case/tilde insensitive)
    - requieren_backup: requiere_backup = True
    """
    try:
        total = Activo.query.count()

        # Normalización simple en SQL con LOWER/REPLACE para acentos comunes
        en_produccion = db.session.execute(
            """
            SELECT COUNT(*) FROM activos a
            WHERE LOWER(REPLACE(a.estado_activo, 'ó', 'o')) IN (
              'en produccion','produccion','productivo'
            )
            """
        ).scalar() or 0

        alta_criticidad = db.session.execute(
            """
            SELECT COUNT(*) FROM activos a
            WHERE LOWER(REPLACE(a.nivel_criticidad_negocio, 'í', 'i')) IN (
              'critico','muy alto','alto'
            )
            """
        ).scalar() or 0

        requieren_backup = db.session.execute(
            "SELECT COUNT(*) FROM activos a WHERE a.requiere_backup = 1"
        ).scalar() or 0

        return jsonify({
            'total': int(total),
            'en_produccion': int(en_produccion),
            'alta_criticidad': int(alta_criticidad),
            'requieren_backup': int(requieren_backup)
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@activos_bp.route('/<int:activo_id>', methods=['GET'])
@consultant_required
def get_activo(activo_id):
    """Obtener un activo específico por ID"""
    try:
        activo = Activo.query.get_or_404(activo_id)
        return jsonify(activo.to_dict()), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@activos_bp.route('/', methods=['POST'])
@operator_required
def create_activo():
    """Crear un nuevo activo"""
    try:
        data = request.json
        if not data:
            return jsonify({'error': 'No se proporcionaron datos'}), 400
        
        # Validaciones básicas
        if not data.get('Nombre'):
            return jsonify({'error': 'El nombre del activo es obligatorio'}), 400
        if not data.get('Tipo_Activo'):
            return jsonify({'error': 'El tipo de activo es obligatorio'}), 400
        
        # Verificar si el propietario existe
        if data.get('ID_Propietario'):
            propietario = UsuarioSistema.query.get(data['ID_Propietario'])
            if not propietario:
                return jsonify({'error': 'El propietario especificado no existe'}), 400
        
        # Verificar si el custodio existe
        if data.get('ID_Custodio'):
            custodio = UsuarioSistema.query.get(data['ID_Custodio'])
            if not custodio:
                return jsonify({'error': 'El custodio especificado no existe'}), 400
        
        activo = Activo(
            Nombre=data.get('Nombre'),
            Descripcion=data.get('Descripcion'),
            Tipo_Activo=data.get('Tipo_Activo'),
            subtipo_activo=data.get('subtipo_activo'),
            ID_Propietario=data.get('ID_Propietario'),
            ID_Custodio=data.get('ID_Custodio'),
            Nivel_Clasificacion_Confidencialidad=data.get('Nivel_Clasificacion_Confidencialidad', 'Uso Interno'),
            Nivel_Clasificacion_Integridad=data.get('Nivel_Clasificacion_Integridad', 'Media'),
            Nivel_Clasificacion_Disponibilidad=data.get('Nivel_Clasificacion_Disponibilidad', 'Media'),
            justificacion_clasificacion_cia=data.get('justificacion_clasificacion_cia'),
            nivel_criticidad_negocio=data.get('nivel_criticidad_negocio', 'Medio'),
            estado_activo=data.get('estado_activo', 'Planificado'),
            fuente_datos_principal=data.get('fuente_datos_principal', 'SGSI_Manual'),
            id_externo_glpi=data.get('id_externo_glpi'),
            id_externo_inventario_si=data.get('id_externo_inventario_si'),
            fecha_adquisicion=datetime.strptime(data['fecha_adquisicion'], '%Y-%m-%d').date() if data.get('fecha_adquisicion') else None,
            version_general_activo=data.get('version_general_activo'),
            requiere_backup=data.get('requiere_backup', True),
            frecuencia_backup_general=data.get('frecuencia_backup_general'),
            tiempo_retencion_general=data.get('tiempo_retencion_general'),
            fecha_proxima_revision_sgsi=datetime.strptime(data['fecha_proxima_revision_sgsi'], '%Y-%m-%d').date() if data.get('fecha_proxima_revision_sgsi') else None,
            procedimiento_eliminacion_segura_ref=data.get('procedimiento_eliminacion_segura_ref')
        )
        
        db.session.add(activo)
        db.session.commit()
        
        return jsonify(activo.to_dict()), 201
    except ValueError as e:
        return jsonify({'error': f'Error en formato de fecha: {str(e)}'}), 400
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@activos_bp.route('/<int:activo_id>', methods=['PUT'])
def update_activo(activo_id):
    """Actualizar un activo existente"""
    try:
        activo = Activo.query.get_or_404(activo_id)
        data = request.json
        
        if not data:
            return jsonify({'error': 'No se proporcionaron datos'}), 400
        
        # Actualizar campos
        if 'Nombre' in data:
            activo.Nombre = data['Nombre']
        if 'Descripcion' in data:
            activo.Descripcion = data['Descripcion']
        if 'Tipo_Activo' in data:
            activo.Tipo_Activo = data['Tipo_Activo']
        if 'subtipo_activo' in data:
            activo.subtipo_activo = data['subtipo_activo']
        if 'ID_Propietario' in data:
            if data['ID_Propietario']:
                propietario = UsuarioSistema.query.get(data['ID_Propietario'])
                if not propietario:
                    return jsonify({'error': 'El propietario especificado no existe'}), 400
            activo.ID_Propietario = data['ID_Propietario']
        if 'ID_Custodio' in data:
            if data['ID_Custodio']:
                custodio = UsuarioSistema.query.get(data['ID_Custodio'])
                if not custodio:
                    return jsonify({'error': 'El custodio especificado no existe'}), 400
            activo.ID_Custodio = data['ID_Custodio']
        if 'Nivel_Clasificacion_Confidencialidad' in data:
            activo.Nivel_Clasificacion_Confidencialidad = data['Nivel_Clasificacion_Confidencialidad']
        if 'Nivel_Clasificacion_Integridad' in data:
            activo.Nivel_Clasificacion_Integridad = data['Nivel_Clasificacion_Integridad']
        if 'Nivel_Clasificacion_Disponibilidad' in data:
            activo.Nivel_Clasificacion_Disponibilidad = data['Nivel_Clasificacion_Disponibilidad']
        if 'justificacion_clasificacion_cia' in data:
            activo.justificacion_clasificacion_cia = data['justificacion_clasificacion_cia']
        if 'nivel_criticidad_negocio' in data:
            activo.nivel_criticidad_negocio = data['nivel_criticidad_negocio']
        if 'estado_activo' in data:
            activo.estado_activo = data['estado_activo']
        if 'fecha_adquisicion' in data:
            activo.fecha_adquisicion = datetime.strptime(data['fecha_adquisicion'], '%Y-%m-%d').date() if data['fecha_adquisicion'] else None
        if 'fecha_proxima_revision_sgsi' in data:
            activo.fecha_proxima_revision_sgsi = datetime.strptime(data['fecha_proxima_revision_sgsi'], '%Y-%m-%d').date() if data['fecha_proxima_revision_sgsi'] else None
        if 'requiere_backup' in data:
            activo.requiere_backup = data['requiere_backup']
        if 'frecuencia_backup_general' in data:
            activo.frecuencia_backup_general = data['frecuencia_backup_general']
        if 'tiempo_retencion_general' in data:
            activo.tiempo_retencion_general = data['tiempo_retencion_general']
        
        db.session.commit()
        return jsonify(activo.to_dict()), 200
    except ValueError as e:
        return jsonify({'error': f'Error en formato de fecha: {str(e)}'}), 400
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@activos_bp.route('/<int:activo_id>', methods=['DELETE'])
def delete_activo(activo_id):
    """Eliminar un activo"""
    try:
        activo = Activo.query.get_or_404(activo_id)
        db.session.delete(activo)
        db.session.commit()
        return jsonify({'message': 'Activo eliminado correctamente'}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@activos_bp.route('/tipos', methods=['GET'])
def get_tipos_activo():
    """Obtener todos los tipos de activo únicos"""
    try:
        tipos = db.session.query(Activo.Tipo_Activo).distinct().all()
        return jsonify([tipo[0] for tipo in tipos]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@activos_bp.route('/estados', methods=['GET'])
def get_estados_activo():
    """Obtener todos los estados de activo únicos"""
    try:
        estados = db.session.query(Activo.estado_activo).distinct().all()
        return jsonify([estado[0] for estado in estados]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@activos_bp.route('/<int:activo_id>/riesgos', methods=['GET'])
def get_riesgos_activo(activo_id):
    """Obtener los riesgos asociados a un activo"""
    try:
        activo = Activo.query.get_or_404(activo_id)
        riesgos = []
        for riesgo_activo in activo.riesgos:
            riesgo_data = riesgo_activo.riesgo.to_dict()
            riesgo_data.update({
                'probabilidad': riesgo_activo.probabilidad,
                'impacto': riesgo_activo.impacto,
                'nivel_riesgo_calculado': riesgo_activo.nivel_riesgo_calculado,
                'medidas_mitigacion': riesgo_activo.medidas_mitigacion,
                'fecha_evaluacion': riesgo_activo.fecha_evaluacion.isoformat() if riesgo_activo.fecha_evaluacion else None
            })
            riesgos.append(riesgo_data)
        return jsonify(riesgos), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500 