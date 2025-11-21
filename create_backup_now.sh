#!/bin/bash

# Script para crear backup de la BD actual antes de desplegar
# Uso: ./create_backup_now.sh

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}📦 Creando backup de la base de datos actual...${NC}"

# Leer configuración desde .env si existe
if [ -f "backend/.env" ]; then
    source backend/.env
    DB_NAME=${DB_NAME:-sgri}
    DB_USER=${DB_USER:-root}
else
    read -p "Nombre de la base de datos [sgri]: " DB_NAME
    DB_NAME=${DB_NAME:-sgri}
    
    read -p "Usuario MySQL [root]: " DB_USER
    DB_USER=${DB_USER:-root}
fi

read -sp "Contraseña MySQL: " DB_PASS
echo ""

# Crear directorio de backups
mkdir -p backups

# Crear backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backups/backup_${DB_NAME}_${TIMESTAMP}.sql"

echo -e "${YELLOW}🗄️  Exportando base de datos ${DB_NAME}...${NC}"

export MYSQL_PWD="${DB_PASS}"
mysqldump -u "${DB_USER}" \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --quick \
    --lock-tables=false \
    "${DB_NAME}" > "${BACKUP_FILE}"

if [ $? -eq 0 ]; then
    # Comprimir
    echo -e "${YELLOW}📦 Comprimiendo backup...${NC}"
    gzip -f "${BACKUP_FILE}"
    BACKUP_FILE="${BACKUP_FILE}.gz"
    
    SIZE=$(du -h "${BACKUP_FILE}" | cut -f1)
    
    echo -e "${GREEN}✅ Backup creado exitosamente${NC}"
    echo -e "   Archivo: ${BACKUP_FILE}"
    echo -e "   Tamaño: ${SIZE}"
    echo ""
    echo -e "${YELLOW}💡 Para restaurar en el VPS:${NC}"
    echo "   ./restore_database.sh ${BACKUP_FILE} ${DB_NAME} ${DB_USER}"
else
    echo -e "${RED}❌ Error al crear backup${NC}"
    exit 1
fi

