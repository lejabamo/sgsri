#!/bin/bash

# Script de instalación completa para Ubuntu 24.04
# Uso: sudo ./install_ubuntu24.sh

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Instalación SGSRI - Ubuntu 24.04     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Verificar que se ejecuta como root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}❌ Por favor ejecuta con sudo${NC}"
    exit 1
fi

# 1. Actualizar sistema
echo -e "${YELLOW}📦 Actualizando sistema...${NC}"
apt update && apt upgrade -y

# 2. Instalar dependencias del sistema
echo -e "${YELLOW}📦 Instalando dependencias del sistema...${NC}"
apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    nodejs \
    npm \
    nginx \
    mysql-server \
    git \
    curl \
    wget \
    build-essential \
    libmysqlclient-dev \
    pkg-config \
    certbot \
    python3-certbot-nginx \
    ufw

# 3. Verificar versiones
echo -e "${YELLOW}🔍 Verificando versiones instaladas...${NC}"
python3 --version
nodejs --version
npm --version
mysql --version
nginx -v

# 4. Configurar MySQL
echo -e "${YELLOW}🗄️  Configurando MySQL...${NC}"
systemctl start mysql
systemctl enable mysql

# Crear base de datos (si no existe)
echo -e "${YELLOW}📝 Creando base de datos...${NC}"
read -p "Nombre de la base de datos [sgsri_db]: " DB_NAME
DB_NAME=${DB_NAME:-sgsri_db}

read -p "Usuario MySQL [sgsri_user]: " DB_USER
DB_USER=${DB_USER:-sgsri_user}

read -sp "Contraseña MySQL: " DB_PASS
echo ""

mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" || true
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';" || true
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

echo -e "${GREEN}✅ Base de datos configurada${NC}"

# 5. Configurar firewall
echo -e "${YELLOW}🔥 Configurando firewall...${NC}"
ufw --force enable
ufw allow 22/tcp   # SSH
ufw allow 80/tcp   # HTTP
ufw allow 443/tcp # HTTPS
ufw allow 5000/tcp # Backend (temporal, luego usar Nginx)
echo -e "${GREEN}✅ Firewall configurado${NC}"

# 6. Configurar backend
echo -e "${YELLOW}🐍 Configurando backend Python...${NC}"
cd backend

# Crear entorno virtual
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

source venv/bin/activate

# Actualizar pip
pip install --upgrade pip setuptools wheel

# Instalar dependencias
echo -e "${YELLOW}📦 Instalando dependencias Python...${NC}"
pip install -r requirements.txt

# Instalar Gunicorn si no está
pip install gunicorn || true

echo -e "${GREEN}✅ Backend configurado${NC}"

# 7. Configurar frontend
echo -e "${YELLOW}⚛️  Configurando frontend...${NC}"
cd ../frontend

# Instalar dependencias
echo -e "${YELLOW}📦 Instalando dependencias Node.js...${NC}"
npm install

# Build de producción
echo -e "${YELLOW}🏗️  Construyendo aplicación...${NC}"
npm run build

echo -e "${GREEN}✅ Frontend configurado${NC}"

# 8. Crear archivo .env de ejemplo
cd ../backend
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}📝 Creando archivo .env de ejemplo...${NC}"
    cat > .env.example << EOF
FLASK_ENV=production
FLASK_APP=run.py
FLASK_HOST=0.0.0.0
FLASK_PORT=5000

DATABASE_URL=mysql+pymysql://${DB_USER}:${DB_PASS}@localhost/${DB_NAME}

SECRET_KEY=$(python3 -c 'import secrets; print(secrets.token_hex(32))')
JWT_SECRET_KEY=$(python3 -c 'import secrets; print(secrets.token_hex(32))')

CORS_ORIGINS=http://localhost,http://localhost:5173
EOF
    echo -e "${YELLOW}⚠️  Archivo .env.example creado. Copia a .env y edita con tus valores:${NC}"
    echo "   cp .env.example .env"
    echo "   nano .env"
else
    echo -e "${GREEN}✅ Archivo .env ya existe${NC}"
fi

# 9. Inicializar base de datos
echo -e "${YELLOW}🗄️  Inicializando base de datos...${NC}"
read -p "¿Deseas inicializar la base de datos ahora? (s/n): " INIT_DB
if [ "$INIT_DB" = "s" ] || [ "$INIT_DB" = "S" ]; then
    source venv/bin/activate
    python init_roles.py || echo -e "${YELLOW}⚠️  init_roles.py puede requerir configuración adicional${NC}"
    
    # Alterar tabla riesgos
    echo -e "${YELLOW}🔧 Alterando tabla riesgos...${NC}"
    mysql ${DB_NAME} -e "ALTER TABLE riesgos MODIFY COLUMN Nombre TEXT NOT NULL;" 2>/dev/null || echo -e "${YELLOW}⚠️  Tabla riesgos puede requerir eliminación de índices primero${NC}"
    mysql ${DB_NAME} -e "ALTER TABLE riesgos MODIFY COLUMN Descripcion TEXT;" 2>/dev/null || true
fi

cd ..

# 10. Resumen
echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✅ Instalación Completada            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Próximos pasos:${NC}"
echo "1. Configurar archivo .env en backend/"
echo "2. Configurar Nginx (ver DEPLOY.md)"
echo "3. Crear servicio systemd (ver DEPLOY.md)"
echo "4. Importar backup de BD si existe"
echo ""
echo -e "${BLUE}Comandos útiles:${NC}"
echo "  - Iniciar backend: cd backend && source venv/bin/activate && python run.py"
echo "  - Ver logs: sudo journalctl -u sgsri-backend -f"
echo "  - Actualizar: ./deploy.sh"
echo ""

