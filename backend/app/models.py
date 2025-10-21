
from . import db
from datetime import datetime

class UsuarioSistema(db.Model):
    __tablename__ = 'usuarios_sistema'
    id_usuario = db.Column(db.Integer, primary_key=True)
    nombre_completo = db.Column(db.String(255), nullable=False)
    email_institucional = db.Column(db.String(255), unique=True, nullable=False)
    password_hash = db.Column(db.String(255))
    puesto_organizacion = db.Column(db.String(255))
    estado_usuario = db.Column(db.String(50))
    fecha_creacion_registro = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_ultima_actualizacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    fecha_ultimo_login = db.Column(db.DateTime)
    intentos_fallidos_login = db.Column(db.Integer, default=0)
    requiere_cambio_password = db.Column(db.Boolean, default=False)
    
    # Relaciones
    activos_propietario = db.relationship('Activo', foreign_keys='Activo.ID_Propietario', backref='propietario')
    activos_custodio = db.relationship('Activo', foreign_keys='Activo.ID_Custodio', backref='custodio')

class Activo(db.Model):
    __tablename__ = 'activos'
    ID_Activo = db.Column(db.Integer, primary_key=True)
    Nombre = db.Column(db.String(255), nullable=False)
    Descripcion = db.Column(db.Text)
    Tipo_Activo = db.Column(db.String(50), nullable=False)
    subtipo_activo = db.Column(db.String(100))
    ID_Propietario = db.Column(db.Integer, db.ForeignKey('usuarios_sistema.id_usuario'))
    ID_Custodio = db.Column(db.Integer, db.ForeignKey('usuarios_sistema.id_usuario'))
    Nivel_Clasificacion_Confidencialidad = db.Column(db.String(50), default='Uso Interno')
    Nivel_Clasificacion_Integridad = db.Column(db.String(10), default='Media')
    Nivel_Clasificacion_Disponibilidad = db.Column(db.String(10), default='Media')
    justificacion_clasificacion_cia = db.Column(db.Text)
    nivel_criticidad_negocio = db.Column(db.String(10), default='Medio')
    estado_activo = db.Column(db.String(20), default='Planificado')
    fuente_datos_principal = db.Column(db.String(50), default='SGSI_Manual')
    id_externo_glpi = db.Column(db.String(100))
    id_externo_inventario_si = db.Column(db.String(100))
    fecha_adquisicion = db.Column(db.Date)
    version_general_activo = db.Column(db.String(50))
    requiere_backup = db.Column(db.Boolean, default=True)
    frecuencia_backup_general = db.Column(db.String(100))
    tiempo_retencion_general = db.Column(db.String(100))
    fecha_proxima_revision_sgsi = db.Column(db.Date)
    procedimiento_eliminacion_segura_ref = db.Column(db.Text)
    fecha_creacion_registro = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_ultima_actualizacion_sgsi = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relaciones
    riesgos = db.relationship('RiesgoActivo', backref='activo', lazy='dynamic')
    
    def to_dict(self):
        return {
            'ID_Activo': self.ID_Activo,
            'Nombre': self.Nombre,
            'Descripcion': self.Descripcion,
            'Tipo_Activo': self.Tipo_Activo,
            'subtipo_activo': self.subtipo_activo,
            'ID_Propietario': self.ID_Propietario,
            'ID_Custodio': self.ID_Custodio,
            'Nivel_Clasificacion_Confidencialidad': self.Nivel_Clasificacion_Confidencialidad,
            'Nivel_Clasificacion_Integridad': self.Nivel_Clasificacion_Integridad,
            'Nivel_Clasificacion_Disponibilidad': self.Nivel_Clasificacion_Disponibilidad,
            'justificacion_clasificacion_cia': self.justificacion_clasificacion_cia,
            'nivel_criticidad_negocio': self.nivel_criticidad_negocio,
            'estado_activo': self.estado_activo,
            'fuente_datos_principal': self.fuente_datos_principal,
            'id_externo_glpi': self.id_externo_glpi,
            'id_externo_inventario_si': self.id_externo_inventario_si,
            'fecha_adquisicion': self.fecha_adquisicion.isoformat() if self.fecha_adquisicion else None,
            'version_general_activo': self.version_general_activo,
            'requiere_backup': self.requiere_backup,
            'frecuencia_backup_general': self.frecuencia_backup_general,
            'tiempo_retencion_general': self.tiempo_retencion_general,
            'fecha_proxima_revision_sgsi': self.fecha_proxima_revision_sgsi.isoformat() if self.fecha_proxima_revision_sgsi else None,
            'procedimiento_eliminacion_segura_ref': self.procedimiento_eliminacion_segura_ref,
            'fecha_creacion_registro': self.fecha_creacion_registro.isoformat() if self.fecha_creacion_registro else None,
            'fecha_ultima_actualizacion_sgsi': self.fecha_ultima_actualizacion_sgsi.isoformat() if self.fecha_ultima_actualizacion_sgsi else None
        }

class Riesgo(db.Model):
    __tablename__ = 'riesgos'
    ID_Riesgo = db.Column(db.Integer, primary_key=True)
    Nombre = db.Column(db.String(255), nullable=False)
    Descripcion = db.Column(db.Text)
    ID_Amenaza_General = db.Column(db.Integer)
    ID_Vulnerabilidad_General = db.Column(db.Integer)
    ID_Proceso_Principal_Afectado = db.Column(db.Integer)
    tipo_riesgo = db.Column(db.String(100))
    Efectos_Materializacion = db.Column(db.Text)
    Fecha_Identificacion = db.Column(db.Date)
    Estado_Riesgo_General = db.Column(db.String(50))
    ID_Propietario_Riesgo_General = db.Column(db.Integer)
    fecha_creacion_registro = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_ultima_actualizacion = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relaciones
    activos = db.relationship('RiesgoActivo', backref='riesgo', lazy='dynamic')
    
    def to_dict(self):
        return {
            'ID_Riesgo': self.ID_Riesgo,
            'Nombre': self.Nombre,
            'Descripcion': self.Descripcion,
            'ID_Amenaza_General': self.ID_Amenaza_General,
            'ID_Vulnerabilidad_General': self.ID_Vulnerabilidad_General,
            'ID_Proceso_Principal_Afectado': self.ID_Proceso_Principal_Afectado,
            'tipo_riesgo': self.tipo_riesgo,
            'Efectos_Materializacion': self.Efectos_Materializacion,
            'Fecha_Identificacion': self.Fecha_Identificacion.isoformat() if self.Fecha_Identificacion else None,
            'Estado_Riesgo_General': self.Estado_Riesgo_General,
            'ID_Propietario_Riesgo_General': self.ID_Propietario_Riesgo_General,
            'fecha_creacion_registro': self.fecha_creacion_registro.isoformat() if self.fecha_creacion_registro else None,
            'fecha_ultima_actualizacion': self.fecha_ultima_actualizacion.isoformat() if self.fecha_ultima_actualizacion else None
        }

class RiesgoActivo(db.Model):
    __tablename__ = 'riesgo_activo'
    id = db.Column(db.Integer, primary_key=True)
    id_riesgo = db.Column(db.Integer, db.ForeignKey('riesgos.ID_Riesgo'), nullable=False)
    ID_Activo = db.Column(db.Integer, db.ForeignKey('activos.ID_Activo'), nullable=False)
    probabilidad = db.Column(db.Integer)  # 1-5 escala
    impacto = db.Column(db.Integer)  # 1-5 escala
    nivel_riesgo_calculado = db.Column(db.String(50))
    medidas_mitigacion = db.Column(db.Text)
    fecha_evaluacion = db.Column(db.DateTime, default=datetime.utcnow)
    
    def calcular_nivel_riesgo(self):
        if self.probabilidad and self.impacto:
            riesgo_total = self.probabilidad * self.impacto
            if riesgo_total <= 4:
                return 'Bajo'
            elif riesgo_total <= 12:
                return 'Medio'
            else:
                return 'Alto'
        return None

class Incidente(db.Model):
    __tablename__ = 'incidentes'
    id_incidente = db.Column(db.Integer, primary_key=True)
    titulo = db.Column(db.String(255), nullable=False)
    descripcion = db.Column(db.Text)
    tipo_incidente = db.Column(db.String(100))
    severidad = db.Column(db.String(50))
    estado = db.Column(db.String(50), default='Abierto')
    ID_Activo = db.Column(db.Integer, db.ForeignKey('activos.ID_Activo'))
    fecha_incidente = db.Column(db.DateTime, default=datetime.utcnow)
    fecha_resolucion = db.Column(db.DateTime)
    responsable = db.Column(db.String(255))
    acciones_correctivas = db.Column(db.Text)
    
    def to_dict(self):
        return {
            'id_incidente': self.id_incidente,
            'titulo': self.titulo,
            'descripcion': self.descripcion,
            'tipo_incidente': self.tipo_incidente,
            'severidad': self.severidad,
            'estado': self.estado,
            'ID_Activo': self.ID_Activo,
            'fecha_incidente': self.fecha_incidente.isoformat() if self.fecha_incidente else None,
            'fecha_resolucion': self.fecha_resolucion.isoformat() if self.fecha_resolucion else None,
            'responsable': self.responsable,
            'acciones_correctivas': self.acciones_correctivas
        } 