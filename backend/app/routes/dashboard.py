from flask import Blueprint, request, jsonify
from ..models import db, Activo, Riesgo, Incidente, UsuarioSistema, RiesgoActivo
from sqlalchemy import func
from datetime import datetime, timedelta

dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/stats', methods=['GET'])
def get_stats():
    """Obtener estadísticas para el dashboard"""
    try:
        # Contadores básicos
        total_activos = Activo.query.count()
        total_usuarios = UsuarioSistema.query.count()
        total_riesgos = Riesgo.query.count()
        
        # Usuarios activos (asumiendo que tienen estado)
        usuarios_activos = UsuarioSistema.query.filter(
            UsuarioSistema.estado_usuario == 'Activo'
        ).count()
        
        # Activos por tipo
        activos_por_tipo = db.session.query(
            Activo.Tipo_Activo, 
            func.count(Activo.ID_Activo)
        ).group_by(Activo.Tipo_Activo).all()
        
        # Riesgos por estado
        riesgos_por_estado = db.session.query(
            Riesgo.Estado_Riesgo_General, 
            func.count(Riesgo.ID_Riesgo)
        ).group_by(Riesgo.Estado_Riesgo_General).all()
        
        return jsonify({
            'total_activos': total_activos,
            'usuarios_activos': usuarios_activos,
            'riesgos_identificados': total_riesgos,
            'tendencia': 5,  # Mock value
            'activos_por_tipo': dict(activos_por_tipo),
            'riesgos_por_estado': dict(riesgos_por_estado)
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/resumen', methods=['GET'])
def get_resumen_general():
    """Obtener resumen general del sistema"""
    try:
        # Contadores generales
        total_activos = Activo.query.count()
        total_riesgos = Riesgo.query.count()
        total_incidentes = Incidente.query.count()
        total_usuarios = UsuarioSistema.query.count()
        
        # Activos por estado
        activos_por_estado = db.session.query(
            Activo.estado_activo, 
            func.count(Activo.ID_Activo)
        ).group_by(Activo.estado_activo).all()
        
        # Activos por nivel de criticidad
        activos_por_criticidad = db.session.query(
            Activo.nivel_criticidad_negocio, 
            func.count(Activo.ID_Activo)
        ).group_by(Activo.nivel_criticidad_negocio).all()
        
        # Incidentes por estado
        incidentes_por_estado = db.session.query(
            Incidente.estado, 
            func.count(Incidente.id_incidente)
        ).group_by(Incidente.estado).all()
        
        # Incidentes por severidad
        incidentes_por_severidad = db.session.query(
            Incidente.severidad, 
            func.count(Incidente.id_incidente)
        ).group_by(Incidente.severidad).all()
        
        # Riesgos por estado
        riesgos_por_estado = db.session.query(
            Riesgo.Estado_Riesgo_General, 
            func.count(Riesgo.ID_Riesgo)
        ).group_by(Riesgo.Estado_Riesgo_General).all()
        
        return jsonify({
            'contadores_generales': {
                'total_activos': total_activos,
                'total_riesgos': total_riesgos,
                'total_incidentes': total_incidentes,
                'total_usuarios': total_usuarios
            },
            'activos_por_estado': dict(activos_por_estado),
            'activos_por_criticidad': dict(activos_por_criticidad),
            'incidentes_por_estado': dict(incidentes_por_estado),
            'incidentes_por_severidad': dict(incidentes_por_severidad),
            'riesgos_por_estado': dict(riesgos_por_estado)
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/actividad-reciente', methods=['GET'])
def get_actividad_reciente():
    """Obtener actividad reciente del sistema"""
    try:
        # Últimos activos creados
        ultimos_activos = Activo.query.order_by(
            Activo.fecha_creacion_registro.desc()
        ).limit(5).all()
        
        # Últimos incidentes
        ultimos_incidentes = Incidente.query.order_by(
            Incidente.fecha_incidente.desc()
        ).limit(5).all()
        
        # Últimos usuarios creados
        ultimos_usuarios = UsuarioSistema.query.order_by(
            UsuarioSistema.fecha_creacion_registro.desc()
        ).limit(5).all()
        
        return jsonify({
            'ultimos_activos': [activo.to_dict() for activo in ultimos_activos],
            'ultimos_incidentes': [incidente.to_dict() for incidente in ultimos_incidentes],
            'ultimos_usuarios': [{
                'id_usuario': u.id_usuario,
                'nombre_completo': u.nombre_completo,
                'email_institucional': u.email_institucional,
                'puesto_organizacion': u.puesto_organizacion,
                'fecha_creacion_registro': u.fecha_creacion_registro.isoformat() if u.fecha_creacion_registro else None
            } for u in ultimos_usuarios]
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/riesgos-altos', methods=['GET'])
def get_riesgos_altos():
    """Obtener activos con riesgos altos"""
    try:
        # Activos con riesgos altos
        riesgos_altos = db.session.query(
            Activo, Riesgo, RiesgoActivo
        ).join(
            RiesgoActivo, Activo.ID_Activo == RiesgoActivo.ID_Activo
        ).join(
            Riesgo, RiesgoActivo.id_riesgo == Riesgo.ID_Riesgo
        ).filter(
            RiesgoActivo.nivel_riesgo_calculado == 'Alto'
        ).all()
        
        resultado = []
        for activo, riesgo, riesgo_activo in riesgos_altos:
            resultado.append({
                'activo': activo.to_dict(),
                'riesgo': riesgo.to_dict(),
                'evaluacion': {
                    'probabilidad': riesgo_activo.probabilidad,
                    'impacto': riesgo_activo.impacto,
                    'nivel_riesgo_calculado': riesgo_activo.nivel_riesgo_calculado,
                    'medidas_mitigacion': riesgo_activo.medidas_mitigacion,
                    'fecha_evaluacion': riesgo_activo.fecha_evaluacion.isoformat() if riesgo_activo.fecha_evaluacion else None
                }
            })
        
        return jsonify(resultado), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/incidentes-pendientes', methods=['GET'])
def get_incidentes_pendientes():
    """Obtener incidentes pendientes de resolución"""
    try:
        incidentes_pendientes = Incidente.query.filter(
            Incidente.estado.in_(['Abierto', 'En Proceso'])
        ).order_by(Incidente.fecha_incidente.desc()).all()
        
        return jsonify([incidente.to_dict() for incidente in incidentes_pendientes]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/activos-criticos', methods=['GET'])
def get_activos_criticos():
    """Obtener activos críticos"""
    try:
        activos_criticos = Activo.query.filter(
            Activo.nivel_criticidad_negocio.in_(['Alto', 'Crítico'])
        ).all()
        
        return jsonify([activo.to_dict() for activo in activos_criticos]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/tendencias', methods=['GET'])
def get_tendencias():
    """Obtener tendencias del sistema"""
    try:
        # Obtener fechas para el análisis
        hoy = datetime.utcnow()
        hace_30_dias = hoy - timedelta(days=30)
        hace_60_dias = hoy - timedelta(days=60)
        hace_90_dias = hoy - timedelta(days=90)
        
        # Activos creados en diferentes períodos
        activos_ultimo_mes = Activo.query.filter(
            Activo.fecha_creacion_registro >= hace_30_dias
        ).count()
        
        activos_mes_anterior = Activo.query.filter(
            Activo.fecha_creacion_registro >= hace_60_dias,
            Activo.fecha_creacion_registro < hace_30_dias
        ).count()
        
        activos_mes_anterior_2 = Activo.query.filter(
            Activo.fecha_creacion_registro >= hace_90_dias,
            Activo.fecha_creacion_registro < hace_60_dias
        ).count()
        
        # Incidentes en diferentes períodos
        incidentes_ultimo_mes = Incidente.query.filter(
            Incidente.fecha_incidente >= hace_30_dias
        ).count()
        
        incidentes_mes_anterior = Incidente.query.filter(
            Incidente.fecha_incidente >= hace_60_dias,
            Incidente.fecha_incidente < hace_30_dias
        ).count()
        
        incidentes_mes_anterior_2 = Incidente.query.filter(
            Incidente.fecha_incidente >= hace_90_dias,
            Incidente.fecha_incidente < hace_60_dias
        ).count()
        
        # Usuarios creados en diferentes períodos
        usuarios_ultimo_mes = UsuarioSistema.query.filter(
            UsuarioSistema.fecha_creacion_registro >= hace_30_dias
        ).count()
        
        usuarios_mes_anterior = UsuarioSistema.query.filter(
            UsuarioSistema.fecha_creacion_registro >= hace_60_dias,
            UsuarioSistema.fecha_creacion_registro < hace_30_dias
        ).count()
        
        return jsonify({
            'activos': {
                'ultimo_mes': activos_ultimo_mes,
                'mes_anterior': activos_mes_anterior,
                'mes_anterior_2': activos_mes_anterior_2,
                'tendencia': 'creciente' if activos_ultimo_mes > activos_mes_anterior else 'decreciente'
            },
            'incidentes': {
                'ultimo_mes': incidentes_ultimo_mes,
                'mes_anterior': incidentes_mes_anterior,
                'mes_anterior_2': incidentes_mes_anterior_2,
                'tendencia': 'creciente' if incidentes_ultimo_mes > incidentes_mes_anterior else 'decreciente'
            },
            'usuarios': {
                'ultimo_mes': usuarios_ultimo_mes,
                'mes_anterior': usuarios_mes_anterior,
                'tendencia': 'creciente' if usuarios_ultimo_mes > usuarios_mes_anterior else 'decreciente'
            }
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/alertas', methods=['GET'])
def get_alertas():
    """Obtener alertas del sistema"""
    try:
        alertas = []
        
        # Alertas de incidentes sin resolver
        incidentes_sin_resolver = Incidente.query.filter(
            Incidente.estado.in_(['Abierto', 'En Proceso'])
        ).count()
        
        if incidentes_sin_resolver > 0:
            alertas.append({
                'tipo': 'incidentes_pendientes',
                'mensaje': f'Hay {incidentes_sin_resolver} incidentes pendientes de resolución',
                'severidad': 'alta' if incidentes_sin_resolver > 5 else 'media',
                'cantidad': incidentes_sin_resolver
            })
        
        # Alertas de riesgos altos
        riesgos_altos_count = db.session.query(RiesgoActivo).filter(
            RiesgoActivo.nivel_riesgo_calculado == 'Alto'
        ).count()
        
        if riesgos_altos_count > 0:
            alertas.append({
                'tipo': 'riesgos_altos',
                'mensaje': f'Hay {riesgos_altos_count} activos con riesgos altos',
                'severidad': 'alta',
                'cantidad': riesgos_altos_count
            })
        
        # Alertas de activos críticos sin backup
        activos_criticos_sin_backup = Activo.query.filter(
            Activo.nivel_criticidad_negocio.in_(['Alto', 'Crítico']),
            Activo.requiere_backup == True,
            Activo.frecuencia_backup_general.is_(None)
        ).count()
        
        if activos_criticos_sin_backup > 0:
            alertas.append({
                'tipo': 'activos_criticos_sin_backup',
                'mensaje': f'Hay {activos_criticos_sin_backup} activos críticos sin configuración de backup',
                'severidad': 'alta',
                'cantidad': activos_criticos_sin_backup
            })
        
        # Alertas de revisiones próximas
        proxima_semana = datetime.utcnow() + timedelta(days=7)
        revisiones_proximas = Activo.query.filter(
            Activo.fecha_proxima_revision_sgsi <= proxima_semana,
            Activo.fecha_proxima_revision_sgsi >= datetime.utcnow()
        ).count()
        
        if revisiones_proximas > 0:
            alertas.append({
                'tipo': 'revisiones_proximas',
                'mensaje': f'Hay {revisiones_proximas} activos con revisiones próximas',
                'severidad': 'media',
                'cantidad': revisiones_proximas
            })
        
        return jsonify(alertas), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500 