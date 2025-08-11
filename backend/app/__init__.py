from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from .config import Config  # Usar MySQL

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    db.init_app(app)
    CORS(app)

    # Importar y registrar blueprints aquí
    from .routes.activos import activos_bp
    app.register_blueprint(activos_bp, url_prefix='/api/activos')

    from .routes.riesgos import riesgos_bp
    app.register_blueprint(riesgos_bp, url_prefix='/api/riesgos')

    from .routes.incidentes import incidentes_bp
    app.register_blueprint(incidentes_bp, url_prefix='/api/incidentes')

    from .routes.usuarios import usuarios_bp
    app.register_blueprint(usuarios_bp, url_prefix='/api/usuarios')

    from .routes.dashboard import dashboard_bp
    app.register_blueprint(dashboard_bp, url_prefix='/api/dashboard')

    # Ruta de prueba para verificar que el servidor está funcionando
    @app.route('/api/health', methods=['GET'])
    def health_check():
        return {'status': 'ok', 'message': 'SGRI API is running'}

    return app 