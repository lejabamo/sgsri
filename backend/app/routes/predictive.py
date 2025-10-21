"""
Rutas de la API para el sistema predictivo basado en normas ISO
"""

from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
import logging
from typing import Dict, Any

from ..services.predictive.suggestion_service import PredictiveSuggestionService
from ..services.predictive.pdf_processor import ISOPDFProcessor

# Configurar logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Crear Blueprint
predictive_bp = Blueprint('predictive', __name__, url_prefix='/api/predictive')

# Inicializar servicios
suggestion_service = PredictiveSuggestionService()
pdf_processor = ISOPDFProcessor()

@predictive_bp.route('/suggestions/threats', methods=['POST'])
@jwt_required()
def suggest_threats():
    """Sugerir amenazas basadas en el tipo de activo"""
    try:
        data = request.get_json()
        asset_type = data.get('asset_type', '')
        context = data.get('context', '')
        
        if not asset_type:
            return jsonify({'error': 'asset_type es requerido'}), 400
        
        suggestions = suggestion_service.suggest_threats_for_asset(asset_type, context)
        
        return jsonify({
            'success': True,
            'suggestions': suggestions,
            'metadata': {
                'asset_type': asset_type,
                'context': context,
                'total_suggestions': len(suggestions)
            }
        })
        
    except Exception as e:
        logger.error(f"Error al sugerir amenazas: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/suggestions/vulnerabilities', methods=['POST'])
@jwt_required()
def suggest_vulnerabilities():
    """Sugerir vulnerabilidades basadas en la amenaza seleccionada"""
    try:
        data = request.get_json()
        threat_id = data.get('threat_id', '')
        asset_type = data.get('asset_type', '')
        
        if not threat_id:
            return jsonify({'error': 'threat_id es requerido'}), 400
        
        suggestions = suggestion_service.suggest_vulnerabilities_for_threat(threat_id, asset_type)
        
        return jsonify({
            'success': True,
            'suggestions': suggestions,
            'metadata': {
                'threat_id': threat_id,
                'asset_type': asset_type,
                'total_suggestions': len(suggestions)
            }
        })
        
    except Exception as e:
        logger.error(f"Error al sugerir vulnerabilidades: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/suggestions/controls', methods=['POST'])
@jwt_required()
def suggest_controls():
    """Sugerir controles basados en amenaza y vulnerabilidad"""
    try:
        data = request.get_json()
        threat_id = data.get('threat_id', '')
        vulnerability_id = data.get('vulnerability_id', '')
        asset_type = data.get('asset_type', '')
        
        if not threat_id or not vulnerability_id:
            return jsonify({'error': 'threat_id y vulnerability_id son requeridos'}), 400
        
        suggestions = suggestion_service.suggest_controls_for_risk(
            threat_id, vulnerability_id, asset_type
        )
        
        return jsonify({
            'success': True,
            'suggestions': suggestions,
            'metadata': {
                'threat_id': threat_id,
                'vulnerability_id': vulnerability_id,
                'asset_type': asset_type,
                'total_suggestions': len(suggestions)
            }
        })
        
    except Exception as e:
        logger.error(f"Error al sugerir controles: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/suggestions/complete', methods=['POST'])
@jwt_required()
def get_complete_suggestions():
    """Obtener sugerencias completas para evaluación de riesgos"""
    try:
        data = request.get_json()
        asset_type = data.get('asset_type', '')
        context = data.get('context', '')
        
        if not asset_type:
            return jsonify({'error': 'asset_type es requerido'}), 400
        
        suggestions = suggestion_service.get_risk_assessment_suggestions(asset_type, context)
        
        return jsonify({
            'success': True,
            'data': suggestions
        })
        
    except Exception as e:
        logger.error(f"Error al obtener sugerencias completas: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/knowledge-base/status', methods=['GET'])
@jwt_required()
def get_knowledge_base_status():
    """Obtener estado de la base de conocimiento"""
    try:
        knowledge_base = suggestion_service.knowledge_base
        
        status = {
            'controles_count': len(knowledge_base.get('controles', {})),
            'amenazas_count': len(knowledge_base.get('amenazas', {})),
            'vulnerabilidades_count': len(knowledge_base.get('vulnerabilidades', {})),
            'relaciones_count': len(knowledge_base.get('relaciones', {})),
            'last_updated': 'N/A'  # Se puede implementar timestamp
        }
        
        return jsonify({
            'success': True,
            'status': status
        })
        
    except Exception as e:
        logger.error(f"Error al obtener estado de la base de conocimiento: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/knowledge-base/refresh', methods=['POST'])
@jwt_required()
def refresh_knowledge_base():
    """Refrescar la base de conocimiento procesando documentos ISO"""
    try:
        # Procesar documentos ISO
        processed_data = pdf_processor.process_all_documents()
        
        # Guardar datos procesados
        if pdf_processor.save_processed_data():
            # Recargar el servicio de sugerencias
            global suggestion_service
            suggestion_service = PredictiveSuggestionService()
            
            return jsonify({
                'success': True,
                'message': 'Base de conocimiento actualizada exitosamente',
                'data': {
                    'controles': len(processed_data.get('controles', {})),
                    'amenazas': len(processed_data.get('amenazas', {})),
                    'vulnerabilidades': len(processed_data.get('vulnerabilidades', {}))
                }
            })
        else:
            return jsonify({'error': 'Error al guardar la base de conocimiento'}), 500
        
    except Exception as e:
        logger.error(f"Error al refrescar la base de conocimiento: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/asset-types', methods=['GET'])
@jwt_required()
def get_asset_types():
    """Obtener tipos de activos disponibles"""
    try:
        asset_types = [
            {
                'id': 'servidor',
                'nombre': 'Servidor',
                'descripcion': 'Servidores físicos o virtuales'
            },
            {
                'id': 'base_datos',
                'nombre': 'Base de Datos',
                'descripcion': 'Sistemas de gestión de bases de datos'
            },
            {
                'id': 'aplicacion',
                'nombre': 'Aplicación',
                'descripcion': 'Aplicaciones de software'
            },
            {
                'id': 'red',
                'nombre': 'Red',
                'descripcion': 'Infraestructura de red'
            },
            {
                'id': 'dispositivo_movil',
                'nombre': 'Dispositivo Móvil',
                'descripcion': 'Dispositivos móviles y portátiles'
            },
            {
                'id': 'infraestructura',
                'nombre': 'Infraestructura',
                'descripcion': 'Infraestructura física y lógica'
            },
            {
                'id': 'datos',
                'nombre': 'Datos',
                'descripcion': 'Información y datos'
            },
            {
                'id': 'usuario',
                'nombre': 'Usuario',
                'descripcion': 'Usuarios del sistema'
            }
        ]
        
        return jsonify({
            'success': True,
            'asset_types': asset_types
        })
        
    except Exception as e:
        logger.error(f"Error al obtener tipos de activos: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/risk-level/calculate', methods=['POST'])
@jwt_required()
def calculate_risk_level():
    """Calcular nivel de riesgo basado en amenaza y vulnerabilidad"""
    try:
        data = request.get_json()
        threat_id = data.get('threat_id', '')
        vulnerability_id = data.get('vulnerability_id', '')
        asset_type = data.get('asset_type', '')
        
        if not threat_id or not vulnerability_id:
            return jsonify({'error': 'threat_id y vulnerability_id son requeridos'}), 400
        
        # Obtener datos de amenaza y vulnerabilidad
        knowledge_base = suggestion_service.knowledge_base
        threat_data = knowledge_base.get('amenazas', {}).get(threat_id, {})
        vuln_data = knowledge_base.get('vulnerabilidades', {}).get(vulnerability_id, {})
        
        if not threat_data or not vuln_data:
            return jsonify({'error': 'Amenaza o vulnerabilidad no encontrada'}), 404
        
        # Calcular nivel de riesgo (simplificado)
        risk_level = "MEDIUM"  # Por defecto
        
        # Lógica de cálculo de riesgo (se puede expandir)
        if threat_data.get('categoria') == 'Tecnológica' and vuln_data.get('categoria') == 'Tecnológica':
            risk_level = "HIGH"
        elif threat_data.get('categoria') == 'Humana' and vuln_data.get('categoria') == 'Humana':
            risk_level = "MEDIUM"
        else:
            risk_level = "LOW"
        
        return jsonify({
            'success': True,
            'risk_level': risk_level,
            'threat': threat_data,
            'vulnerability': vuln_data,
            'metadata': {
                'asset_type': asset_type,
                'calculation_method': 'simplified'
            }
        })
        
    except Exception as e:
        logger.error(f"Error al calcular nivel de riesgo: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

# Función para registrar el Blueprint
def register_predictive_routes(app):
    """Registrar rutas predictivas en la aplicación Flask"""
    app.register_blueprint(predictive_bp)
    logger.info("Rutas predictivas registradas exitosamente")
