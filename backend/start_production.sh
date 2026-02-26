#!/bin/bash
# Script para iniciar la aplicación en modo producción

# Activar entorno virtual si existe
if [ -d "venv" ]; then
    source venv/bin/activate
elif [ -d "../venv" ]; then
    source ../venv/bin/activate
fi

# Configurar variables de entorno
export FLASK_ENV=production
export PYTHONPATH="${PYTHONPATH}:$(pwd)"

# Iniciar con Gunicorn
gunicorn -c gunicorn_config.py 'run:app' \
    --bind 0.0.0.0:5000 \
    --workers 4 \
    --timeout 120 \
    --access-logfile - \
    --error-logfile - \
    --log-level info


