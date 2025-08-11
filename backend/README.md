# SGRI Backend

Backend del Sistema de Gestión de Riesgos Informáticos (SGRI) desarrollado con Flask.

## Características

- **API RESTful** completa para gestión de activos, riesgos, incidentes y usuarios
- **Base de datos SQLite/MySQL** con SQLAlchemy ORM
- **Validación de datos** y manejo de errores robusto
- **CORS habilitado** para integración con frontend
- **Documentación completa** de la API
- **Datos de ejemplo** incluidos

## Estructura del Proyecto

```
backend/
├── app/
│   ├── __init__.py          # Configuración de la aplicación Flask
│   ├── config.py            # Configuración de MySQL
│   ├── config_sqlite.py     # Configuración de SQLite
│   ├── models.py            # Modelos de datos (SQLAlchemy)
│   └── routes/              # Rutas de la API
│       ├── activos.py       # Gestión de activos
│       ├── riesgos.py       # Gestión de riesgos
│       ├── incidentes.py    # Gestión de incidentes
│       ├── usuarios.py      # Gestión de usuarios
│       └── dashboard.py     # Dashboard y estadísticas
├── run.py                   # Script para ejecutar el servidor
├── setup_database.py        # Script para configurar la base de datos
├── init_db.py              # Script para inicializar la base de datos
├── API_DOCUMENTATION.md    # Documentación completa de la API
└── README.md               # Este archivo
```

## Instalación Rápida

### 1. Requisitos Previos

- Python 3.8 o superior
- pip (gestor de paquetes de Python)

### 2. Configuración del Entorno

```bash
# Clonar el repositorio (si no lo has hecho ya)
git clone <url-del-repositorio>
cd sgsri/backend

# Crear entorno virtual
python -m venv venv

# Activar entorno virtual
# En Windows:
venv\Scripts\activate
# En macOS/Linux:
source venv/bin/activate

# Instalar dependencias
pip install -r requirements.txt
```

### 3. Configurar Base de Datos

**Opción A: Configuración Automática (Recomendada)**
```bash
python setup_database.py
```
Este script te permitirá elegir entre:
- **SQLite** (recomendado para desarrollo)
- **MySQL** (para producción)

**Opción B: Configuración Manual**

Para SQLite (recomendado para desarrollo):
```bash
# Crear archivo .env
echo "SECRET_KEY=sgri_secret_key_2024" > .env
echo "DATABASE_URL=sqlite:///sgri.db" >> .env
```

Para MySQL:
```bash
# Crear archivo .env
echo "SECRET_KEY=sgri_secret_key_2024" > .env
echo "DATABASE_URL=mysql+mysqlconnector://usuario:password@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password" >> .env
```

### 4. Inicializar Base de Datos

```bash
python init_db.py
```

### 5. Ejecutar el Servidor

```bash
python run.py
```

El servidor estará disponible en `http://localhost:5000`

## Configuración de Base de Datos

### SQLite (Recomendado para Desarrollo)

**Ventajas:**
- No requiere instalación adicional
- Archivo único de base de datos
- Configuración simple
- Ideal para desarrollo y pruebas

**Configuración:**
```env
DATABASE_URL=sqlite:///sgri.db
```

### MySQL (Para Producción)

**Ventajas:**
- Mejor rendimiento para grandes volúmenes
- Características avanzadas
- Soporte para múltiples usuarios
- Ideal para producción

**Configuración:**
```env
DATABASE_URL=mysql+mysqlconnector://usuario:password@localhost/sgri_db_final_v2?auth_plugin=mysql_native_password
```

**Nota:** Para MySQL en Windows, asegúrate de:
1. Tener MySQL instalado y ejecutándose
2. Crear la base de datos: `CREATE DATABASE sgri_db_final_v2;`
3. Usar el plugin de autenticación nativo

## API Endpoints

### Health Check
- `GET /api/health` - Verificar estado del servidor

### Activos
- `GET /api/activos/` - Obtener todos los activos
- `GET /api/activos/{id}` - Obtener activo específico
- `POST /api/activos/` - Crear nuevo activo
- `PUT /api/activos/{id}` - Actualizar activo
- `DELETE /api/activos/{id}` - Eliminar activo
- `GET /api/activos/tipos` - Obtener tipos de activo
- `GET /api/activos/estados` - Obtener estados de activo
- `GET /api/activos/{id}/riesgos` - Obtener riesgos de un activo

### Riesgos
- `GET /api/riesgos/` - Obtener todos los riesgos
- `GET /api/riesgos/{id}` - Obtener riesgo específico
- `POST /api/riesgos/` - Crear nuevo riesgo
- `PUT /api/riesgos/{id}` - Actualizar riesgo
- `DELETE /api/riesgos/{id}` - Eliminar riesgo
- `GET /api/riesgos/tipos` - Obtener tipos de riesgo
- `GET /api/riesgos/niveles` - Obtener niveles de riesgo
- `GET /api/riesgos/{id}/activos` - Obtener activos de un riesgo
- `POST /api/riesgos/{id}/activos/{activo_id}` - Asociar riesgo a activo
- `PUT /api/riesgos/{id}/activos/{activo_id}` - Actualizar evaluación
- `DELETE /api/riesgos/{id}/activos/{activo_id}` - Desasociar riesgo

### Incidentes
- `GET /api/incidentes/` - Obtener todos los incidentes
- `GET /api/incidentes/{id}` - Obtener incidente específico
- `POST /api/incidentes/` - Crear nuevo incidente
- `PUT /api/incidentes/{id}` - Actualizar incidente
- `DELETE /api/incidentes/{id}` - Eliminar incidente
- `GET /api/incidentes/tipos` - Obtener tipos de incidente
- `GET /api/incidentes/severidades` - Obtener severidades
- `GET /api/incidentes/estados` - Obtener estados
- `PUT /api/incidentes/{id}/resolver` - Resolver incidente
- `GET /api/incidentes/estadisticas` - Estadísticas de incidentes

### Usuarios
- `GET /api/usuarios/` - Obtener todos los usuarios
- `GET /api/usuarios/{id}` - Obtener usuario específico
- `POST /api/usuarios/` - Crear nuevo usuario
- `PUT /api/usuarios/{id}` - Actualizar usuario
- `DELETE /api/usuarios/{id}` - Eliminar usuario
- `GET /api/usuarios/departamentos` - Obtener departamentos
- `GET /api/usuarios/roles` - Obtener roles
- `GET /api/usuarios/{id}/activos` - Obtener activos de usuario
- `GET /api/usuarios/estadisticas` - Estadísticas de usuarios

### Dashboard
- `GET /api/dashboard/resumen` - Resumen general
- `GET /api/dashboard/actividad-reciente` - Actividad reciente
- `GET /api/dashboard/riesgos-altos` - Riesgos altos
- `GET /api/dashboard/incidentes-pendientes` - Incidentes pendientes
- `GET /api/dashboard/activos-criticos` - Activos críticos
- `GET /api/dashboard/tendencias` - Tendencias del sistema
- `GET /api/dashboard/alertas` - Alertas del sistema

## Modelos de Datos

### UsuarioSistema
- `id_usuario` (PK)
- `nombre`
- `email` (único)
- `departamento`
- `rol`
- `fecha_creacion`

### Activo
- `ID_Activo` (PK)
- `Nombre`
- `Descripcion`
- `Tipo_Activo`
- `subtipo_activo`
- `ID_Propietario` (FK a UsuarioSistema)
- `ID_Custodio` (FK a UsuarioSistema)
- `Nivel_Clasificacion_Confidencialidad`
- `Nivel_Clasificacion_Integridad`
- `Nivel_Clasificacion_Disponibilidad`
- `nivel_criticidad_negocio`
- `estado_activo`
- `requiere_backup`
- `frecuencia_backup_general`
- `tiempo_retencion_general`
- `fecha_proxima_revision_sgsi`
- `fecha_creacion_registro`
- `fecha_ultima_actualizacion_sgsi`

### Riesgo
- `id_riesgo` (PK)
- `nombre_riesgo`
- `descripcion`
- `tipo_riesgo`
- `nivel_riesgo`
- `estado`
- `fecha_creacion`
- `fecha_actualizacion`

### RiesgoActivo (Tabla de relación)
- `id` (PK)
- `id_riesgo` (FK a Riesgo)
- `ID_Activo` (FK a Activo)
- `probabilidad` (1-5)
- `impacto` (1-5)
- `nivel_riesgo_calculado`
- `medidas_mitigacion`
- `fecha_evaluacion`

### Incidente
- `id_incidente` (PK)
- `titulo`
- `descripcion`
- `tipo_incidente`
- `severidad`
- `estado`
- `ID_Activo` (FK a Activo)
- `fecha_incidente`
- `fecha_resolucion`
- `responsable`
- `acciones_correctivas`

## Ejemplos de Uso

### Crear un Activo
```bash
curl -X POST http://localhost:5000/api/activos/ \
  -H "Content-Type: application/json" \
  -d '{
    "Nombre": "Servidor de Base de Datos",
    "Descripcion": "Servidor principal de base de datos",
    "Tipo_Activo": "Infraestructura",
    "nivel_criticidad_negocio": "Crítico",
    "requiere_backup": true,
    "frecuencia_backup_general": "Cada 4 horas"
  }'
```

### Crear un Riesgo
```bash
curl -X POST http://localhost:5000/api/riesgos/ \
  -H "Content-Type: application/json" \
  -d '{
    "nombre_riesgo": "Pérdida de datos críticos",
    "descripcion": "Riesgo de pérdida de datos por fallo del sistema",
    "tipo_riesgo": "Técnico",
    "nivel_riesgo": "Alto"
  }'
```

### Asociar Riesgo a Activo
```bash
curl -X POST http://localhost:5000/api/riesgos/1/activos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "probabilidad": 3,
    "impacto": 5,
    "medidas_mitigacion": "Backup automático diario"
  }'
```

### Crear un Incidente
```bash
curl -X POST http://localhost:5000/api/incidentes/ \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Caída del servidor web",
    "descripcion": "El servidor web principal no responde",
    "tipo_incidente": "Disponibilidad",
    "severidad": "Alta",
    "ID_Activo": 1,
    "responsable": "Equipo de Infraestructura"
  }'
```

### Obtener Dashboard
```bash
# Resumen general
curl http://localhost:5000/api/dashboard/resumen

# Alertas del sistema
curl http://localhost:5000/api/dashboard/alertas

# Actividad reciente
curl http://localhost:5000/api/dashboard/actividad-reciente
```

## Desarrollo

### Estructura de Desarrollo

1. **Modelos**: Definir en `app/models.py`
2. **Rutas**: Crear en `app/routes/`
3. **Configuración**: Modificar en `app/config_sqlite.py` o `app/config.py`
4. **Documentación**: Actualizar `API_DOCUMENTATION.md`

### Agregar Nuevas Funcionalidades

1. **Crear el modelo** en `app/models.py`
2. **Crear las rutas** en `app/routes/`
3. **Registrar el blueprint** en `app/__init__.py`
4. **Actualizar la documentación** en `API_DOCUMENTATION.md`

### Testing

Para probar la API, puedes usar:
- **cURL** (ejemplos incluidos arriba)
- **Postman** o **Insomnia**
- **Thunder Client** (extensión de VS Code)

## Troubleshooting

### Error de Conexión a la Base de Datos
- **SQLite**: Verificar permisos de escritura en el directorio
- **MySQL**: Verificar que MySQL esté ejecutándose y las credenciales sean correctas

### Error de Autenticación MySQL
- Usar `?auth_plugin=mysql_native_password` en la URL de conexión
- Verificar que el usuario MySQL tenga permisos adecuados

### Error de Importación
- Verificar que el entorno virtual esté activado
- Verificar que todas las dependencias estén instaladas: `pip install -r requirements.txt`

### Error de CORS
- Verificar que Flask-CORS esté instalado
- Verificar la configuración en `app/__init__.py`

## Comandos Útiles

```bash
# Configurar base de datos
python setup_database.py

# Inicializar base de datos
python init_db.py

# Ejecutar servidor
python run.py

# Instalar dependencias
pip install -r requirements.txt

# Activar entorno virtual (Windows)
venv\Scripts\activate

# Activar entorno virtual (macOS/Linux)
source venv/bin/activate
```

## Contribución

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## Contacto

Para preguntas o soporte, contactar al equipo de desarrollo. 