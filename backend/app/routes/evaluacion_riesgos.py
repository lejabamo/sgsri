from flask import Blueprint, request, jsonify
from ..models import db, Riesgo, Activo, evaluacion_riesgo_activo, controles_seguridad, nivelesriesgo, niveles_probabilidad, niveles_impacto
from ..modelos.documentos import DocumentoAdjunto
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import func, text
from datetime import datetime
import math

evaluacion_riesgos_bp = Blueprint('evaluacion_riesgos', __name__)

def _obtener_documentos_evaluacion(activo_id):
    """Obtener documentos asociados a una evaluación de activo"""
    try:
        # Buscar documentos por accion_id que contenga el activo_id
        documentos = DocumentoAdjunto.query.filter(
            DocumentoAdjunto.accion_id.like(f'%activo_{activo_id}%'),
            DocumentoAdjunto.activo == True
        ).all()
        
        return [doc.to_dict() for doc in documentos]
    except Exception as e:
        print(f"Error obteniendo documentos para activo {activo_id}: {e}")
        return []

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

@evaluacion_riesgos_bp.route('/guardar-plan-accion', methods=['POST'])
def guardar_plan_accion():
    """Guardar acciones del plan de acción con documentos asociados al responsable"""
    try:
        data = request.get_json()
        
        # Validar datos requeridos
        if 'id_evaluacion' not in data or 'acciones' not in data:
            return jsonify({'error': 'id_evaluacion y acciones son requeridos'}), 400
        
        id_evaluacion = data['id_evaluacion']
        acciones = data['acciones']
        id_activo = data.get('id_activo')
        
        # Verificar que la evaluación existe
        evaluacion = db.session.execute(
            text('SELECT ID_Activo FROM evaluacion_riesgo_activo WHERE id_evaluacion_riesgo_activo = :id'),
            {'id': id_evaluacion}
        ).fetchone()
        
        if not evaluacion:
            return jsonify({'error': 'Evaluación no encontrada'}), 404
        
        if not id_activo:
            id_activo = evaluacion[0]
        
        # Obtener ID del usuario responsable desde el nombre o email
        def obtener_id_usuario_responsable(responsable: str):
            """Obtener ID de usuario sistema desde nombre o email"""
            if not responsable:
                return None
            
            # Buscar por nombre completo
            usuario = db.session.execute(
                text('SELECT id_usuario FROM usuarios_sistema WHERE nombre_completo = :nombre LIMIT 1'),
                {'nombre': responsable}
            ).fetchone()
            
            if usuario:
                return usuario[0]
            
            # Buscar por email
            usuario = db.session.execute(
                text('SELECT id_usuario FROM usuarios_sistema WHERE email_institucional = :email LIMIT 1'),
                {'email': responsable}
            ).fetchone()
            
            if usuario:
                return usuario[0]
            
            # Si no se encuentra, buscar en usuarios_auth
            usuario_auth = db.session.execute(
                text('SELECT id_usuario_auth FROM usuarios_auth WHERE email = :email LIMIT 1'),
                {'email': responsable}
            ).fetchone()
            
            if usuario_auth:
                # Obtener id_usuario_sistema asociado
                usuario_sistema = db.session.execute(
                    text('SELECT id_usuario_sistema FROM usuarios_auth WHERE id_usuario_auth = :id LIMIT 1'),
                    {'id': usuario_auth[0]}
                ).fetchone()
                
                if usuario_sistema and usuario_sistema[0]:
                    return usuario_sistema[0]
            
            return None
        
        # Procesar cada acción
        acciones_guardadas = []
        for accion in acciones:
            responsable = accion.get('responsable', '')
            id_usuario_responsable = obtener_id_usuario_responsable(responsable)
            
            # Crear accion_id único para esta acción
            accion_id = f"eval_{id_evaluacion}_activo_{id_activo}_{accion.get('id', datetime.now().timestamp())}"
            
            # Guardar documentos si existen
            documentos_ids = []
            if accion.get('documentos') and len(accion['documentos']) > 0:
                for doc in accion['documentos']:
                    # Si el documento ya tiene ID (ya fue subido), solo actualizar accion_id y responsable
                    if doc.get('id'):
                        try:
                            # Actualizar documento existente
                            db.session.execute(
                                text("""
                                    UPDATE documentos_adjuntos 
                                    SET accion_id = :accion_id,
                                        subido_por = COALESCE((SELECT id_usuario_auth FROM usuarios_auth WHERE id_usuario_sistema = :usuario_id LIMIT 1), subido_por)
                                    WHERE id = :doc_id
                                """),
                                {
                                    'accion_id': accion_id,
                                    'usuario_id': id_usuario_responsable,
                                    'doc_id': doc['id']
                                }
                            )
                            documentos_ids.append(doc['id'])
                        except Exception as e:
                            print(f"Error actualizando documento {doc['id']}: {e}")
            
            acciones_guardadas.append({
                'id': accion.get('id'),
                'accion_id': accion_id,
                'documentos_count': len(documentos_ids)
            })
        
        db.session.commit()
        
        return jsonify({
            'message': 'Plan de acción guardado exitosamente',
            'acciones_guardadas': acciones_guardadas
        }), 201
        
    except Exception as e:
        db.session.rollback()
        import traceback
        error_trace = traceback.format_exc()
        print(f"Error en guardar_plan_accion: {str(e)}")
        print(f"Traceback: {error_trace}")
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

@evaluacion_riesgos_bp.route('/evaluaciones-completadas', methods=['GET'])
def get_evaluaciones_completadas():
    """Obtener evaluaciones completadas por activo"""
    try:
        from app.models import Activo, Riesgo
        
        # Obtener todas las evaluaciones con datos completos incluyendo niveles
        # Usar outerjoin para evitar errores si faltan relaciones
        evaluaciones = db.session.query(
            evaluacion_riesgo_activo,
            Activo,
            Riesgo,
            niveles_probabilidad,
            niveles_impacto,
            nivelesriesgo
        ).outerjoin(
            Activo, evaluacion_riesgo_activo.ID_Activo == Activo.ID_Activo
        ).outerjoin(
            Riesgo, evaluacion_riesgo_activo.ID_Riesgo == Riesgo.ID_Riesgo
        ).outerjoin(
            niveles_probabilidad, evaluacion_riesgo_activo.id_nivel_probabilidad_inherente == niveles_probabilidad.ID_NivelProbabilidad
        ).outerjoin(
            niveles_impacto, evaluacion_riesgo_activo.id_nivel_impacto_inherente == niveles_impacto.ID_NivelImpacto
        ).outerjoin(
            nivelesriesgo, evaluacion_riesgo_activo.id_nivel_riesgo_inherente_calculado == nivelesriesgo.ID_NivelRiesgo
        ).filter(
            evaluacion_riesgo_activo.id_nivel_probabilidad_inherente.isnot(None),
            evaluacion_riesgo_activo.id_nivel_impacto_inherente.isnot(None)
        ).all()
        
        # Agrupar por activo
        activos_evaluados = {}
        for eval, activo, riesgo, prob_inherente, impacto_inherente, nivel_riesgo_inherente in evaluaciones:
            # Validar que existan los datos necesarios
            if not activo or not riesgo or not eval:
                continue
                
            activo_id = activo.ID_Activo
            if activo_id not in activos_evaluados:
                activos_evaluados[activo_id] = {
                    'activo': {
                        'id': activo.ID_Activo,
                        'ID_Activo': activo.ID_Activo,
                        'Nombre': activo.Nombre,
                        'Tipo_Activo': activo.Tipo_Activo,
                        'estado': activo.estado_activo,
                        'nivel_criticidad_negocio': activo.nivel_criticidad_negocio
                    },
                    'evaluaciones': [],
                    'fechaCompletada': eval.fecha_evaluacion_residual or eval.fecha_evaluacion_inherente,
                    'completada': True
                }
            
            # Obtener controles aplicados para esta evaluación
            controles_aplicados = db.session.execute(
                text("""
                    SELECT 
                        c.ID_Control,
                        c.Nombre,
                        c.Descripcion,
                        c.Tipo_Control,
                        c.categoria_control_iso,
                        c.codigo_control_iso,
                        rca.justificacion_aplicacion_control,
                        rca.efectividad_real_observada
                    FROM riesgocontrolaplicado rca
                    JOIN controles c ON rca.ID_Control = c.ID_Control
                    WHERE rca.id_evaluacion_riesgo_activo = :eval_id
                """),
                {'eval_id': eval.id_evaluacion_riesgo_activo}
            ).fetchall()
            
            # Convertir controles a formato esperado
            controles_list = []
            for ctrl in controles_aplicados:
                controles_list.append({
                    'id': ctrl.ID_Control,
                    'nombre': ctrl.Nombre,
                    'descripcion': ctrl.Descripcion,
                    'tipo': ctrl.Tipo_Control,
                    'categoria': ctrl.categoria_control_iso,
                    'codigo_iso': ctrl.codigo_control_iso,
                    'justificacion': ctrl.justificacion_aplicacion_control,
                    'eficacia': ctrl.efectividad_real_observada or 'Media'
                })
            
            # Agregar evaluación con estructura compatible con el frontend
            activos_evaluados[activo_id]['evaluaciones'].append({
                'evaluacion': {
                    'selectedActivo': {
                        'id': activo.ID_Activo,
                        'ID_Activo': activo.ID_Activo,
                        'Nombre': activo.Nombre,
                        'Tipo_Activo': activo.Tipo_Activo,
                        'estado': activo.estado_activo,
                        'nivel_criticidad_negocio': activo.nivel_criticidad_negocio
                    },
                    'newRiesgo': {
                        'amenaza': riesgo.Nombre,  # Usar el nombre del riesgo como amenaza
                        'vulnerabilidad': 'Vulnerabilidad identificada',  # Placeholder
                        'descripcion': riesgo.Descripcion
                    },
                    'evaluacionInherente': {
                        'probabilidad': prob_inherente.Nombre if prob_inherente else f'Nivel {eval.id_nivel_probabilidad_inherente}',
                        'impacto': impacto_inherente.Nombre if impacto_inherente else f'Nivel {eval.id_nivel_impacto_inherente}',
                        'nivelRiesgo': nivel_riesgo_inherente.Nombre if nivel_riesgo_inherente else f'Nivel {eval.id_nivel_riesgo_inherente_calculado}',
                        'justificacion': eval.justificacion_evaluacion_inherente or 'Evaluación inherente completada'
                    },
                    'controles': {
                        'seleccionados': controles_list,
                        'eficacia': controles_list[0]['eficacia'] if controles_list else 'Media',
                        'justificacion': controles_list[0]['justificacion'] if controles_list else 'Controles aplicados según evaluación'
                    },
                    'evaluacionResidual': {
                        'probabilidad': f'Nivel {eval.id_nivel_probabilidad_residual}',
                        'impacto': f'Nivel {eval.id_nivel_impacto_residual}',
                        'nivelRiesgo': f'Nivel {eval.id_nivel_riesgo_residual_calculado}',
                        'justificacion': eval.justificacion_evaluacion_residual or 'Evaluación residual completada'
                    },
                    'tratamiento': {
                        'opcion': 'Mitigar',
                        'responsable': 'Equipo de Seguridad',
                        'fechaInicio': str(eval.fecha_evaluacion_inherente),
                        'fechaFin': str(eval.fecha_evaluacion_residual),
                        'presupuesto': 'Por definir'
                    },
                    'planAccion': {
                        'acciones': [
                            {
                                'id': '1',
                                'descripcion': 'Implementar controles de seguridad',
                                'responsable': 'Equipo de Seguridad',
                                'fechaInicio': str(eval.fecha_evaluacion_inherente),
                                'fechaFin': str(eval.fecha_evaluacion_residual),
                                'estado': 'Completado',
                                'comentarios': 'Evaluación completada',
                                'documentos': _obtener_documentos_evaluacion(activo_id)
                            }
                        ]
                    }
                },
                'fechaCompletada': str(eval.fecha_evaluacion_residual or eval.fecha_evaluacion_inherente),
                'completada': True
            })
        
        return jsonify(activos_evaluados), 200
        
    except Exception as e:
        import traceback
        error_trace = traceback.format_exc()
        print(f"Error en get_evaluaciones_completadas: {str(e)}")
        print(f"Traceback: {error_trace}")
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/evaluacion-parcial', methods=['POST'])
def guardar_evaluacion_parcial():
    """Guardar una evaluación parcial para poder continuarla después"""
    try:
        data = request.get_json()
        
        # Validar datos requeridos
        if 'activo_id' not in data or 'wizard_data' not in data:
            return jsonify({'error': 'Datos requeridos: activo_id y wizard_data'}), 400
        
        # Crear o actualizar evaluación parcial
        # Por ahora guardamos en una tabla temporal o en el localStorage del frontend
        # En una implementación real, crearías una tabla 'evaluaciones_parciales'
        
        return jsonify({
            'message': 'Evaluación parcial guardada exitosamente',
            'activo_id': data['activo_id'],
            'progreso': data.get('progreso', 0)
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/evaluacion-parcial/<int:activo_id>', methods=['GET'])
def obtener_evaluacion_parcial(activo_id):
    """Obtener evaluación parcial guardada para continuar"""
    try:
        # En una implementación real, buscarías en la base de datos
        # Por ahora devolvemos datos vacíos
        return jsonify({
            'activo_id': activo_id,
            'wizard_data': {},
            'progreso': 0,
            'existe': False
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@evaluacion_riesgos_bp.route('/estadisticas', methods=['GET'])
def get_estadisticas_evaluacion():
    """Obtener estadísticas de evaluación de riesgos"""
    try:
        # Total de riesgos
        total_riesgos = Riesgo.query.count()
        
        # Riesgos evaluados (distintos)
        riesgos_evaluados = db.session.query(evaluacion_riesgo_activo.ID_Riesgo).distinct().count()
        
        # Riesgos pendientes
        riesgos_pendientes = max(0, total_riesgos - riesgos_evaluados)
        
        # Distribución por nivel de riesgo (usar residual si existe, si no inherente)
        # Usar outerjoin y text para evitar errores con relaciones faltantes
        try:
            distribucion = db.session.execute(
                text("""
                    SELECT 
                        nr.Nombre as nivel,
                        COUNT(DISTINCT era.id_evaluacion_riesgo_activo) as count
                    FROM evaluacion_riesgo_activo era
                    LEFT JOIN nivelesriesgo nr ON nr.ID_NivelRiesgo = COALESCE(
                        era.id_nivel_riesgo_residual_calculado,
                        era.id_nivel_riesgo_inherente_calculado
                    )
                    WHERE nr.ID_NivelRiesgo IS NOT NULL
                    GROUP BY nr.Nombre
                """)
            ).fetchall()
            
            distribucion_dict = {row.nivel: int(row.count) for row in distribucion if row.nivel}
        except Exception as e:
            print(f"Error obteniendo distribución de niveles: {str(e)}")
            distribucion_dict = {}
        
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
        import traceback
        error_trace = traceback.format_exc()
        print(f"Error en get_estadisticas_evaluacion: {str(e)}")
        print(f"Traceback: {error_trace}")
        return jsonify({'error': str(e), 'traceback': error_trace}), 500

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
