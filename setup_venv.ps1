# Script PowerShell para configurar el entorno virtual SGRI

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Configuracion del Entorno Virtual SGRI" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que Python está instalado
Write-Host "[1/4] Verificando Python..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host $pythonVersion -ForegroundColor Green
} catch {
    Write-Host "ERROR: Python no esta instalado o no esta en el PATH" -ForegroundColor Red
    Write-Host "Por favor instala Python 3.8 o superior" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}
Write-Host ""

# Eliminar el venv anterior si existe
if (Test-Path "venv") {
    Write-Host "[2/4] Eliminando entorno virtual anterior..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force venv
    Write-Host "Entorno virtual anterior eliminado" -ForegroundColor Green
    Write-Host ""
}

# Crear nuevo entorno virtual
Write-Host "[3/4] Creando nuevo entorno virtual..." -ForegroundColor Yellow
python -m venv venv
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo crear el entorno virtual" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}
Write-Host "Entorno virtual creado exitosamente" -ForegroundColor Green
Write-Host ""

# Activar el entorno virtual
Write-Host "[4/4] Activando entorno virtual e instalando dependencias..." -ForegroundColor Yellow
& "venv\Scripts\Activate.ps1"

# Actualizar pip
Write-Host "Actualizando pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip

# Instalar dependencias del backend
Write-Host ""
Write-Host "Instalando dependencias del backend..." -ForegroundColor Yellow
Set-Location backend
pip install -r requirements.txt
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudieron instalar las dependencias" -ForegroundColor Red
    Set-Location ..
    Read-Host "Presiona Enter para salir"
    exit 1
}
Set-Location ..

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Entorno virtual configurado exitosamente!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para activar el entorno virtual en el futuro, ejecuta:" -ForegroundColor Yellow
Write-Host "  venv\Scripts\Activate.ps1" -ForegroundColor Cyan
Write-Host ""
Read-Host "Presiona Enter para continuar"



