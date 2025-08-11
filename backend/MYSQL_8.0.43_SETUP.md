# Configuración de MySQL 8.0.43 para SGRI

## 🎯 **Configuración Específica para MySQL 8.0.43**

MySQL 8.0.43 introduce cambios en el sistema de autenticación que requieren configuración específica para compatibilidad con `mysql-connector-python`.

## 📋 **Verificación Inicial**

### 1. Verificar Instalación
```bash
# Verificar versión
mysql --version

# Verificar servicio
sc query mysql
```

### 2. Ejecutar Verificador
```bash
cd backend
python check_mysql_version.py
```

## 🔧 **Configuración Paso a Paso**

### Paso 1: Conectar como Root
```bash
mysql -u root -p
```

### Paso 2: Configurar Autenticación
```sql
-- Cambiar plugin de autenticación de root
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'tu_contraseña_root';

-- Aplicar cambios
FLUSH PRIVILEGES;

-- Verificar configuración
SELECT User, Host, plugin FROM mysql.user WHERE User = 'root';
```

### Paso 3: Crear Base de Datos y Usuario
```sql
-- Crear base de datos
CREATE DATABASE IF NOT EXISTS sgri_db_final_v2
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Crear usuario específico para la aplicación
CREATE USER 'sgri_user'@'localhost' 
IDENTIFIED WITH mysql_native_password BY 'sgri_password';

-- Otorgar permisos
GRANT ALL PRIVILEGES ON sgri_db_final_v2.* TO 'sgri_user'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;

-- Verificar
SHOW DATABASES LIKE 'sgri_db_final_v2';
SELECT User, Host, plugin FROM mysql.user WHERE User = 'sgri_user';
```

### Paso 4: Crear Archivo .env
Crear archivo `.env` en el directorio `backend/`:
```env
SECRET_KEY=sgri_secret_key_2024
DATABASE_URL=mysql+mysqlconnector://sgri_user:sgri_password@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password&charset=utf8mb4
```

## 🧪 **Pruebas de Conexión**

### Prueba 1: Conexión Directa
```bash
mysql -u sgri_user -p sgri_db_final_v2
```

### Prueba 2: Desde Python
```bash
python -c "
import mysql.connector
conn = mysql.connector.connect(
    host='localhost',
    user='sgri_user',
    password='sgri_password',
    database='sgri_db_final_v2',
    auth_plugin='mysql_native_password'
)
print('✅ Conexión exitosa')
conn.close()
"
```

### Prueba 3: Con Flask-SQLAlchemy
```bash
python -c "
from app import create_app, db
app = create_app()
with app.app_context():
    db.engine.connect()
    print('✅ Conexión Flask-SQLAlchemy exitosa')
"
```

## 🚀 **Inicialización del SGRI**

### 1. Ejecutar Script de Configuración
```bash
python fix_mysql_auth.py
```

### 2. Inicializar Base de Datos
```bash
python init_db.py
```

### 3. Ejecutar Servidor
```bash
python run.py
```

## 🔍 **Troubleshooting Específico para 8.0.43**

### Error: "Authentication plugin 'caching_sha2_password'"
**Solución:**
```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'tu_contraseña';
FLUSH PRIVILEGES;
```

### Error: "Authentication plugin 'auth_gssapi_client'"
**Solución:**
```sql
-- Verificar plugins disponibles
SHOW PLUGINS;

-- Usar mysql_native_password explícitamente
CREATE USER 'sgri_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'sgri_password';
```

### Error: "Access denied for user"
**Solución:**
```sql
-- Verificar permisos
SHOW GRANTS FOR 'sgri_user'@'localhost';

-- Otorgar permisos completos si es necesario
GRANT ALL PRIVILEGES ON sgri_db_final_v2.* TO 'sgri_user'@'localhost';
FLUSH PRIVILEGES;
```

## 📊 **Comparación de Versiones**

| Versión | Compatibilidad | Configuración | Recomendación |
|---------|----------------|---------------|---------------|
| MySQL 5.7.x | ⭐⭐⭐⭐⭐ | Mínima | Ideal para compatibilidad |
| MySQL 8.0.36 | ⭐⭐⭐⭐ | Moderada | Buena opción |
| MySQL 8.0.43 | ⭐⭐⭐ | Específica | Requiere configuración |

## 🎯 **Recomendaciones para 8.0.43**

### ✅ **Hacer:**
- Usar `mysql_native_password` explícitamente
- Crear usuario específico para la aplicación
- Usar `charset=utf8mb4`
- Verificar configuración antes de usar

### ❌ **Evitar:**
- Usar `caching_sha2_password` (incompatible)
- Usar `auth_gssapi_client` (no disponible)
- Conectar sin especificar plugin de autenticación

## 🔧 **Configuración Automática**

Si prefieres configuración automática:
```bash
python fix_mysql_auth.py
```

Este script:
1. Detecta tu versión de MySQL
2. Configura autenticación correctamente
3. Crea usuario y base de datos
4. Prueba la conexión
5. Genera archivo `.env`

## 📝 **Comandos Útiles**

```bash
# Verificar versión
mysql --version

# Verificar servicio
sc query mysql

# Conectar sin contraseña
mysql -u root

# Verificar usuarios
mysql -u root -p -e "SELECT User, Host, plugin FROM mysql.user;"

# Verificar bases de datos
mysql -u root -p -e "SHOW DATABASES;"

# Probar conexión de la aplicación
mysql -u sgri_user -p sgri_db_final_v2
```

## 🎉 **Verificación Final**

Después de la configuración, ejecuta:
```bash
# Verificar todo
python check_mysql_version.py

# Inicializar SGRI
python init_db.py

# Ejecutar servidor
python run.py
```

Si todo funciona correctamente, deberías ver:
- ✅ Conexión exitosa a MySQL 8.0.43
- ✅ Base de datos creada con datos de ejemplo
- ✅ Servidor Flask ejecutándose en http://localhost:5000 