@echo off
REM Script para iniciar ambos servidores (Backend y Frontend) para acceso desde red local
REM Este script abre dos ventanas: una para el backend y otra para el frontend

echo ========================================
echo Iniciando Servidores SGRI para Red Local
echo ========================================
echo.

REM Obtener y mostrar la IP del servidor
echo Obteniendo informacion de red...
cd backend
python get_server_ip.py
cd ..
echo.

REM Configurar firewall (solicitar permisos de administrador)
echo.
echo IMPORTANTE: Asegurate de que el firewall permita conexiones en los puertos 5000 y 5173
echo Si no lo has configurado, ejecuta como Administrador: backend\configure_firewall.bat
echo.

REM Iniciar Backend en una nueva ventana
echo Iniciando servidor Backend...
start "SGRI Backend" cmd /k "cd backend && if exist venv\Scripts\activate.bat (call venv\Scripts\activate.bat) else if exist ..\venv\Scripts\activate.bat (call ..\venv\Scripts\activate.bat) && python -c \"import flask_compress\" 2>nul || pip install -r ..\requirements.txt && set FLASK_ENV=development && set FLASK_HOST=0.0.0.0 && set FLASK_PORT=5000 && python run.py"

REM Esperar un poco para que el backend inicie
timeout /t 3 /nobreak >nul

REM Iniciar Frontend en una nueva ventana
echo Iniciando servidor Frontend...
start "SGRI Frontend" cmd /k "cd frontend && npm run dev -- --host 0.0.0.0"

echo.
echo ========================================
echo Servidores iniciados
echo ========================================
echo.
echo El backend esta corriendo en: http://0.0.0.0:5000
echo El frontend esta corriendo en: http://0.0.0.0:5173
echo.
echo Para acceder desde tu celular u otro equipo:
echo 1. Asegurate de que ambos esten en la misma red WiFi
echo 2. Abre el navegador y accede a la IP mostrada arriba con puerto 5173
echo    Ejemplo: http://10.10.17.26:5173
echo.
echo Presiona cualquier tecla para cerrar esta ventana...
pause >nul

