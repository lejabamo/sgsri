# Guía de Despliegue en VPS

## Requisitos Previos

- VPS con Ubuntu 20.04+ o similar
- Python 3.9+
- Node.js 18+
- MySQL 8.0+
- Nginx (opcional, recomendado)
- Certbot para SSL (opcional)

## Pasos de Despliegue

### 1. Clonar el Repositorio

```bash
git clone https://github.com/lejabamo/sgsri.git
cd sgsri
```

### 2. Configurar Backend

```bash
cd backend
python3 -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Configurar Variables de Entorno

Crear archivo `.env` en `backend/`:

```env
FLASK_ENV=production
FLASK_APP=run.py
FLASK_HOST=0.0.0.0
FLASK_PORT=5000
DATABASE_URL=mysql+pymysql://usuario:password@localhost/nombre_bd
SECRET_KEY=tu_secret_key_aqui
JWT_SECRET_KEY=tu_jwt_secret_key_aqui
```

### 4. Configurar Base de Datos

```bash
# Conectar a MySQL
mysql -u root -p

# Crear base de datos
CREATE DATABASE nombre_bd CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Ejecutar migraciones necesarias
# Si necesitas alterar la tabla riesgos:
ALTER TABLE riesgos MODIFY COLUMN Nombre TEXT NOT NULL;
ALTER TABLE riesgos MODIFY COLUMN Descripcion TEXT;
```

### 5. Inicializar Base de Datos

```bash
cd backend
python init_roles.py
python load_vulnerabilidades.py  # Si es necesario
```

### 6. Configurar Frontend

```bash
cd frontend
npm install
npm run build
```

### 7. Configurar Nginx (Recomendado)

Crear archivo `/etc/nginx/sites-available/sgsri`:

```nginx
server {
    listen 80;
    server_name tu-dominio.com;

    # Frontend
    location / {
        root /ruta/al/proyecto/frontend/dist;
        try_files $uri $uri/ /index.html;
    }

    # Backend API
    location /api {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Habilitar sitio:
```bash
sudo ln -s /etc/nginx/sites-available/sgsri /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### 8. Configurar Gunicorn (Producción)

Crear archivo `backend/gunicorn_config.py` (ya existe):

```bash
cd backend
gunicorn -c gunicorn_config.py "app:create_app()"
```

### 9. Crear Servicio Systemd para Backend

Crear `/etc/systemd/system/sgsri-backend.service`:

```ini
[Unit]
Description=SGSRI Backend Gunicorn
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/ruta/al/proyecto/backend
Environment="PATH=/ruta/al/proyecto/backend/venv/bin"
ExecStart=/ruta/al/proyecto/backend/venv/bin/gunicorn -c gunicorn_config.py "app:create_app()"

[Install]
WantedBy=multi-user.target
```

Activar servicio:
```bash
sudo systemctl daemon-reload
sudo systemctl enable sgsri-backend
sudo systemctl start sgsri-backend
sudo systemctl status sgsri-backend
```

### 10. Configurar SSL con Certbot (Opcional)

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d tu-dominio.com
```

## Comandos Útiles

### Ver logs del backend
```bash
sudo journalctl -u sgsri-backend -f
```

### Reiniciar backend
```bash
sudo systemctl restart sgsri-backend
```

### Ver logs de Nginx
```bash
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log
```

## Actualización del Sistema

```bash
cd /ruta/al/proyecto
git pull origin main
cd backend
source venv/bin/activate
pip install -r requirements.txt
cd ../frontend
npm install
npm run build
sudo systemctl restart sgsri-backend
sudo systemctl reload nginx
```

## Notas Importantes

- Asegúrate de que los puertos 80, 443 y 5000 estén abiertos en el firewall
- Configura backups regulares de la base de datos
- Revisa los logs regularmente para detectar errores
- Mantén las dependencias actualizadas

