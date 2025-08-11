-- Script para configurar MySQL para el SGRI
-- Ejecutar como usuario root en MySQL

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

-- Verificar la configuración
SELECT User, Host, plugin FROM mysql.user WHERE User = 'sgri_user';

-- Mostrar información de la base de datos
SHOW DATABASES LIKE 'sgri_db_final_v2'; 