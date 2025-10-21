from flask import Flask, request, make_response
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from .config import Config  # Usar MySQL

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Configuración UTF-8
    app.config['JSON_AS_ASCII'] = False
    app.config['MYSQL_CHARSET'] = 'utf8mb4'
    app.config['MYSQL_COLLATION'] = 'utf8mb4_unicode_ci'

    db.init_app(app)
    
    # Configuración CORS más específica
    CORS(app, 
         origins=['http://localhost:5173', 'http://127.0.0.1:5173', 'http://[::1]:5173'],
         methods=['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
         allow_headers=['Content-Type', 'Authorization'],
         supports_credentials=True)
    
    # Manejador para peticiones OPTIONS (preflight)
    @app.before_request
    def handle_preflight():
        if request.method == "OPTIONS":
            response = make_response()
            response.headers.add("Access-Control-Allow-Origin", "*")
            response.headers.add('Access-Control-Allow-Headers', "*")
            response.headers.add('Access-Control-Allow-Methods', "*")
            return response

    # Importar modelos después de inicializar db
    with app.app_context():
        from . import models
        from .auth import models as auth_models
        from .modelos.documentos import DocumentoAdjunto

    # Importar y registrar blueprints aquí
    # Autenticación (sin prefijo para endpoints básicos)
    from .auth.routes import auth_bp
    app.register_blueprint(auth_bp, url_prefix='/api/auth')
    
    # Rutas protegidas
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

    from .routes.vulnerabilidades import vulnerabilidades_bp
    app.register_blueprint(vulnerabilidades_bp, url_prefix='/api/vulnerabilidades')

    from .routes.evaluacion_riesgos import evaluacion_riesgos_bp
    app.register_blueprint(evaluacion_riesgos_bp, url_prefix='/api/evaluacion-riesgos')

    from .routes.documentos import documentos_bp
    app.register_blueprint(documentos_bp)

    # Ruta de prueba para verificar que el servidor está funcionando
    @app.route('/api/health', methods=['GET'])
    def health_check():
        return {'status': 'ok', 'message': 'SGRI API is running'}

    # Ruta raíz
    @app.route('/', methods=['GET'])
    def root():
        return {'status': 'ok', 'message': 'SGRI Backend API is running', 'version': '1.0.0'}

    return app