"""
Decoradores para autenticación y autorización
"""

from functools import wraps
from flask import request, jsonify, current_app
from .models import UsuarioAuth, Rol
import jwt

def require_auth(f):
    """Decorador que requiere autenticación"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = None
        
        # Verificar si el token está en el header Authorization
        if 'Authorization' in request.headers:
            auth_header = request.headers['Authorization']
            try:
                token = auth_header.split(" ")[1]  # Bearer <token>
            except IndexError:
                return jsonify({'error': 'Token malformado'}), 401
        
        if not token:
            return jsonify({'error': 'Token de acceso requerido'}), 401
        
        try:
            # Decodificar el token
            payload = jwt.decode(token, current_app.config['SECRET_KEY'], algorithms=['HS256'])
            current_user = UsuarioAuth.query.get(payload['user_id'])
            
            if not current_user or not current_user.activo:
                return jsonify({'error': 'Usuario no válido o inactivo'}), 401
            
            # Agregar el usuario actual al contexto
            request.current_user = current_user
            
        except jwt.ExpiredSignatureError:
            return jsonify({'error': 'Token expirado'}), 401
        except jwt.InvalidTokenError:
            return jsonify({'error': 'Token inválido'}), 401
        
        return f(*args, **kwargs)
    
    return decorated_function

def require_role(required_role):
    """Decorador que requiere un rol específico"""
    def decorator(f):
        @wraps(f)
        @require_auth
        def decorated_function(*args, **kwargs):
            if not hasattr(request, 'current_user'):
                return jsonify({'error': 'Usuario no autenticado'}), 401
            
            user_role = request.current_user.rol.nombre_rol if request.current_user.rol else None
            
            if user_role != required_role:
                return jsonify({'error': f'Se requiere rol: {required_role}'}), 403
            
            return f(*args, **kwargs)
        return decorated_function
    return decorator

def require_any_role(required_roles):
    """Decorador que requiere cualquiera de los roles especificados"""
    def decorator(f):
        @wraps(f)
        @require_auth
        def decorated_function(*args, **kwargs):
            if not hasattr(request, 'current_user'):
                return jsonify({'error': 'Usuario no autenticado'}), 401
            
            user_role = request.current_user.rol.nombre_rol if request.current_user.rol else None
            
            if user_role not in required_roles:
                return jsonify({'error': f'Se requiere uno de los roles: {", ".join(required_roles)}'}), 403
            
            return f(*args, **kwargs)
        return decorated_function
    return decorator

def admin_required(f):
    """Decorador que requiere rol de administrador"""
    return require_role('ADMIN')(f)

def operator_required(f):
    """Decorador que requiere rol de operador o superior"""
    return require_any_role(['ADMIN', 'OPERADOR'])(f)

def consultant_required(f):
    """Decorador que requiere rol de consultor o superior"""
    return require_any_role(['ADMIN', 'OPERADOR', 'CONSULTOR'])(f)
