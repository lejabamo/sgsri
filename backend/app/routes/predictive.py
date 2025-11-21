"""
Rutas de la API para el sistema predictivo basado en normas ISO
"""

from flask import Blueprint, request, jsonify
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
def suggest_controls():
    """Sugerir controles basados en amenaza y vulnerabilidad usando datos reales de la BD"""
    try:
        from ..models import controles_seguridad
        from sqlalchemy import or_, and_
        
        data = request.get_json()
        threat_id = data.get('threat_id', '')
        threat_name = data.get('threat_name', '')  # Nombre de la amenaza
        vulnerability_id = data.get('vulnerability_id', '')
        vulnerability_name = data.get('vulnerability_name', '')  # Nombre de la vulnerabilidad
        asset_type = data.get('asset_type', '')
        
        suggestions = []
        
        # Primero intentar obtener controles de la base de datos real
        try:
            # Buscar controles relevantes basados en palabras clave de amenaza y vulnerabilidad
            keywords = []
            if threat_name:
                # Extraer palabras clave de la amenaza
                threat_words = threat_name.lower().split()
                keywords.extend([w for w in threat_words if len(w) > 3])
            if vulnerability_name:
                # Extraer palabras clave de la vulnerabilidad
                vuln_words = vulnerability_name.lower().split()
                keywords.extend([w for w in vuln_words if len(w) > 3])
            
            # Buscar controles que coincidan con las palabras clave
            if keywords:
                filters = []
                for keyword in keywords[:5]:  # Limitar a 5 palabras clave
                    filters.append(
                        or_(
                            controles_seguridad.Nombre.ilike(f'%{keyword}%'),
                            controles_seguridad.Descripcion.ilike(f'%{keyword}%'),
                            controles_seguridad.Categoria.ilike(f'%{keyword}%')
                        )
                    )
                
                # Buscar controles que coincidan con al menos una palabra clave
                db_controls = controles_seguridad.query.filter(
                    or_(*filters)
                ).limit(10).all()
                
                for control in db_controls:
                    # Calcular relevancia basada en coincidencias
                    relevancia = 0
                    descripcion_lower = (control.Descripcion or '').lower()
                    nombre_lower = (control.Nombre or '').lower()
                    
                    for keyword in keywords:
                        if keyword in nombre_lower:
                            relevancia += 2
                        if keyword in descripcion_lower:
                            relevancia += 1
                    
                    # Convertir eficacia a número para el cálculo
                    eficacia_valor = 60  # Default
                    if control.Eficacia_Esperada:
                        eficacia_map = {
                            'Muy Alta': 90,
                            'Alta': 75,
                            'Media': 60,
                            'Baja': 40
                        }
                        eficacia_valor = eficacia_map.get(control.Eficacia_Esperada, 60)
                    
                    suggestion = {
                        'id': str(control.ID_Control),
                        'titulo': control.Nombre,
                        'descripcion': control.Descripcion or f"Control de seguridad {control.Categoria or 'general'}",
                        'categoria': control.Categoria or 'General',
                        'confianza': min(0.95, 0.6 + (relevancia * 0.05) + (eficacia_valor / 100 * 0.2)),
                        'implementacion': f"Implementar {control.Nombre} según las mejores prácticas de {control.Categoria or 'seguridad'}",
                        'prioridad': 3 if eficacia_valor >= 75 else (2 if eficacia_valor >= 60 else 1),
                        'eficacia': eficacia_valor
                    }
                    suggestions.append(suggestion)
        except Exception as db_error:
            logger.warning(f"Error obteniendo controles de BD, usando servicio predictivo: {db_error}")
        
        # Si no se encontraron controles en BD o hay pocos, complementar con servicio predictivo
        if len(suggestions) < 5 and threat_id and vulnerability_id:
            try:
                predictive_suggestions = suggestion_service.suggest_controls_for_risk(
                    threat_id, vulnerability_id, asset_type
                )
                # Agregar solo si no están duplicados
                for pred_suggestion in predictive_suggestions:
                    if not any(s['titulo'] == pred_suggestion.get('titulo', '') for s in suggestions):
                        # Convertir formato del servicio predictivo al formato esperado
                        suggestion = {
                            'id': pred_suggestion.get('id', ''),
                            'titulo': pred_suggestion.get('titulo', ''),
                            'descripcion': pred_suggestion.get('descripcion', ''),
                            'categoria': pred_suggestion.get('categoria', ''),
                            'confianza': pred_suggestion.get('confianza', 0.7),
                            'implementacion': pred_suggestion.get('implementacion', ''),
                            'prioridad': pred_suggestion.get('prioridad', 2),
                            'eficacia': int(pred_suggestion.get('confianza', 0.7) * 100)
                        }
                        suggestions.append(suggestion)
            except Exception as pred_error:
                logger.warning(f"Error obteniendo sugerencias predictivas: {pred_error}")
        
        # Ordenar por confianza y prioridad
        suggestions.sort(key=lambda x: (x.get('confianza', 0), x.get('prioridad', 0)), reverse=True)
        
        # Limitar a top 10
        suggestions = suggestions[:10]
        
        return jsonify({
            'success': True,
            'suggestions': suggestions,
            'metadata': {
                'threat_id': threat_id,
                'vulnerability_id': vulnerability_id,
                'asset_type': asset_type,
                'total_suggestions': len(suggestions),
                'source': 'database' if len(suggestions) > 0 else 'predictive'
            }
        })
        
    except Exception as e:
        logger.error(f"Error al sugerir controles: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/suggestions/justifications', methods=['POST'])
def suggest_justifications():
    """Sugerir justificaciones basadas en controles seleccionados"""
    try:
        from ..models import controles_seguridad
        from sqlalchemy import or_
        
        data = request.get_json()
        controls = data.get('controls', [])  # Lista de nombres o IDs de controles
        risk_type = data.get('risk_type', '')
        
        if not controls or len(controls) == 0:
            return jsonify({
                'success': True,
                'suggestions': []
            }), 200
        
        # Buscar controles en la base de datos
        suggestions = []
        for control_name in controls:
            # Buscar control por nombre (puede ser parcial)
            control = controles_seguridad.query.filter(
                or_(
                    controles_seguridad.Nombre.ilike(f'%{control_name}%'),
                    controles_seguridad.Descripcion.ilike(f'%{control_name}%')
                )
            ).first()
            
            if control:
                # Generar justificación basada en el control real
                justification_text = f"El control '{control.Nombre}' "
                
                if control.Descripcion:
                    # Usar la descripción del control para generar justificación
                    descripcion = control.Descripcion
                    if len(descripcion) > 200:
                        descripcion = descripcion[:200] + "..."
                    justification_text += descripcion
                else:
                    justification_text += f"mitiga el riesgo mediante {control.Categoria or 'medidas de seguridad'}."
                
                # Agregar información de eficacia si está disponible
                if control.Eficacia_Esperada:
                    eficacia_map = {
                        'Muy Alta': 'reduciendo significativamente',
                        'Alta': 'reduciendo considerablemente',
                        'Media': 'reduciendo',
                        'Baja': 'mitigando parcialmente'
                    }
                    eficacia_text = eficacia_map.get(control.Eficacia_Esperada, 'reduciendo')
                    justification_text += f" Este control tiene una eficacia {control.Eficacia_Esperada.lower()}, {eficacia_text} la probabilidad o impacto del riesgo."
                
                # Buscar norma ISO relacionada si existe
                norma_iso = "ISO 27002"
                articulo_iso = ""
                
                # Mapeo básico de categorías a artículos ISO 27002
                categoria_articulo_map = {
                    'Tecnológica': 'A.10',
                    'Física': 'A.11',
                    'Organizativa': 'A.6',
                    'Legal': 'A.18',
                    'Humana': 'A.7'
                }
                
                if control.Categoria and control.Categoria in categoria_articulo_map:
                    articulo_iso = categoria_articulo_map[control.Categoria]
                
                suggestion = {
                    'id': str(control.ID_Control),
                    'titulo': control.Nombre,
                    'descripcion': justification_text,
                    'norma': norma_iso,
                    'articulo': articulo_iso or 'A.5',
                    'confianza': 0.85 if control.Eficacia_Esperada in ['Muy Alta', 'Alta'] else 0.7
                }
                suggestions.append(suggestion)
        
        # Si no se encontraron controles en BD, retornar lista vacía (no mock)
        return jsonify({
            'success': True,
            'suggestions': suggestions
        }), 200
        
    except Exception as e:
        logger.error(f"Error al sugerir justificaciones: {e}")
        return jsonify({'error': 'Error interno del servidor'}), 500

@predictive_bp.route('/suggestions/complete', methods=['POST'])
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
