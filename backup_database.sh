#!/bin/bash

# Script de backup de base de datos MySQL
# Uso: ./backup_database.sh [nombre_bd] [usuario] [ruta_backup]

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuración por defecto
DB_NAME=${1:-sgsri_db}
DB_USER=${2:-root}
BACKUP_DIR=${3:-./backups}
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/backup_${DB_NAME}_${TIMESTAMP}.sql"

echo -e "${YELLOW}📦 Creando backup de base de datos...${NC}"

# Crear directorio de backups si no existe
mkdir -p "${BACKUP_DIR}"

# Solicitar contraseña si no se proporciona
if [ -z "$MYSQL_PWD" ]; then
    read -sp "Contraseña MySQL para ${DB_USER}: " MYSQL_PWD
    echo ""
    export MYSQL_PWD
fi

# Crear backup
echo -e "${YELLOW}🗄️  Exportando base de datos ${DB_NAME}...${NC}"
mysqldump -u "${DB_USER}" \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --quick \
    --lock-tables=false \
    "${DB_NAME}" > "${BACKUP_FILE}"

if [ $? -eq 0 ]; then
    # Comprimir backup
    echo -e "${YELLOW}📦 Comprimiendo backup...${NC}"
    gzip -f "${BACKUP_FILE}"
    BACKUP_FILE="${BACKUP_FILE}.gz"
    
    # Obtener tamaño
    SIZE=$(du -h "${BACKUP_FILE}" | cut -f1)
    
    echo -e "${GREEN}✅ Backup creado exitosamente${NC}"
    echo -e "   Archivo: ${BACKUP_FILE}"
    echo -e "   Tamaño: ${SIZE}"
    
    # Mantener solo los últimos 7 backups
    echo -e "${YELLOW}🧹 Limpiando backups antiguos (manteniendo últimos 7)...${NC}"
    ls -t "${BACKUP_DIR}"/backup_${DB_NAME}_*.sql.gz | tail -n +8 | xargs -r rm
    
    echo -e "${GREEN}✅ Proceso completado${NC}"
else
    echo -e "${RED}❌ Error al crear backup${NC}"
    exit 1
fi

