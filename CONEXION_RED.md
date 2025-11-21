# Guía de Conexión desde Otros Equipos

Esta guía explica cómo configurar el sistema SGRI para que sea accesible desde otros equipos en la red local.

## Requisitos Previos

1. El servidor y los equipos cliente deben estar en la misma red local
2. El firewall de Windows debe permitir conexiones en los puertos necesarios

## Paso 1: Obtener la IP del Servidor

Ejecuta el script para obtener la IP del servidor:

```bash
cd backend
python get_server_ip.py
```

Este script mostrará:
- La IP principal del servidor
- Las URLs de acceso
- Instrucciones de conexión

## Paso 2: Configurar el Firewall de Windows

Debes permitir conexiones entrantes en los puertos del sistema:

### Opción A: Usando PowerShell (Administrador)

```powershell
# Permitir puerto 5000 (Backend)
New-NetFirewallRule -DisplayName "SGRI Backend" -Direction Inbound -LocalPort 5000 -Protocol TCP -Action Allow

# Permitir puerto 5173 (Frontend desarrollo)
New-NetFirewallRule -DisplayName "SGRI Frontend Dev" -Direction Inbound -LocalPort 5173 -Protocol TCP -Action Allow
```

### Opción B: Usando la Interfaz Gráfica

1. Abre "Firewall de Windows Defender" desde el Panel de Control
2. Haz clic en "Configuración avanzada"
3. Selecciona "Reglas de entrada" → "Nueva regla"
4. Selecciona "Puerto" → Siguiente
5. Selecciona "TCP" y especifica los puertos: `5000, 5173`
6. Permite la conexión
7. Aplica a todos los perfiles
8. Dale un nombre como "SGRI - Backend y Frontend"

## Paso 3: Iniciar el Servidor

### Desarrollo

**Backend:**
```bash
cd backend
python run.py
```

El servidor se iniciará en `0.0.0.0:5000`, lo que permite conexiones desde cualquier IP de la red.

**Frontend:**
```bash
cd frontend
npm run dev
```

El servidor de desarrollo se iniciará en `0.0.0.0:5173`.

### Producción

Usa los scripts de producción:

**Windows:**
```bash
cd backend
start_production.bat
```

**Linux/Mac:**
```bash
cd backend
./start_production.sh
```

## Paso 4: Conectarse desde Otro Equipo

### Opción A: Acceso Directo al Frontend (Recomendado)

Desde el otro equipo, abre un navegador y accede a:

```
http://[IP_DEL_SERVIDOR]:5173
```

Por ejemplo: `http://192.168.1.100:5173`

### Opción B: Configurar el Frontend para Usar IP Específica

Si el frontend está en otro equipo o servidor, configura la URL de la API:

1. Crea un archivo `.env` en la carpeta `frontend/`:

```env
VITE_API_BASE_URL=http://[IP_DEL_SERVIDOR]:5000/api
```

Por ejemplo:
```env
VITE_API_BASE_URL=http://192.168.1.100:5000/api
```

2. Reinicia el servidor de desarrollo del frontend:

```bash
cd frontend
npm run dev
```

## Verificación

### Desde el Servidor

```bash
# Verificar que el backend responde
curl http://localhost:5000/api/health

# O desde PowerShell
Invoke-WebRequest -Uri http://localhost:5000/api/health
```

### Desde Otro Equipo

```bash
# Reemplaza [IP_SERVIDOR] con la IP real
curl http://[IP_SERVIDOR]:5000/api/health
```

Deberías recibir una respuesta como:
```json
{"status": "ok", "message": "SGRI API is running"}
```

## Solución de Problemas

### No se puede conectar desde otro equipo

1. **Verifica el firewall:**
   - Asegúrate de que los puertos 5000 y 5173 estén abiertos
   - Verifica que el firewall no esté bloqueando Python o Node.js

2. **Verifica la IP:**
   - Ejecuta `python backend/get_server_ip.py` para confirmar la IP
   - Asegúrate de que el cliente esté en la misma red

3. **Verifica que el servidor esté escuchando:**
   - El backend debe mostrar: `Running on http://0.0.0.0:5000`
   - El frontend debe mostrar: `Local: http://0.0.0.0:5173`

4. **Verifica la conexión de red:**
   ```bash
   # Desde el cliente, prueba ping
   ping [IP_SERVIDOR]
   ```

### Error CORS

Si ves errores de CORS, verifica que:
- El backend esté configurado para permitir el origen del frontend
- En desarrollo, CORS ya está configurado para permitir todos los orígenes
- En producción, configura la variable de entorno `CORS_ORIGINS`

### El frontend no carga recursos

Si el frontend carga pero no puede acceder a la API:
- Verifica que la URL de la API sea correcta
- Asegúrate de que el backend esté corriendo
- Revisa la consola del navegador para ver errores específicos

## Configuración Avanzada

### Usar un Dominio Local

Puedes configurar un dominio local editando el archivo `hosts`:

**Windows:** `C:\Windows\System32\drivers\etc\hosts`
**Linux/Mac:** `/etc/hosts`

Agrega:
```
[IP_SERVIDOR]  sgsri.local
```

Luego accede a: `http://sgsri.local:5173`

### Configuración de Producción con Nginx

Para producción, considera usar Nginx como proxy reverso:

```nginx
server {
    listen 80;
    server_name sgsri.local;

    location /api {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location / {
        proxy_pass http://127.0.0.1:5173;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## Seguridad

⚠️ **Importante:** Esta configuración permite acceso desde la red local. Para acceso desde Internet:

1. Usa HTTPS (certificado SSL)
2. Configura autenticación fuerte
3. Considera usar un VPN
4. Limita el acceso por IP si es posible
5. Mantén el sistema actualizado

## Resumen Rápido

1. Ejecuta `python backend/get_server_ip.py` para obtener la IP
2. Configura el firewall para permitir puertos 5000 y 5173
3. Inicia el backend: `cd backend && python run.py`
4. Inicia el frontend: `cd frontend && npm run dev`
5. Desde otro equipo, accede a: `http://[IP]:5173`

