@echo off
REM Script para instalar todas las dependencias necesarias

echo ========================================
echo Instalando dependencias de SGRI
echo ========================================
echo.

REM Activar entorno virtual si existe
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
    echo Entorno virtual activado: venv
) else if exist "..\venv\Scripts\activate.bat" (
    call ..\venv\Scripts\activate.bat
    echo Entorno virtual activado: ..\venv
) else (
    echo ADVERTENCIA: No se encontro entorno virtual.
    echo Se instalaran las dependencias globalmente.
    echo.
)

REM Instalar dependencias
echo Instalando dependencias desde requirements.txt...
pip install -r ..\requirements.txt

if %errorLevel% equ 0 (
    echo.
    echo ========================================
    echo Dependencias instaladas correctamente
    echo ========================================
) else (
    echo.
    echo ========================================
    echo ERROR: Hubo problemas al instalar dependencias
    echo ========================================
)

echo.
pause

