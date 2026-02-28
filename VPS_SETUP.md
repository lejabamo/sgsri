# Configuración Rápida en VPS

## Instalación Inicial

```bash
# 1. Actualizar sistema
sudo apt update && sudo apt upgrade -y

# 2. Instalar dependencias
sudo apt install -y python3 python3-pip python3-venv nodejs npm nginx mysql-server git

# 3. Clonar repositorio
git clone https://github.com/lejabamo/sgsri.git
cd sgsri

# 4. Configurar backend
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 5. Configurar base de datos
sudo mysql -e "CREATE DATABASE sgsri CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'sgsri_user'@'localhost' IDENTIFIED BY 'password_seguro';"
sudo mysql -e "GRANT ALL PRIVILEGES ON sgsri.* TO 'sgsri_user'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# 6. Configurar variables de entorno
cp .env.example .env
nano .env  # Editar con tus credenciales

# 7. Inicializar base de datos
python init_roles.py

# 8. Construir frontend
cd ../frontend
npm install
npm run build

# 9. Configurar Nginx (ver DEPLOY.md)

# 10. Configurar servicio systemd (ver DEPLOY.md)
```

## Comandos de Actualización

```bash
# Usar el script de despliegue
chmod +x deploy.sh
./deploy.sh

# O manualmente:
git pull origin feature/langchain-integration
cd backend && source venv/bin/activate && pip install -r requirements.txt
cd ../frontend && npm install && npm run build
sudo systemctl restart sgsri-backend
```

## Notas Importantes

- Cambiar `Nombre` de riesgos a TEXT: Ejecutar el endpoint `/api/riesgos/alter-table-nombre` o el SQL manual
- Verificar que los puertos estén abiertos: `sudo ufw allow 80,443,5000/tcp`
- Configurar backups automáticos de la base de datos

