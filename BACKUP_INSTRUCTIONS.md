# Instrucciones para Backup de Base de Datos

## Crear Backup Antes de Desplegar

### Opción 1: Script Automático (Recomendado)

```bash
chmod +x create_backup_now.sh
./create_backup_now.sh
```

El script te pedirá:
- Nombre de la base de datos (por defecto: `sgri`)
- Usuario MySQL (por defecto: `root`)
- Contraseña MySQL

### Opción 2: Script de Backup General

```bash
chmod +x backup_database.sh
./backup_database.sh [nombre_bd] [usuario] [ruta_backup]
```

Ejemplo:
```bash
./backup_database.sh sgri root ./backups
```

### Opción 3: Manual con mysqldump

```bash
mysqldump -u root -p sgri > backups/backup_sgri_$(date +%Y%m%d_%H%M%S).sql
gzip backups/backup_sgri_*.sql
```

## Restaurar Backup en el VPS

### Opción 1: Script Automático

```bash
chmod +x restore_database.sh
./restore_database.sh [archivo_backup] [nombre_bd] [usuario]
```

Ejemplo:
```bash
./restore_database.sh backups/backup_sgri_20251121_171014.sql.gz sgsri_db root
```

### Opción 2: Manual

```bash
# Descomprimir si es necesario
gunzip backup_sgri_20251121_171014.sql.gz

# Restaurar
mysql -u root -p sgsri_db < backup_sgri_20251121_171014.sql
```

## Importante: Alterar Tabla Riesgos

Después de restaurar el backup, **debes alterar la tabla riesgos**:

```sql
-- Opción 1: Si no hay índices en Nombre
ALTER TABLE riesgos MODIFY COLUMN Nombre TEXT NOT NULL;
ALTER TABLE riesgos MODIFY COLUMN Descripcion TEXT;

-- Opción 2: Si hay índices, eliminarlos primero
-- Ver índices:
SHOW INDEX FROM riesgos WHERE Column_name = 'Nombre';

-- Eliminar índices:
ALTER TABLE riesgos DROP INDEX nombre_del_indice;

-- Luego alterar:
ALTER TABLE riesgos MODIFY COLUMN Nombre TEXT NOT NULL;
ALTER TABLE riesgos MODIFY COLUMN Descripcion TEXT;
```

O usar el endpoint del backend (requiere admin):
```bash
POST /api/riesgos/alter-table-nombre
```

## Ubicación de Backups

Los backups se guardan en el directorio `backups/` en la raíz del proyecto.

**Nota**: Los archivos `.sql` y `.sql.gz` están en `.gitignore` y no se suben al repositorio por seguridad y tamaño.

