from flask import Blueprint, request, jsonify
from ..models import db, UsuarioSistema, Activo
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime

usuarios_bp = Blueprint('usuarios', __name__)

@usuarios_bp.route('/', methods=['GET'])
def get_usuarios():
    """Obtener todos los usuarios con filtros opcionales"""
    try:
        # Parámetros de filtrado
        departamento = request.args.get('departamento')
        rol = request.args.get('rol')
        
        query = UsuarioSistema.query
        
        if departamento:
            query = query.filter(UsuarioSistema.departamento == departamento)
        if rol:
            query = query.filter(UsuarioSistema.rol == rol)
        
        usuarios = query.all()
        return jsonify([{
            'id_usuario': u.id_usuario,
            'nombre': u.nombre,
            'email': u.email,
            'departamento': u.departamento,
            'rol': u.rol,
            'fecha_creacion': u.fecha_creacion.isoformat() if u.fecha_creacion else None
        } for u in usuarios]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@usuarios_bp.route('/<int:usuario_id>', methods=['GET'])
def get_usuario(usuario_id):
    """Obtener un usuario específico por ID"""
    try:
        usuario = UsuarioSistema.query.get_or_404(usuario_id)
        return jsonify({
            'id_usuario': usuario.id_usuario,
            'nombre': usuario.nombre,
            'email': usuario.email,
            'departamento': usuario.departamento,
            'rol': usuario.rol,
            'fecha_creacion': usuario.fecha_creacion.isoformat() if usuario.fecha_creacion else None
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@usuarios_bp.route('/', methods=['POST'])
def create_usuario():
    """Crear un nuevo usuario"""
    try:
        data = request.json
        if not data:
            return jsonify({'error': 'No se proporcionaron datos'}), 400
        
        # Validaciones básicas
        if not data.get('nombre'):
            return jsonify({'error': 'El nombre del usuario es obligatorio'}), 400
        if not data.get('email'):
            return jsonify({'error': 'El email del usuario es obligatorio'}), 400
        
        # Verificar si el email ya existe
        usuario_existente = UsuarioSistema.query.filter_by(email=data['email']).first()
        if usuario_existente:
            return jsonify({'error': 'Ya existe un usuario con ese email'}), 400
        
        usuario = UsuarioSistema(
            nombre=data.get('nombre'),
            email=data.get('email'),
            departamento=data.get('departamento'),
            rol=data.get('rol')
        )
        
        db.session.add(usuario)
        db.session.commit()
        
        return jsonify({
            'id_usuario': usuario.id_usuario,
            'nombre': usuario.nombre,
            'email': usuario.email,
            'departamento': usuario.departamento,
            'rol': usuario.rol,
            'fecha_creacion': usuario.fecha_creacion.isoformat() if usuario.fecha_creacion else None
        }), 201
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@usuarios_bp.route('/<int:usuario_id>', methods=['PUT'])
def update_usuario(usuario_id):
    """Actualizar un usuario existente"""
    try:
        usuario = UsuarioSistema.query.get_or_404(usuario_id)
        data = request.json
        
        if not data:
            return jsonify({'error': 'No se proporcionaron datos'}), 400
        
        # Actualizar campos
        if 'nombre' in data:
            usuario.nombre = data['nombre']
        if 'email' in data:
            # Verificar si el nuevo email ya existe en otro usuario
            usuario_existente = UsuarioSistema.query.filter_by(email=data['email']).first()
            if usuario_existente and usuario_existente.id_usuario != usuario_id:
                return jsonify({'error': 'Ya existe un usuario con ese email'}), 400
            usuario.email = data['email']
        if 'departamento' in data:
            usuario.departamento = data['departamento']
        if 'rol' in data:
            usuario.rol = data['rol']
        
        db.session.commit()
        return jsonify({
            'id_usuario': usuario.id_usuario,
            'nombre': usuario.nombre,
            'email': usuario.email,
            'departamento': usuario.departamento,
            'rol': usuario.rol,
            'fecha_creacion': usuario.fecha_creacion.isoformat() if usuario.fecha_creacion else None
        }), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@usuarios_bp.route('/<int:usuario_id>', methods=['DELETE'])
def delete_usuario(usuario_id):
    """Eliminar un usuario"""
    try:
        usuario = UsuarioSistema.query.get_or_404(usuario_id)
        
        # Verificar si el usuario tiene activos asociados
        activos_propietario = Activo.query.filter_by(ID_Propietario=usuario_id).count()
        activos_custodio = Activo.query.filter_by(ID_Custodio=usuario_id).count()
        
        if activos_propietario > 0 or activos_custodio > 0:
            return jsonify({
                'error': 'No se puede eliminar el usuario porque tiene activos asociados',
                'activos_como_propietario': activos_propietario,
                'activos_como_custodio': activos_custodio
            }), 400
        
        db.session.delete(usuario)
        db.session.commit()
        return jsonify({'message': 'Usuario eliminado correctamente'}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({'error': f'Error de base de datos: {str(e)}'}), 500
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@usuarios_bp.route('/departamentos', methods=['GET'])
def get_departamentos():
    """Obtener todos los departamentos únicos"""
    try:
        departamentos = db.session.query(UsuarioSistema.departamento).distinct().all()
        return jsonify([dept[0] for dept in departamentos if dept[0]]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@usuarios_bp.route('/roles', methods=['GET'])
def get_roles():
    """Obtener todos los roles únicos"""
    try:
        roles = db.session.query(UsuarioSistema.rol).distinct().all()
        return jsonify([rol[0] for rol in roles if rol[0]]), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@usuarios_bp.route('/<int:usuario_id>/activos', methods=['GET'])
def get_activos_usuario(usuario_id):
    """Obtener los activos asociados a un usuario (como propietario o custodio)"""
    try:
        usuario = UsuarioSistema.query.get_or_404(usuario_id)
        
        # Obtener activos como propietario
        activos_propietario = Activo.query.filter_by(ID_Propietario=usuario_id).all()
        
        # Obtener activos como custodio
        activos_custodio = Activo.query.filter_by(ID_Custodio=usuario_id).all()
        
        return jsonify({
            'usuario': {
                'id_usuario': usuario.id_usuario,
                'nombre': usuario.nombre,
                'email': usuario.email,
                'departamento': usuario.departamento,
                'rol': usuario.rol
            },
            'activos_como_propietario': [activo.to_dict() for activo in activos_propietario],
            'activos_como_custodio': [activo.to_dict() for activo in activos_custodio],
            'total_activos_propietario': len(activos_propietario),
            'total_activos_custodio': len(activos_custodio)
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@usuarios_bp.route('/estadisticas', methods=['GET'])
def get_estadisticas_usuarios():
    """Obtener estadísticas de usuarios"""
    try:
        # Total de usuarios
        total_usuarios = UsuarioSistema.query.count()
        
        # Usuarios por departamento
        usuarios_por_departamento = db.session.query(
            UsuarioSistema.departamento, 
            db.func.count(UsuarioSistema.id_usuario)
        ).group_by(UsuarioSistema.departamento).all()
        
        # Usuarios por rol
        usuarios_por_rol = db.session.query(
            UsuarioSistema.rol, 
            db.func.count(UsuarioSistema.id_usuario)
        ).group_by(UsuarioSistema.rol).all()
        
        # Usuarios creados en el último mes
        from datetime import timedelta
        un_mes_atras = datetime.utcnow() - timedelta(days=30)
        usuarios_ultimo_mes = UsuarioSistema.query.filter(
            UsuarioSistema.fecha_creacion >= un_mes_atras
        ).count()
        
        return jsonify({
            'total_usuarios': total_usuarios,
            'usuarios_por_departamento': dict(usuarios_por_departamento),
            'usuarios_por_rol': dict(usuarios_por_rol),
            'usuarios_ultimo_mes': usuarios_ultimo_mes
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500 