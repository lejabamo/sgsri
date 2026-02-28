# Guía Rápida de Instalación de Optimizaciones

## 📦 Instalación de Dependencias

### Backend
```bash
# Instalar nuevas dependencias
pip install Flask-Compress==1.14 gunicorn==21.2.0

# O reinstalar todas las dependencias
pip install -r requirements.txt
```

### Frontend
```bash
cd frontend
npm install
```

## ✅ Verificación

### Verificar que Flask-Compress está instalado
```bash
python -c "import flask_compress; print('Flask-Compress OK')"
```

### Verificar que Gunicorn está instalado
```bash
gunicorn --version
```

## 🚀 Pruebas Rápidas

### Desarrollo (Frontend)
```bash
cd frontend
npm run dev
```

### Desarrollo (Backend)
```bash
cd backend
python run.py
```

### Producción (Backend)
```bash
cd backend
export FLASK_ENV=production
gunicorn -c gunicorn_config.py 'run:app'
```

### Build de Producción (Frontend)
```bash
cd frontend
npm run build
```

El build optimizado estará en `frontend/dist/`

## 📊 Verificar Optimizaciones

### 1. Verificar Lazy Loading
- Abrir DevTools → Network
- Navegar entre páginas
- Verificar que los chunks se cargan bajo demanda

### 2. Verificar Compresión
```bash
curl -H "Accept-Encoding: gzip" -I http://localhost:5000/api/health
```
Deberías ver `Content-Encoding: gzip`

### 3. Verificar Caché
```bash
curl -I http://localhost:5000/api/activos
```
Deberías ver headers `Cache-Control`

### 4. Verificar Tamaño del Bundle
```bash
cd frontend
npm run build
du -sh dist/
```
El tamaño debería ser significativamente menor que antes.

## 🔧 Troubleshooting

### Error: "Cannot find module 'flask_compress'"
```bash
pip install Flask-Compress==1.14
```

### Error: "gunicorn: command not found"
```bash
pip install gunicorn==21.2.0
```

### Los chunks no se cargan
- Verificar que el build se haya hecho correctamente
- Limpiar caché del navegador
- Verificar la consola del navegador

### El backend no inicia en producción
- Verificar que FLASK_ENV=production esté configurado
- Verificar que todas las dependencias estén instaladas
- Revisar los logs de Gunicorn


