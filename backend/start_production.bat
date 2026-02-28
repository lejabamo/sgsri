@echo off
REM Script para iniciar la aplicación en modo producción en Windows

REM Activar entorno virtual si existe
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
) else if exist "..\venv\Scripts\activate.bat" (
    call ..\venv\Scripts\activate.bat
)

REM Configurar variables de entorno
set FLASK_ENV=production
set PYTHONPATH=%PYTHONPATH%;%CD%

REM Iniciar con Gunicorn
gunicorn -c gunicorn_config.py "run:app" ^
    --bind 0.0.0.0:5000 ^
    --workers 4 ^
    --timeout 120 ^
    --access-logfile - ^
    --error-logfile - ^
    --log-level info


