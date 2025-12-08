# Script para desplegar el reporte a GitHub Pages
# Ejecuta este script después de hacer los cambios necesarios

Write-Host "🚀 Preparando despliegue a GitHub Pages..." -ForegroundColor Cyan

# Verificar que estamos en un repositorio Git
if (-not (Test-Path .git)) {
    Write-Host "❌ Error: No se encontró un repositorio Git en este directorio." -ForegroundColor Red
    exit 1
}

# Verificar que la carpeta docs existe
if (-not (Test-Path docs/index.html)) {
    Write-Host "❌ Error: No se encontró docs/index.html" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Estructura verificada" -ForegroundColor Green

# Mostrar estado actual
Write-Host "`n📊 Estado actual del repositorio:" -ForegroundColor Yellow
git status --short

Write-Host "`n📝 Archivos que se agregarán:" -ForegroundColor Yellow
Write-Host "  - docs/index.html"
Write-Host "  - docs/assets/"
Write-Host "  - docs/.nojekyll"
Write-Host "  - docs/README.md"
Write-Host "  - .github/workflows/pages.yml"
Write-Host "  - GITHUB_PAGES_SETUP.md"

Write-Host "`n⚠️  IMPORTANTE: Antes de continuar, asegúrate de:" -ForegroundColor Yellow
Write-Host "  1. Haber revisado todos los cambios"
Write-Host "  2. Tener acceso de escritura al repositorio"
Write-Host "  3. Estar en la rama correcta (evaluation o main)"

$confirm = Read-Host "`n¿Deseas continuar con el commit y push? (S/N)"

if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host "❌ Operación cancelada." -ForegroundColor Red
    exit 0
}

# Agregar archivos
Write-Host "`n📦 Agregando archivos..." -ForegroundColor Cyan
git add docs/
git add .github/workflows/pages.yml
git add GITHUB_PAGES_SETUP.md

# Hacer commit
Write-Host "💾 Creando commit..." -ForegroundColor Cyan
$commitMessage = "feat: Agregar reporte Smart Context Diagram para GitHub Pages"
git commit -m $commitMessage

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  No se pudo crear el commit. ¿Hay cambios para commitear?" -ForegroundColor Yellow
    exit 1
}

# Push
Write-Host "🚀 Subiendo cambios a GitHub..." -ForegroundColor Cyan
$currentBranch = git branch --show-current
git push origin $currentBranch

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ ¡Despliegue exitoso!" -ForegroundColor Green
    Write-Host "`n📋 Próximos pasos:" -ForegroundColor Yellow
    Write-Host "  1. Ve a tu repositorio en GitHub"
    Write-Host "  2. Settings > Pages"
    Write-Host "  3. Source: Branch '$currentBranch' / Folder: '/docs'"
    Write-Host "  4. Guarda y espera 1-2 minutos"
    Write-Host "  5. Tu sitio estará en: https://TU_USUARIO.github.io/TU_REPOSITORIO/"
    Write-Host "`n📖 Lee GITHUB_PAGES_SETUP.md para más detalles" -ForegroundColor Cyan
} else {
    Write-Host "`n❌ Error al subir cambios. Verifica tu conexión y permisos." -ForegroundColor Red
    exit 1
}

