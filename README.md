# SGSRI - Sistema de Gestión de Riesgos de Información

Sistema integral para la gestión de activos de información y evaluación de riesgos, desarrollado según estándares ISO 27001/27002/27005 y guías del MinTIC Colombia.

## 🚀 Características Principales

- **Gestión de Activos**: Inventario completo de activos de información con clasificación CIA
- **Evaluación de Riesgos**: Wizard interactivo para evaluación inherente y residual
- **Gestión de Controles**: Catálogo de 93 controles de seguridad basados en ISO 27002
- **Plan de Acción**: Creación y seguimiento de planes de tratamiento de riesgos
- **Documentos Adjuntos**: Gestión completa de documentos de soporte
- **Reportes y Exportación**: Generación de reportes en PDF y Excel
- **Sugerencias Inteligentes**: Sistema de sugerencias basado en datos reales de la BD

## 📋 Requisitos del Sistema

- **Backend**:
  - Python 3.9+
  - MySQL 8.0+
  - Gunicorn (producción)

- **Frontend**:
  - Node.js 18+
  - npm o yarn

- **Servidor**:
  - Ubuntu 20.04+ (recomendado Ubuntu 24.04)
  - Nginx (recomendado)
  - 2GB RAM mínimo, 4GB recomendado

## 🛠️ Instalación Rápida

### Opción 1: Script Automático (Recomendado)

```bash
# Clonar repositorio
git clone https://github.com/lejabamo/sgsri.git
cd sgsri
git checkout evaluation

# Ejecutar script de instalación
chmod +x install_ubuntu24.sh
sudo ./install_ubuntu24.sh
```

### Opción 2: Instalación Manual

Ver `VPS_SETUP.md` para instrucciones detalladas.

## 📦 Estructura del Proyecto

```
sgsri/
├── backend/              # Aplicación Flask
│   ├── app/             # Módulos de la aplicación
│   ├── run.py           # Punto de entrada
│   ├── requirements.txt # Dependencias Python
│   └── .env             # Variables de entorno (crear)
├── frontend/            # Aplicación React
│   ├── src/             # Código fuente
│   ├── package.json     # Dependencias Node.js
│   └── dist/            # Build de producción
├── deploy.sh            # Script de despliegue
├── install_ubuntu24.sh  # Script de instalación Ubuntu 24
└── DEPLOY.md            # Guía completa de despliegue
```

## 🔧 Configuración

### 1. Variables de Entorno (Backend)

Crear `backend/.env`:

```env
FLASK_ENV=production
FLASK_APP=run.py
FLASK_HOST=0.0.0.0
FLASK_PORT=5000

# Base de datos
DATABASE_URL=mysql+pymysql://usuario:password@localhost/sgsri_db

# Seguridad
SECRET_KEY=tu_secret_key_muy_seguro_aqui
JWT_SECRET_KEY=tu_jwt_secret_key_muy_seguro_aqui

# CORS (opcional)
CORS_ORIGINS=http://tu-dominio.com,https://tu-dominio.com
```

### 2. Base de Datos

```bash
# Crear base de datos
mysql -u root -p
CREATE DATABASE sgsri_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Importar backup (si existe)
mysql -u root -p sgsri_db < backup_sgsri_YYYYMMDD.sql

# O inicializar desde cero
cd backend
python init_roles.py
python load_vulnerabilidades.py
```

### 3. Alterar Tabla Riesgos (Importante)

Antes de usar el sistema, ejecutar:

```sql
-- Eliminar índices primero (si existen)
ALTER TABLE riesgos DROP INDEX nombre;  -- Ajustar según índices reales

-- Alterar columnas
ALTER TABLE riesgos MODIFY COLUMN Nombre TEXT NOT NULL;
ALTER TABLE riesgos MODIFY COLUMN Descripcion TEXT;
```

O usar el endpoint: `POST /api/riesgos/alter-table-nombre` (requiere admin)

## 🚀 Despliegue en Producción

### Usando el Script de Despliegue

```bash
./deploy.sh
```

### Manualmente

```bash
# 1. Actualizar código
git pull origin evaluation

# 2. Backend
cd backend
source venv/bin/activate
pip install -r requirements.txt

# 3. Frontend
cd ../frontend
npm install
npm run build

# 4. Reiniciar servicios
sudo systemctl restart sgsri-backend
sudo systemctl reload nginx
```

## 📝 Servicios Systemd

### Backend Service

Archivo: `/etc/systemd/system/sgsri-backend.service`

```ini
[Unit]
Description=SGSRI Backend Gunicorn
After=network.target mysql.service

[Service]
User=www-data
Group=www-data
WorkingDirectory=/ruta/completa/al/proyecto/backend
Environment="PATH=/ruta/completa/al/proyecto/backend/venv/bin"
ExecStart=/ruta/completa/al/proyecto/backend/venv/bin/gunicorn -c gunicorn_config.py "app:create_app()"
Restart=always

[Install]
WantedBy=multi-user.target
```

Activar:
```bash
sudo systemctl daemon-reload
sudo systemctl enable sgsri-backend
sudo systemctl start sgsri-backend
```

## 🔍 Verificación y Troubleshooting

### Verificar Estado de Servicios

```bash
# Backend
sudo systemctl status sgsri-backend

# Nginx
sudo systemctl status nginx

# MySQL
sudo systemctl status mysql
```

### Ver Logs

```bash
# Backend
sudo journalctl -u sgsri-backend -f

# Nginx
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log
```

### Verificar Puertos

```bash
sudo netstat -tlnp | grep -E ':(80|443|5000)'
```

## 🔐 Seguridad

- Cambiar todas las contraseñas por defecto
- Usar HTTPS en producción (Certbot)
- Configurar firewall (UFW)
- Mantener dependencias actualizadas
- Realizar backups regulares

## 📚 Documentación Adicional

- `DEPLOY.md` - Guía completa de despliegue
- `VPS_SETUP.md` - Configuración rápida
- `CHANGELOG.md` - Historial de cambios

## 🆘 Soporte

Para problemas o preguntas, revisar:
1. Logs del sistema
2. Documentación en `DEPLOY.md`
3. Issues en el repositorio GitHub

## 📄 Licencia

Este proyecto es de uso interno para gestión de riesgos de información.

