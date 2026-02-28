#!/bin/bash
# Script para iniciar el servidor y mostrar información de conexión de red

echo "========================================"
echo "Iniciando Servidor SGRI para Red Local"
echo "========================================"
echo ""

# Obtener y mostrar la IP del servidor
echo "Obteniendo información de red..."
python3 get_server_ip.py
echo ""

# Activar entorno virtual si existe
if [ -d "venv" ]; then
    source venv/bin/activate
elif [ -d "../venv" ]; then
    source ../venv/bin/activate
fi

# Configurar variables de entorno para acceso de red
export FLASK_ENV=development
export FLASK_HOST=0.0.0.0
export FLASK_PORT=5000
export PYTHONPATH="${PYTHONPATH}:$(pwd)"

echo ""
echo "Iniciando servidor backend..."
echo "El servidor estará disponible en todas las interfaces de red (0.0.0.0:5000)"
echo ""
echo "Para detener el servidor, presiona Ctrl+C"
echo ""

# Iniciar el servidor
python3 run.py

