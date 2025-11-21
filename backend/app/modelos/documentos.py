from app import db
from datetime import datetime
from sqlalchemy.dialects.mysql import LONGTEXT

class DocumentoAdjunto(db.Model):
    __tablename__ = 'documentos_adjuntos'
    
    id = db.Column(db.Integer, primary_key=True)
    accion_id = db.Column(db.String(50), nullable=False, index=True)
    nombre_original = db.Column(db.String(255), nullable=False)
    nombre_archivo = db.Column(db.String(255), nullable=False, unique=True)
    tipo_mime = db.Column(db.String(100), nullable=False)
    tamaño_bytes = db.Column(db.BigInteger, nullable=False)
    ruta_archivo = db.Column(db.String(500), nullable=False)
    descripcion = db.Column(db.Text, nullable=True)
    fecha_subida = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    fecha_modificacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    subido_por = db.Column(db.Integer, db.ForeignKey('usuarios_auth.id_usuario_auth'), nullable=True)
    activo = db.Column(db.Boolean, default=True, nullable=False)
    
    # Relación con usuario
    usuario = db.relationship('UsuarioAuth', backref='documentos_subidos')
    
    def to_dict(self):
        from flask import request
        try:
            # Intentar generar URL absoluta
            if request:
                base_url = request.host_url.rstrip('/')
                url = f'{base_url}/api/documentos/descargar/{self.id}'
            else:
                # Si no hay request context, usar URL relativa
                # El frontend la convertirá a absoluta
                url = f'/api/documentos/descargar/{self.id}'
        except Exception as e:
            # Si hay error, usar URL relativa
            url = f'/api/documentos/descargar/{self.id}'
        
        return {
            'id': self.id,
            'accion_id': self.accion_id,
            'nombre': self.nombre_original,
            'nombre_original': self.nombre_original,  # Alias para compatibilidad
            'tipo': self.tipo_mime,
            'tamaño': self.tamaño_bytes,
            'tamaño_bytes': self.tamaño_bytes,  # Alias para compatibilidad
            'url': url,
            'fechaSubida': self.fecha_subida.isoformat() if self.fecha_subida else None,
            'fecha_subida': self.fecha_subida.isoformat() if self.fecha_subida else None,  # Alias
            'descripcion': self.descripcion,
            'subido_por': self.subido_por,
            'activo': self.activo
        }
    
    @classmethod
    def crear_documento(cls, accion_id, nombre_original, nombre_archivo, tipo_mime, 
                       tamaño_bytes, ruta_archivo, descripcion=None, subido_por=None):
        documento = cls(
            accion_id=accion_id,
            nombre_original=nombre_original,
            nombre_archivo=nombre_archivo,
            tipo_mime=tipo_mime,
            tamaño_bytes=tamaño_bytes,
            ruta_archivo=ruta_archivo,
            descripcion=descripcion,
            subido_por=subido_por
        )
        db.session.add(documento)
        db.session.commit()
        return documento
    
    @classmethod
    def obtener_por_accion(cls, accion_id):
        return cls.query.filter_by(accion_id=accion_id, activo=True).all()
    
    @classmethod
    def obtener_por_id(cls, documento_id):
        return cls.query.filter_by(id=documento_id, activo=True).first()
    
    @classmethod
    def eliminar_documento(cls, documento_id):
        documento = cls.query.get(documento_id)
        if documento:
            documento.activo = False
            db.session.commit()
            return True
        return False