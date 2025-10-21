"""
Modelos de autenticación y autorización
"""

from .. import db
from datetime import datetime, timedelta
import bcrypt
import jwt
from flask import current_app

class Rol(db.Model):
    """Modelo para roles de autenticación"""
    __tablename__ = 'roles_auth'
    
    id_rol = db.Column(db.Integer, primary_key=True)
    nombre_rol = db.Column(db.String(50), unique=True, nullable=False)
    descripcion = db.Column(db.Text)
    permisos = db.Column(db.Text)  # JSON string con permisos
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    activo = db.Column(db.Boolean, default=True)
    
    # Relaciones
    usuarios = db.relationship('UsuarioAuth', backref='rol', lazy='dynamic')
    
    def to_dict(self):
        return {
            'id_rol': self.id_rol,
            'nombre_rol': self.nombre_rol,
            'descripcion': self.descripcion,
            'permisos': self.permisos,
            'fecha_creacion': self.fecha_creacion.isoformat() if self.fecha_creacion else None,
            'activo': self.activo
        }

class UsuarioAuth(db.Model):
    """Modelo para autenticación de usuarios"""
    __tablename__ = 'usuarios_auth'
    
    id_usuario_auth = db.Column(db.Integer, primary_key=True)
    id_usuario_sistema = db.Column(db.Integer, db.ForeignKey('usuarios_sistema.id_usuario'), nullable=False)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False)
    id_rol = db.Column(db.Integer, db.ForeignKey('roles_auth.id_rol'), nullable=False)
    activo = db.Column(db.Boolean, default=True)
    fecha_creacion = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_ultimo_login = db.Column(db.DateTime)
    intentos_fallidos = db.Column(db.Integer, default=0)
    bloqueado_hasta = db.Column(db.DateTime)
    
    # Relaciones
    sesiones = db.relationship('SesionUsuario', backref='usuario_auth', lazy='dynamic')
    
    def set_password(self, password):
        """Hash y guarda la contraseña"""
        salt = bcrypt.gensalt()
        self.password_hash = bcrypt.hashpw(password.encode('utf-8'), salt).decode('utf-8')
    
    def check_password(self, password):
        """Verifica la contraseña"""
        return bcrypt.checkpw(password.encode('utf-8'), self.password_hash.encode('utf-8'))
    
    def generate_token(self, expires_in=3600):
        """Genera un JWT token"""
        payload = {
            'user_id': self.id_usuario_auth,
            'username': self.username,
            'rol': self.rol.nombre_rol if self.rol else None,
            'exp': datetime.utcnow() + timedelta(seconds=expires_in),
            'iat': datetime.utcnow()
        }
        return jwt.encode(payload, current_app.config['SECRET_KEY'], algorithm='HS256')
    
    @staticmethod
    def verify_token(token):
        """Verifica un JWT token"""
        try:
            payload = jwt.decode(token, current_app.config['SECRET_KEY'], algorithms=['HS256'])
            return UsuarioAuth.query.get(payload['user_id'])
        except jwt.ExpiredSignatureError:
            return None
        except jwt.InvalidTokenError:
            return None
    
    def to_dict(self):
        return {
            'id_usuario_auth': self.id_usuario_auth,
            'id_usuario_sistema': self.id_usuario_sistema,
            'username': self.username,
            'id_rol': self.id_rol,
            'rol_nombre': self.rol.nombre_rol if self.rol else None,
            'activo': self.activo,
            'fecha_creacion': self.fecha_creacion.isoformat() if self.fecha_creacion else None,
            'fecha_ultimo_login': self.fecha_ultimo_login.isoformat() if self.fecha_ultimo_login else None
        }

class SesionUsuario(db.Model):
    """Modelo para sesiones de usuario"""
    __tablename__ = 'sesiones_usuario'
    
    id_sesion = db.Column(db.Integer, primary_key=True)
    id_usuario_auth = db.Column(db.Integer, db.ForeignKey('usuarios_auth.id_usuario_auth'), nullable=False)
    token = db.Column(db.Text, nullable=False)
    ip_address = db.Column(db.String(45))
    user_agent = db.Column(db.Text)
    fecha_inicio = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_expiracion = db.Column(db.DateTime, nullable=False)
    activa = db.Column(db.Boolean, default=True)
    
    def is_valid(self):
        """Verifica si la sesión es válida"""
        return self.activa and datetime.utcnow() < self.fecha_expiracion
    
    def to_dict(self):
        return {
            'id_sesion': self.id_sesion,
            'id_usuario_auth': self.id_usuario_auth,
            'ip_address': self.ip_address,
            'fecha_inicio': self.fecha_inicio.isoformat() if self.fecha_inicio else None,
            'fecha_expiracion': self.fecha_expiracion.isoformat() if self.fecha_expiracion else None,
            'activa': self.activa
        }
