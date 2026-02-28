@echo off
echo ========================================
echo Configuracion del Entorno Virtual SGRI
echo ========================================
echo.

REM Verificar que Python esta instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python no esta instalado o no esta en el PATH
    echo Por favor instala Python 3.8 o superior
    pause
    exit /b 1
)

echo [1/4] Verificando Python...
python --version
echo.

REM Eliminar el venv anterior si existe
if exist venv (
    echo [2/4] Eliminando entorno virtual anterior...
    rmdir /s /q venv
    echo Entorno virtual anterior eliminado
    echo.
)

REM Crear nuevo entorno virtual
echo [3/4] Creando nuevo entorno virtual...
python -m venv venv
if errorlevel 1 (
    echo ERROR: No se pudo crear el entorno virtual
    pause
    exit /b 1
)
echo Entorno virtual creado exitosamente
echo.

REM Activar el entorno virtual
echo [4/4] Activando entorno virtual e instalando dependencias...
call venv\Scripts\activate.bat

REM Actualizar pip
echo Actualizando pip...
python -m pip install --upgrade pip

REM Instalar dependencias del backend
echo.
echo Instalando dependencias del backend...
cd backend
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: No se pudieron instalar las dependencias
    cd ..
    pause
    exit /b 1
)
cd ..

echo.
echo ========================================
echo Entorno virtual configurado exitosamente!
echo ========================================
echo.
echo Para activar el entorno virtual en el futuro, ejecuta:
echo   venv\Scripts\activate.bat
echo.
pause



