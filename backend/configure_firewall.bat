@echo off
REM Script para configurar el firewall de Windows para permitir conexiones al servidor SGRI
REM Requiere ejecutarse como Administrador

echo ========================================
echo Configurando Firewall para SGRI
echo ========================================
echo.
echo Este script configurara el firewall para permitir conexiones
echo en los puertos 5000 (Backend) y 5173 (Frontend)
echo.

REM Verificar si se ejecuta como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Este script debe ejecutarse como Administrador
    echo.
    echo Por favor, haz clic derecho en este archivo y selecciona
    echo "Ejecutar como administrador"
    pause
    exit /b 1
)

echo Configurando reglas de firewall...
echo.

REM Eliminar reglas existentes si existen (para evitar duplicados)
netsh advfirewall firewall delete rule name="SGRI Backend" >nul 2>&1
netsh advfirewall firewall delete rule name="SGRI Frontend Dev" >nul 2>&1

REM Crear regla para el backend (puerto 5000)
netsh advfirewall firewall add rule name="SGRI Backend" dir=in action=allow protocol=TCP localport=5000
if %errorLevel% equ 0 (
    echo [OK] Regla creada para Backend (puerto 5000)
) else (
    echo [ERROR] No se pudo crear la regla para Backend
)

REM Crear regla para el frontend (puerto 5173)
netsh advfirewall firewall add rule name="SGRI Frontend Dev" dir=in action=allow protocol=TCP localport=5173
if %errorLevel% equ 0 (
    echo [OK] Regla creada para Frontend (puerto 5173)
) else (
    echo [ERROR] No se pudo crear la regla para Frontend
)

echo.
echo ========================================
echo Configuracion completada
echo ========================================
echo.
echo Los puertos 5000 y 5173 ahora estan abiertos en el firewall.
echo.
pause

