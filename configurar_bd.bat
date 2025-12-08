@echo off
echo ========================================
echo Configuracion de Base de Datos SGRI
echo ========================================
echo.

REM Activar entorno virtual
call venv\Scripts\activate.bat

REM Ejecutar script de configuración
cd backend
python setup_db.py
cd ..

pause



