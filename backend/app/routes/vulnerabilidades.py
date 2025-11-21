from flask import Blueprint, request, jsonify
from ..models import db
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import text

vulnerabilidades_bp = Blueprint('vulnerabilidades', __name__)

@vulnerabilidades_bp.route('/', methods=['GET'])
def get_vulnerabilidades():
    """Obtener vulnerabilidades con filtros y búsqueda inteligente"""
    try:
        # Parámetros de búsqueda
        search = request.args.get('search', '')
        categoria = request.args.get('categoria', '')
        severidad = request.args.get('severidad', '')
        limit = request.args.get('limit', 50, type=int)
        
        # Construir consulta base
        query = """
        SELECT id_vulnerabilidad, nombre, descripcion, categoria, severidad, 
               cve_referencia, descripcion_tecnica, impacto_potencial, controles_recomendados
        FROM vulnerabilidades 
        WHERE 1=1
        """
        
        params = {}
        
        # Filtro de búsqueda inteligente
        if search:
            query += """
            AND (
                nombre LIKE :search OR 
                descripcion LIKE :search OR 
                descripcion_tecnica LIKE :search OR
                impacto_potencial LIKE :search OR
                controles_recomendados LIKE :search
            )
            """
            params['search'] = f'%{search}%'
        
        # Filtro por categoría
        if categoria:
            query += " AND categoria = :categoria"
            params['categoria'] = categoria
        
        # Filtro por severidad
        if severidad:
            query += " AND severidad = :severidad"
            params['severidad'] = severidad
        
        query += " ORDER BY severidad DESC, nombre ASC LIMIT :limit"
        params['limit'] = limit
        
        result = db.session.execute(text(query), params)
        vulnerabilidades = []
        
        for row in result:
            vulnerabilidades.append({
                'id_vulnerabilidad': row.id_vulnerabilidad,
                'nombre': row.nombre,
                'descripcion': row.descripcion,
                'categoria': row.categoria,
                'severidad': row.severidad,
                'cve_referencia': row.cve_referencia,
                'descripcion_tecnica': row.descripcion_tecnica,
                'impacto_potencial': row.impacto_potencial,
                'controles_recomendados': row.controles_recomendados
            })
        
        return jsonify(vulnerabilidades), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@vulnerabilidades_bp.route('/categorias', methods=['GET'])
def get_categorias():
    """Obtener lista de categorías de vulnerabilidades"""
    try:
        query = "SELECT DISTINCT categoria FROM vulnerabilidades ORDER BY categoria"
        result = db.session.execute(text(query))
        categorias = [row.categoria for row in result if row.categoria]
        return jsonify(categorias), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@vulnerabilidades_bp.route('/severidades', methods=['GET'])
def get_severidades():
    """Obtener lista de severidades de vulnerabilidades"""
    try:
        query = "SELECT DISTINCT severidad FROM vulnerabilidades ORDER BY FIELD(severidad, 'Crítica', 'Alta', 'Media', 'Baja')"
        result = db.session.execute(text(query))
        severidades = [row.severidad for row in result if row.severidad]
        return jsonify(severidades), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@vulnerabilidades_bp.route('/sugerencias', methods=['GET'])
def get_sugerencias():
    """Obtener sugerencias predictivas basadas en texto de entrada"""
    try:
        texto = request.args.get('texto', '')
        if not texto or len(texto) < 2:
            return jsonify([]), 200
        
        # Búsqueda inteligente con ranking por relevancia
        query = """
        SELECT id_vulnerabilidad, nombre, descripcion, categoria, severidad,
               (
                   CASE WHEN nombre LIKE :exact_match THEN 4
                        WHEN nombre LIKE :start_match THEN 3
                        WHEN descripcion LIKE :start_match THEN 2
                        WHEN descripcion LIKE :contains_match THEN 1
                        ELSE 0
                   END
               ) as relevancia
        FROM vulnerabilidades 
        WHERE (
            nombre LIKE :contains_match OR 
            descripcion LIKE :contains_match OR
            descripcion_tecnica LIKE :contains_match
        )
        ORDER BY relevancia DESC, severidad DESC, nombre ASC
        LIMIT 10
        """
        
        params = {
            'exact_match': texto,
            'start_match': f'{texto}%',
            'contains_match': f'%{texto}%'
        }
        
        result = db.session.execute(text(query), params)
        sugerencias = []
        
        for row in result:
            sugerencias.append({
                'id_vulnerabilidad': row.id_vulnerabilidad,
                'nombre': row.nombre,
                'descripcion': row.descripcion,
                'categoria': row.categoria,
                'severidad': row.severidad,
                'relevancia': row.relevancia
            })
        
        return jsonify(sugerencias), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500



















