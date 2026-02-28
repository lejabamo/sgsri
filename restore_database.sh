#!/bin/bash

# Script para restaurar backup de base de datos MySQL
# Uso: ./restore_database.sh [archivo_backup] [nombre_bd] [usuario]

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

BACKUP_FILE=${1}
DB_NAME=${2:-sgsri_db}
DB_USER=${3:-root}

if [ -z "$BACKUP_FILE" ]; then
    echo -e "${RED}❌ Error: Debes especificar el archivo de backup${NC}"
    echo "Uso: ./restore_database.sh [archivo_backup] [nombre_bd] [usuario]"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo -e "${RED}❌ Error: Archivo de backup no encontrado: ${BACKUP_FILE}${NC}"
    exit 1
fi

echo -e "${YELLOW}📦 Restaurando backup de base de datos...${NC}"
echo -e "   Archivo: ${BACKUP_FILE}"
echo -e "   Base de datos: ${DB_NAME}"

# Confirmar
read -p "¿Estás seguro? Esto sobrescribirá la base de datos actual (s/n): " CONFIRM
if [ "$CONFIRM" != "s" ] && [ "$CONFIRM" != "S" ]; then
    echo "Operación cancelada"
    exit 0
fi

# Solicitar contraseña
read -sp "Contraseña MySQL para ${DB_USER}: " MYSQL_PWD
echo ""
export MYSQL_PWD

# Descomprimir si es necesario
TEMP_FILE="${BACKUP_FILE}"
if [[ "$BACKUP_FILE" == *.gz ]]; then
    echo -e "${YELLOW}📦 Descomprimiendo backup...${NC}"
    TEMP_FILE="/tmp/restore_$(basename ${BACKUP_FILE} .gz)"
    gunzip -c "${BACKUP_FILE}" > "${TEMP_FILE}"
fi

# Crear base de datos si no existe
echo -e "${YELLOW}🗄️  Creando base de datos si no existe...${NC}"
mysql -u "${DB_USER}" -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" || true

# Restaurar backup
echo -e "${YELLOW}📥 Restaurando datos...${NC}"
mysql -u "${DB_USER}" "${DB_NAME}" < "${TEMP_FILE}"

# Limpiar archivo temporal
if [ "$TEMP_FILE" != "$BACKUP_FILE" ]; then
    rm -f "${TEMP_FILE}"
fi

echo -e "${GREEN}✅ Backup restaurado exitosamente${NC}"

# Alterar tabla riesgos si es necesario
echo -e "${YELLOW}🔧 Verificando estructura de tabla riesgos...${NC}"
mysql "${DB_NAME}" -u "${DB_USER}" -e "ALTER TABLE riesgos MODIFY COLUMN Nombre TEXT NOT NULL;" 2>/dev/null || echo -e "${YELLOW}⚠️  Tabla riesgos puede requerir eliminación de índices primero${NC}"
mysql "${DB_NAME}" -u "${DB_USER}" -e "ALTER TABLE riesgos MODIFY COLUMN Descripcion TEXT;" 2>/dev/null || true

echo -e "${GREEN}✅ Proceso completado${NC}"

