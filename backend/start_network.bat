@echo off
REM Script para iniciar el servidor y mostrar información de conexión de red

echo ========================================
echo Iniciando Servidor SGRI para Red Local
echo ========================================
echo.

REM Obtener y mostrar la IP del servidor
echo Obteniendo informacion de red...
python get_server_ip.py
echo.

REM Activar entorno virtual si existe
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
) else if exist "..\venv\Scripts\activate.bat" (
    call ..\venv\Scripts\activate.bat
)

REM Verificar que el entorno virtual esté activo e instalar dependencias si es necesario
python -c "import flask_compress" 2>nul
if errorlevel 1 (
    echo Instalando dependencias faltantes...
    pip install -r ..\requirements.txt
)

REM Configurar variables de entorno para acceso de red
set FLASK_ENV=development
set FLASK_HOST=0.0.0.0
set FLASK_PORT=5000
set PYTHONPATH=%PYTHONPATH%;%CD%

echo.
echo Iniciando servidor backend...
echo El servidor estara disponible en todas las interfaces de red (0.0.0.0:5000)
echo.
echo Para detener el servidor, presiona Ctrl+C
echo.

REM Iniciar el servidor
python run.py

