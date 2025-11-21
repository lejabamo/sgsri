#!/bin/bash
# Script para iniciar ambos servidores (Backend y Frontend) para acceso desde red local

echo "========================================"
echo "Iniciando Servidores SGRI para Red Local"
echo "========================================"
echo ""

# Obtener y mostrar la IP del servidor
echo "Obteniendo información de red..."
cd backend
python3 get_server_ip.py
cd ..
echo ""

echo ""
echo "IMPORTANTE: Asegúrate de que el firewall permita conexiones en los puertos 5000 y 5173"
echo ""

# Función para iniciar backend
start_backend() {
    cd backend
    if [ -d "venv" ]; then
        source venv/bin/activate
    elif [ -d "../venv" ]; then
        source ../venv/bin/activate
    fi
    export FLASK_ENV=development
    export FLASK_HOST=0.0.0.0
    export FLASK_PORT=5000
    python3 run.py
}

# Función para iniciar frontend
start_frontend() {
    cd frontend
    npm run dev
}

# Iniciar backend en background
echo "Iniciando servidor Backend..."
start_backend &
BACKEND_PID=$!

# Esperar un poco para que el backend inicie
sleep 3

# Iniciar frontend en background
echo "Iniciando servidor Frontend..."
start_frontend &
FRONTEND_PID=$!

echo ""
echo "========================================"
echo "Servidores iniciados"
echo "========================================"
echo ""
echo "El backend está corriendo en: http://0.0.0.0:5000"
echo "El frontend está corriendo en: http://0.0.0.0:5173"
echo ""
echo "Para acceder desde tu celular u otro equipo:"
echo "1. Asegúrate de que ambos estén en la misma red WiFi"
echo "2. Abre el navegador y accede a la IP mostrada arriba con puerto 5173"
echo ""
echo "Presiona Ctrl+C para detener ambos servidores"

# Esperar a que se presione Ctrl+C
trap "kill $BACKEND_PID $FRONTEND_PID; exit" INT TERM
wait

