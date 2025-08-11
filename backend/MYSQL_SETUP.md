# Configuración de MySQL para SGRI

## Problema Común en Windows

El error `Authentication plugin 'auth_gssapi_client' cannot be loaded` es común en MySQL 8.0+ en Windows debido a cambios en el sistema de autenticación.

## Solución Paso a Paso

### 1. Verificar Instalación de MySQL

```bash
# Verificar que MySQL esté ejecutándose
mysql --version
```

### 2. Conectar a MySQL como Root

```bash
mysql -u root -p
```

### 3. Ejecutar Script de Configuración

Copiar y pegar el contenido de `setup_mysql.sql` en la consola de MySQL:

```sql
-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS sgri_db_final_v2
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Crear usuario específico para la aplicación
CREATE USER IF NOT EXISTS 'sgri_user'@'localhost' 
IDENTIFIED WITH mysql_native_password BY 'sgri_password';

-- Otorgar permisos al usuario
GRANT ALL PRIVILEGES ON sgri_db_final_v2.* TO 'sgri_user'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;
```

### 4. Verificar la Configuración

```sql
-- Verificar que el usuario se creó correctamente
SELECT User, Host, plugin FROM mysql.user WHERE User = 'sgri_user';

-- Verificar que la base de datos existe
SHOW DATABASES LIKE 'sgri_db_final_v2';
```

### 5. Crear Archivo .env

Crear un archivo `.env` en el directorio `backend/` con el siguiente contenido:

```env
SECRET_KEY=sgri_secret_key_2024
DATABASE_URL=mysql+mysqlconnector://sgri_user:sgri_password@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password&charset=utf8mb4
```

### 6. Probar la Conexión

```bash
# Ejecutar el script de prueba
python fix_mysql_auth.py
```

### 7. Inicializar la Base de Datos

```bash
python init_db.py
```

## Solución Automática

Si prefieres una solución automática, ejecuta:

```bash
python fix_mysql_auth.py
```

Este script:
- Te pedirá las credenciales de root
- Creará la base de datos y usuario automáticamente
- Configurará el archivo `.env`
- Probará la conexión

## Verificación Manual

Para verificar que todo funciona:

```bash
# Probar conexión
python -c "
from app import create_app, db
app = create_app()
with app.app_context():
    db.engine.connect()
    print('✅ Conexión exitosa')
"
```

## Troubleshooting

### Error: "Access denied for user 'root'@'localhost'"

1. **Reiniciar MySQL:**
   ```bash
   # En Windows (como administrador)
   net stop mysql
   net start mysql
   ```

2. **Conectar sin contraseña:**
   ```bash
   mysql -u root
   ```

3. **Cambiar contraseña de root:**
   ```sql
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'nueva_contraseña';
   FLUSH PRIVILEGES;
   ```

### Error: "Plugin 'caching_sha2_password' cannot be loaded"

1. **Cambiar plugin de autenticación:**
   ```sql
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'tu_contraseña';
   FLUSH PRIVILEGES;
   ```

### Error: "Can't connect to MySQL server"

1. **Verificar que MySQL esté ejecutándose:**
   ```bash
   # En Windows
   services.msc
   # Buscar "MySQL" y verificar que esté "Running"
   ```

2. **Verificar puerto:**
   ```bash
   netstat -an | findstr 3306
   ```

## Configuración Alternativa

Si continúas teniendo problemas, puedes usar el usuario root directamente:

```env
DATABASE_URL=mysql+mysqlconnector://root:tu_contraseña@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password&charset=utf8mb4
```

## Notas Importantes

- **mysql_native_password**: Es el plugin de autenticación compatible con mysql-connector-python
- **utf8mb4**: Soporte completo para caracteres Unicode
- **charset=utf8mb4**: Configuración de caracteres para la conexión

## Comandos Útiles

```bash
# Verificar estado de MySQL
mysqladmin -u root -p status

# Verificar usuarios
mysql -u root -p -e "SELECT User, Host, plugin FROM mysql.user;"

# Verificar bases de datos
mysql -u root -p -e "SHOW DATABASES;"

# Probar conexión con el usuario de la aplicación
mysql -u sgri_user -p sgri_db_final_v2
``` 