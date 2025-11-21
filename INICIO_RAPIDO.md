# 🚀 Inicio Rápido - Acceso desde Celular y Otros Equipos

## Pasos Rápidos (Windows)

### 0. Instalar Dependencias (Solo la primera vez o si hay errores)

Si obtienes errores como `ModuleNotFoundError`, instala las dependencias:

```bash
cd backend
install_dependencies.bat
```

O manualmente:
```bash
cd backend
.\venv\Scripts\Activate.ps1
pip install -r ..\requirements.txt
```

### 1. Configurar el Firewall (Solo la primera vez)

**Ejecuta como Administrador:**
```bash
backend\configure_firewall.bat
```

O manualmente desde PowerShell (como Administrador):
```powershell
New-NetFirewallRule -DisplayName "SGRI Backend" -Direction Inbound -LocalPort 5000 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SGRI Frontend" -Direction Inbound -LocalPort 5173 -Protocol TCP -Action Allow
```

### 2. Iniciar los Servidores

**Opción A: Script Automático (Recomendado)**
```bash
start_servers.bat
```

Este script abrirá dos ventanas:
- Una para el Backend (puerto 5000)
- Una para el Frontend (puerto 5173)

**Opción B: Manual**

Terminal 1 - Backend:
```bash
cd backend
.\venv\Scripts\Activate.ps1
python run.py
```

**IMPORTANTE:** Debe mostrar: `Running on http://0.0.0.0:5000`

Terminal 2 - Frontend:
```bash
cd frontend
npm run dev -- --host 0.0.0.0
```

**IMPORTANTE:** Debe mostrar: `Network: http://0.0.0.0:5173/`

Si NO ves "Network: http://0.0.0.0:5173/", el servidor NO está escuchando en la red.

### 3. Obtener tu IP

```bash
cd backend
python get_server_ip.py
```

Te mostrará algo como:
```
IP Principal del Servidor: 10.10.17.26
URLs de acceso:
  Backend API: http://10.10.17.26:5000
  Frontend (desarrollo): http://10.10.17.26:5173
```

### 4. Conectarse desde tu Celular u Otro Equipo

1. **Asegúrate de que estén en la misma red WiFi**
2. **Abre el navegador** en tu celular/equipo
3. **Accede a:** `http://[TU_IP]:5173`
   
   Por ejemplo: `http://10.10.17.26:5173`

## Verificación

### Desde el Servidor
```bash
# Verificar backend
curl http://localhost:5000/api/health

# O desde PowerShell
Invoke-WebRequest -Uri http://localhost:5000/api/health
```

### Desde Otro Equipo/Celular
1. Abre el navegador
2. Ve a: `http://[IP_SERVIDOR]:5000/api/health`
3. Deberías ver: `{"status": "ok", "message": "SGRI API is running"}`

## Solución de Problemas

### ❌ "This site can't be reached" o "Connection timeout"

**Causa:** El servidor no está corriendo o el firewall está bloqueando

**Solución:**
1. Verifica que ambos servidores estén corriendo
2. Verifica el firewall: `backend\configure_firewall.bat`
3. Verifica que estés en la misma red WiFi
4. Verifica la IP: `python backend\get_server_ip.py`

### ❌ El frontend carga pero no puede acceder a la API

**Causa:** La configuración de la API no está detectando correctamente el acceso remoto

**Solución:**
1. Verifica que el backend esté corriendo en `0.0.0.0:5000`
2. Abre la consola del navegador (F12) y verifica los errores
3. Si persiste, crea un archivo `.env` en `frontend/`:
   ```
   VITE_API_BASE_URL=http://[TU_IP]:5000/api
   ```
   Por ejemplo: `VITE_API_BASE_URL=http://10.10.17.26:5000/api`

### ❌ El celular no encuentra la página

**Causa:** No están en la misma red o la IP es incorrecta

**Solución:**
1. Verifica que el celular esté en la misma WiFi
2. Verifica la IP del servidor: `python backend\get_server_ip.py`
3. Prueba hacer ping desde el celular (si es posible)
4. Verifica que el servidor muestre: `Local: http://0.0.0.0:5173`

## Comandos Útiles

```bash
# Ver información de red
python backend\get_server_ip.py

# Iniciar solo backend
cd backend
python run.py

# Iniciar solo frontend
cd frontend
npm run dev

# Verificar puertos en uso (Windows)
netstat -ano | findstr :5000
netstat -ano | findstr :5173
```

## Notas Importantes

- ⚠️ El acceso es solo para la red local (misma WiFi)
- ⚠️ Para acceso desde Internet necesitas configuración adicional (VPN, dominio, etc.)
- ✅ La configuración detecta automáticamente si es acceso local o remoto
- ✅ El proxy de Vite solo funciona en acceso local
- ✅ En acceso remoto, la API se conecta directamente a la IP del servidor

