#!/bin/bash

# Script de despliegue automático para VPS
# Uso: ./deploy.sh

set -e  # Salir si hay algún error

echo "🚀 Iniciando despliegue de SGSRI..."

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar que estamos en el directorio correcto
if [ ! -f "backend/run.py" ] || [ ! -f "frontend/package.json" ]; then
    echo -e "${RED}❌ Error: No se encontraron los archivos del proyecto. Asegúrate de estar en el directorio raíz.${NC}"
    exit 1
fi

# 1. Actualizar código desde Git
echo -e "${YELLOW}📥 Actualizando código desde Git...${NC}"
git pull origin main || git pull origin master

# 2. Backend
echo -e "${YELLOW}🔧 Configurando backend...${NC}"
cd backend

# Activar entorno virtual
if [ ! -d "venv" ]; then
    echo "Creando entorno virtual..."
    python3 -m venv venv
fi

source venv/bin/activate

# Instalar/actualizar dependencias
echo "Instalando dependencias de Python..."
pip install --upgrade pip
pip install -r requirements.txt

# 3. Frontend
echo -e "${YELLOW}🎨 Construyendo frontend...${NC}"
cd ../frontend

# Instalar dependencias
echo "Instalando dependencias de Node.js..."
npm install

# Build de producción
echo "Construyendo aplicación para producción..."
npm run build

# 4. Reiniciar servicios
echo -e "${YELLOW}🔄 Reiniciando servicios...${NC}"
cd ..

# Reiniciar backend si existe el servicio systemd
if systemctl is-active --quiet sgsri-backend; then
    echo "Reiniciando servicio sgsri-backend..."
    sudo systemctl restart sgsri-backend
    echo -e "${GREEN}✅ Servicio backend reiniciado${NC}"
else
    echo -e "${YELLOW}⚠️  Servicio sgsri-backend no encontrado. Inicia manualmente con:${NC}"
    echo "   cd backend && source venv/bin/activate && gunicorn -c gunicorn_config.py 'app:create_app()'"
fi

# Recargar Nginx si está instalado
if command -v nginx &> /dev/null; then
    echo "Recargando Nginx..."
    sudo systemctl reload nginx
    echo -e "${GREEN}✅ Nginx recargado${NC}"
fi

echo -e "${GREEN}✅ Despliegue completado exitosamente!${NC}"
echo ""
echo "Verifica el estado del sistema:"
echo "  - Backend: sudo systemctl status sgsri-backend"
echo "  - Nginx: sudo systemctl status nginx"
echo "  - Logs: sudo journalctl -u sgsri-backend -f"

