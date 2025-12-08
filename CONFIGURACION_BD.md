# Configuración de Base de Datos SGRI

## Resumen

Este sistema utiliza **MySQL** como base de datos. Se ha recreado el `models.py` consolidando todos los modelos del sistema y se ha configurado el entorno para trabajar exclusivamente con MySQL.

## Pasos para Configurar la Base de Datos

### 1. Verificar que MySQL esté instalado y ejecutándose

Asegúrate de que MySQL esté instalado y el servicio esté corriendo en tu PC.

### 2. Configurar la base de datos

Ejecuta uno de estos comandos desde la raíz del proyecto:

**Opción A: Script de Windows (recomendado)**
```batch
configurar_bd.bat
```

**Opción B: Manualmente**
```powershell
# Activar entorno virtual
.\venv\Scripts\Activate.ps1

# Ir a backend
cd backend

# Ejecutar script de configuración
python setup_db.py
```

### 3. Proporcionar información de MySQL

Cuando se ejecute el script, te pedirá:
- **Host**: Generalmente `localhost`
- **Puerto**: Generalmente `3306`
- **Base de datos**: El nombre de la base de datos (por defecto: `sgri`)
- **Usuario MySQL**: Tu usuario de MySQL (generalmente `root`)
- **Contraseña MySQL**: Tu contraseña de MySQL

### 4. El script creará automáticamente:

- El archivo `.env` con la configuración de MySQL
- Todas las tablas necesarias en la base de datos
- Datos iniciales (roles, usuarios, niveles de probabilidad/impacto/riesgo)

## Estructura de Modelos

El archivo `backend/app/models.py` contiene todos los modelos consolidados:

### Modelos de Autenticación
- `Rol` - Roles del sistema
- `UsuarioAuth` - Usuarios de autenticación
- `SesionUsuario` - Sesiones de usuario

### Modelos Principales
- `UsuarioSistema` - Usuarios del sistema
- `Activo` - Activos de información
- `Riesgo` - Riesgos identificados
- `RiesgoActivo` - Relación entre riesgos y activos
- `Incidente` - Incidentes de seguridad

### Modelos de Evaluación
- `niveles_probabilidad` - Niveles de probabilidad
- `niveles_impacto` - Niveles de impacto
- `controles_seguridad` - Controles de seguridad
- `nivelesriesgo` - Niveles de riesgo
- `evaluacion_riesgo_activo` - Evaluaciones de riesgo por activo

### Modelos de Documentos
- `DocumentoAdjunto` - Documentos adjuntos

## Usuario Inicial

Después de la configuración, se crea un usuario administrador:
- **Username**: `admin`
- **Password**: `admin123`

⚠️ **IMPORTANTE**: Cambia esta contraseña después de la primera configuración.

## Verificar la Configuración

Para verificar que todo está funcionando:

```powershell
# Activar entorno virtual
.\venv\Scripts\Activate.ps1

# Ir a backend
cd backend

# Ejecutar el servidor
python run.py
```

Si el servidor inicia sin errores, la configuración es correcta.

## Solución de Problemas

### Error: "No se puede conectar a MySQL"
- Verifica que el servicio MySQL esté ejecutándose
- Verifica que el usuario y contraseña sean correctos
- Verifica que el host y puerto sean correctos

### Error: "Access denied"
- Verifica que el usuario tenga permisos para crear bases de datos y tablas
- Puede ser necesario crear la base de datos manualmente primero

### Error: "Module not found"
- Asegúrate de haber activado el entorno virtual
- Ejecuta: `pip install -r backend/requirements.txt`

## Archivos Importantes

- `backend/app/models.py` - Todos los modelos de la base de datos
- `backend/app/config.py` - Configuración de la aplicación (usa MySQL)
- `.env` - Variables de entorno con credenciales de MySQL (NO subir a git)
- `backend/setup_db.py` - Script de configuración e inicialización



