# SGRI API Documentation

## Base URL
```
http://localhost:5000/api
```

## Endpoints

### Health Check
- **GET** `/health`
- **Descripción**: Verificar el estado del servidor
- **Respuesta**: `{"status": "ok", "message": "SGRI API is running"}`

## Activos

### Obtener todos los activos
- **GET** `/activos/`
- **Parámetros de consulta**:
  - `tipo_activo` (opcional): Filtrar por tipo de activo
  - `estado` (opcional): Filtrar por estado
  - `nivel_criticidad` (opcional): Filtrar por nivel de criticidad
- **Respuesta**: Lista de activos

### Obtener un activo específico
- **GET** `/activos/{activo_id}`
- **Respuesta**: Detalles del activo

### Crear un nuevo activo
- **POST** `/activos/`
- **Body**:
```json
{
  "Nombre": "Servidor Web Principal",
  "Descripcion": "Servidor web para la aplicación principal",
  "Tipo_Activo": "Infraestructura",
  "subtipo_activo": "Servidor",
  "ID_Propietario": 1,
  "ID_Custodio": 2,
  "Nivel_Clasificacion_Confidencialidad": "Uso Interno",
  "Nivel_Clasificacion_Integridad": "Media",
  "Nivel_Clasificacion_Disponibilidad": "Media",
  "nivel_criticidad_negocio": "Alto",
  "estado_activo": "Activo",
  "requiere_backup": true,
  "frecuencia_backup_general": "Diario",
  "tiempo_retencion_general": "30 días"
}
```

### Actualizar un activo
- **PUT** `/activos/{activo_id}`
- **Body**: Campos a actualizar

### Eliminar un activo
- **DELETE** `/activos/{activo_id}`

### Obtener tipos de activo
- **GET** `/activos/tipos`
- **Respuesta**: Lista de tipos únicos

### Obtener estados de activo
- **GET** `/activos/estados`
- **Respuesta**: Lista de estados únicos

### Obtener riesgos de un activo
- **GET** `/activos/{activo_id}/riesgos`
- **Respuesta**: Lista de riesgos asociados al activo

## Riesgos

### Obtener todos los riesgos
- **GET** `/riesgos/`
- **Parámetros de consulta**:
  - `tipo_riesgo` (opcional): Filtrar por tipo
  - `nivel_riesgo` (opcional): Filtrar por nivel
  - `estado` (opcional): Filtrar por estado

### Obtener un riesgo específico
- **GET** `/riesgos/{riesgo_id}`

### Crear un nuevo riesgo
- **POST** `/riesgos/`
- **Body**:
```json
{
  "nombre_riesgo": "Pérdida de datos",
  "descripcion": "Riesgo de pérdida de datos por fallo del sistema",
  "tipo_riesgo": "Técnico",
  "nivel_riesgo": "Alto",
  "estado": "Activo"
}
```

### Actualizar un riesgo
- **PUT** `/riesgos/{riesgo_id}`

### Eliminar un riesgo
- **DELETE** `/riesgos/{riesgo_id}`

### Obtener tipos de riesgo
- **GET** `/riesgos/tipos`

### Obtener niveles de riesgo
- **GET** `/riesgos/niveles`

### Obtener activos de un riesgo
- **GET** `/riesgos/{riesgo_id}/activos`

### Asociar riesgo a activo
- **POST** `/riesgos/{riesgo_id}/activos/{activo_id}`
- **Body**:
```json
{
  "probabilidad": 4,
  "impacto": 5,
  "medidas_mitigacion": "Implementar backup automático"
}
```

### Actualizar evaluación de riesgo
- **PUT** `/riesgos/{riesgo_id}/activos/{activo_id}`

### Desasociar riesgo de activo
- **DELETE** `/riesgos/{riesgo_id}/activos/{activo_id}`

## Incidentes

### Obtener todos los incidentes
- **GET** `/incidentes/`
- **Parámetros de consulta**:
  - `tipo_incidente` (opcional): Filtrar por tipo
  - `severidad` (opcional): Filtrar por severidad
  - `estado` (opcional): Filtrar por estado
  - `activo_id` (opcional): Filtrar por activo

### Obtener un incidente específico
- **GET** `/incidentes/{incidente_id}`

### Crear un nuevo incidente
- **POST** `/incidentes/`
- **Body**:
```json
{
  "titulo": "Caída del servidor web",
  "descripcion": "El servidor web principal no responde",
  "tipo_incidente": "Disponibilidad",
  "severidad": "Alta",
  "estado": "Abierto",
  "ID_Activo": 1,
  "responsable": "Equipo de Infraestructura",
  "acciones_correctivas": "Reiniciar servicios"
}
```

### Actualizar un incidente
- **PUT** `/incidentes/{incidente_id}`

### Eliminar un incidente
- **DELETE** `/incidentes/{incidente_id}`

### Obtener tipos de incidente
- **GET** `/incidentes/tipos`

### Obtener severidades
- **GET** `/incidentes/severidades`

### Obtener estados de incidente
- **GET** `/incidentes/estados`

### Resolver incidente
- **PUT** `/incidentes/{incidente_id}/resolver`
- **Body** (opcional):
```json
{
  "acciones_correctivas": "Servicios reiniciados exitosamente"
}
```

### Obtener estadísticas de incidentes
- **GET** `/incidentes/estadisticas`

## Usuarios

### Obtener todos los usuarios
- **GET** `/usuarios/`
- **Parámetros de consulta**:
  - `departamento` (opcional): Filtrar por departamento
  - `rol` (opcional): Filtrar por rol

### Obtener un usuario específico
- **GET** `/usuarios/{usuario_id}`

### Crear un nuevo usuario
- **POST** `/usuarios/`
- **Body**:
```json
{
  "nombre": "Juan Pérez",
  "email": "juan.perez@empresa.com",
  "departamento": "TI",
  "rol": "Administrador"
}
```

### Actualizar un usuario
- **PUT** `/usuarios/{usuario_id}`

### Eliminar un usuario
- **DELETE** `/usuarios/{usuario_id}`

### Obtener departamentos
- **GET** `/usuarios/departamentos`

### Obtener roles
- **GET** `/usuarios/roles`

### Obtener activos de un usuario
- **GET** `/usuarios/{usuario_id}/activos`

### Obtener estadísticas de usuarios
- **GET** `/usuarios/estadisticas`

## Dashboard

### Obtener resumen general
- **GET** `/dashboard/resumen`
- **Respuesta**: Contadores y estadísticas generales

### Obtener actividad reciente
- **GET** `/dashboard/actividad-reciente`
- **Respuesta**: Últimos activos, incidentes y usuarios

### Obtener riesgos altos
- **GET** `/dashboard/riesgos-altos`
- **Respuesta**: Activos con riesgos altos

### Obtener incidentes pendientes
- **GET** `/dashboard/incidentes-pendientes`
- **Respuesta**: Incidentes sin resolver

### Obtener activos críticos
- **GET** `/dashboard/activos-criticos`
- **Respuesta**: Activos con criticidad alta o crítica

### Obtener tendencias
- **GET** `/dashboard/tendencias`
- **Respuesta**: Análisis de tendencias del sistema

### Obtener alertas
- **GET** `/dashboard/alertas`
- **Respuesta**: Alertas del sistema

## Códigos de Respuesta

- **200**: OK - Operación exitosa
- **201**: Created - Recurso creado exitosamente
- **400**: Bad Request - Datos inválidos o faltantes
- **404**: Not Found - Recurso no encontrado
- **500**: Internal Server Error - Error del servidor

## Ejemplos de Uso

### Crear un activo con riesgo
```bash
# 1. Crear el activo
curl -X POST http://localhost:5000/api/activos/ \
  -H "Content-Type: application/json" \
  -d '{
    "Nombre": "Servidor de Base de Datos",
    "Descripcion": "Servidor principal de base de datos",
    "Tipo_Activo": "Infraestructura",
    "nivel_criticidad_negocio": "Crítico"
  }'

# 2. Crear el riesgo
curl -X POST http://localhost:5000/api/riesgos/ \
  -H "Content-Type: application/json" \
  -d '{
    "nombre_riesgo": "Pérdida de datos críticos",
    "descripcion": "Riesgo de pérdida de datos por fallo del servidor",
    "tipo_riesgo": "Técnico",
    "nivel_riesgo": "Alto"
  }'

# 3. Asociar riesgo al activo
curl -X POST http://localhost:5000/api/riesgos/1/activos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "probabilidad": 3,
    "impacto": 5,
    "medidas_mitigacion": "Backup automático diario y redundancia"
  }'
```

### Crear un incidente
```bash
curl -X POST http://localhost:5000/api/incidentes/ \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Interrupción del servicio",
    "descripcion": "El servidor de base de datos no responde",
    "tipo_incidente": "Disponibilidad",
    "severidad": "Crítica",
    "ID_Activo": 1,
    "responsable": "Equipo de DBA"
  }'
```

### Obtener dashboard
```bash
# Resumen general
curl http://localhost:5000/api/dashboard/resumen

# Alertas del sistema
curl http://localhost:5000/api/dashboard/alertas

# Actividad reciente
curl http://localhost:5000/api/dashboard/actividad-reciente
``` 