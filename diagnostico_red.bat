@echo off
REM Script de diagnostico para conexion de red

echo ========================================
echo DIAGNOSTICO DE CONEXION SGRI
echo ========================================
echo.

echo [1] Verificando IP del servidor...
cd backend
python get_server_ip.py
cd ..
echo.

echo [2] Verificando puertos en uso...
echo.
echo Puerto 5000 (Backend):
netstat -ano | findstr :5000
if %errorLevel% neq 0 (
    echo   [X] Puerto 5000 NO esta en uso - Backend NO esta corriendo
) else (
    echo   [OK] Puerto 5000 esta en uso
)
echo.

echo Puerto 5173 (Frontend):
netstat -ano | findstr :5173
if %errorLevel% neq 0 (
    echo   [X] Puerto 5173 NO esta en uso - Frontend NO esta corriendo
) else (
    echo   [OK] Puerto 5173 esta en uso
)
echo.

echo [3] Verificando reglas de firewall...
netsh advfirewall firewall show rule name="SGRI Backend" >nul 2>&1
if %errorLevel% equ 0 (
    echo   [OK] Regla de firewall para Backend encontrada
) else (
    echo   [X] Regla de firewall para Backend NO encontrada
    echo   Ejecuta como Administrador: backend\configure_firewall.bat
)
echo.

netsh advfirewall firewall show rule name="SGRI Frontend Dev" >nul 2>&1
if %errorLevel% equ 0 (
    echo   [OK] Regla de firewall para Frontend encontrada
) else (
    echo   [X] Regla de firewall para Frontend NO encontrada
    echo   Ejecuta como Administrador: backend\configure_firewall.bat
)
echo.

echo [4] Verificando dependencias del backend...
cd backend
if exist venv\Scripts\python.exe (
    venv\Scripts\python.exe test_server.py
) else (
    echo   [X] Entorno virtual no encontrado
)
cd ..
echo.

echo ========================================
echo RESUMEN
echo ========================================
echo.
echo Si los servidores NO estan corriendo:
echo   1. Ejecuta: start_servers.bat
echo   2. O inicia manualmente:
echo      - Backend: cd backend ^&^& python run.py
echo      - Frontend: cd frontend ^&^& npm run dev
echo.
echo Si el firewall NO esta configurado:
echo   Ejecuta como Administrador: backend\configure_firewall.bat
echo.
pause

