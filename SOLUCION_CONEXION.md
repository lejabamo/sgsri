# 🔧 Solución: Error de Conexión Timeout

Si ves el error **"ERR_CONNECTION_TIMED_OUT"** al intentar acceder desde tu celular u otro equipo, sigue estos pasos:

## ✅ Verificación Rápida

Ejecuta el diagnóstico:
```bash
diagnostico_red.bat
```

Este script te dirá:
- Si los servidores están corriendo
- Si el firewall está configurado
- Si hay problemas de configuración

## 🚀 Solución Paso a Paso

### Paso 1: Verificar que los Servidores Estén Corriendo

**Opción A: Usar el script automático**
```bash
start_servers.bat
```

**Opción B: Iniciar manualmente**

**Terminal 1 - Backend:**
```bash
cd backend
.\venv\Scripts\Activate.ps1
python run.py
```

Deberías ver algo como:
```
 * Running on http://0.0.0.0:5000
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev -- --host 0.0.0.0
```

Deberías ver algo como:
```
  VITE v7.x.x  ready in xxx ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: http://0.0.0.0:5173/
  ➜  Network: http://10.10.17.26:5173/
```

⚠️ **IMPORTANTE:** Si NO ves "Network: http://0.0.0.0:5173/", el servidor NO está escuchando en la red.

### Paso 2: Configurar el Firewall

**Ejecuta como Administrador:**
```bash
backend\configure_firewall.bat
```

O manualmente desde PowerShell (como Administrador):
```powershell
New-NetFirewallRule -DisplayName "SGRI Backend" -Direction Inbound -LocalPort 5000 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SGRI Frontend" -Direction Inbound -LocalPort 5173 -Protocol TCP -Action Allow
```

### Paso 3: Verificar la IP del Servidor

```bash
cd backend
python get_server_ip.py
```

Anota la IP que muestra (ejemplo: `10.10.17.26`)

### Paso 4: Conectarse desde el Celular/Otro Equipo

1. **Asegúrate de que estén en la misma red WiFi**
2. **Abre el navegador** en tu celular/equipo
3. **Accede a:** `http://[IP_DEL_SERVIDOR]:5173`
   
   Por ejemplo: `http://10.10.17.26:5173`

## 🔍 Diagnóstico de Problemas

### Problema: "This site can't be reached" o "Connection timeout"

**Causas posibles:**
1. ❌ Los servidores NO están corriendo
2. ❌ El firewall está bloqueando las conexiones
3. ❌ No están en la misma red WiFi
4. ❌ El servidor frontend NO está escuchando en 0.0.0.0

**Solución:**
1. Verifica que ambos servidores estén corriendo (ver Paso 1)
2. Verifica el firewall (ver Paso 2)
3. Verifica que estés en la misma red WiFi
4. Verifica que el frontend muestre "Network: http://0.0.0.0:5173/"

### Problema: El frontend carga pero no puede acceder a la API

**Causa:** La configuración de la API no está detectando correctamente el acceso remoto

**Solución:**
1. Verifica que el backend esté corriendo en `0.0.0.0:5000`
2. Abre la consola del navegador (F12) y verifica los errores
3. Si persiste, crea un archivo `.env` en `frontend/`:
   ```
   VITE_API_BASE_URL=http://[TU_IP]:5000/api
   ```
   Por ejemplo: `VITE_API_BASE_URL=http://10.10.17.26:5000/api`
4. Reinicia el servidor frontend

### Problema: El servidor frontend no muestra "Network: http://0.0.0.0:5173/"

**Causa:** Vite no está escuchando en todas las interfaces

**Solución:**
1. Detén el servidor frontend (Ctrl+C)
2. Inícialo con el flag explícito:
   ```bash
   cd frontend
   npm run dev -- --host 0.0.0.0
   ```
3. O usa el script: `frontend\start_dev.bat`

### Problema: El puerto está en uso

**Solución:**
```bash
# Ver qué proceso está usando el puerto
netstat -ano | findstr :5173
netstat -ano | findstr :5000

# Matar el proceso (reemplaza PID con el número que aparece)
taskkill /PID [PID] /F
```

## 📋 Checklist de Verificación

Antes de intentar conectarte, verifica:

- [ ] Backend está corriendo y muestra: `Running on http://0.0.0.0:5000`
- [ ] Frontend está corriendo y muestra: `Network: http://0.0.0.0:5173/`
- [ ] Firewall está configurado (puertos 5000 y 5173 abiertos)
- [ ] Celular/equipo está en la misma red WiFi
- [ ] IP del servidor es correcta (verificar con `python backend\get_server_ip.py`)
- [ ] No hay errores en las consolas de los servidores

## 🆘 Si Nada Funciona

1. **Ejecuta el diagnóstico completo:**
   ```bash
   diagnostico_red.bat
   ```

2. **Verifica manualmente los puertos:**
   ```bash
   netstat -ano | findstr :5000
   netstat -ano | findstr :5173
   ```

3. **Prueba desde el mismo equipo:**
   - Abre `http://localhost:5173` en el navegador
   - Si funciona localmente pero no desde otro equipo, es problema de red/firewall

4. **Verifica la configuración de red:**
   - Asegúrate de que el WiFi no esté en modo "Aislado" o "Guest"
   - Algunos routers tienen "Aislamiento de cliente" que impide comunicación entre dispositivos

## 📞 Comandos Útiles

```bash
# Ver información de red
cd backend
python get_server_ip.py

# Verificar puertos
netstat -ano | findstr :5000
netstat -ano | findstr :5173

# Verificar firewall
netsh advfirewall firewall show rule name="SGRI Backend"
netsh advfirewall firewall show rule name="SGRI Frontend Dev"

# Iniciar servidores
start_servers.bat

# Diagnóstico completo
diagnostico_red.bat
```

