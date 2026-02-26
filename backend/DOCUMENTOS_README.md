# Gestión de Documentos Adjuntos - SGRI

## Descripción
Sistema de gestión de documentos adjuntos para el plan de acción de evaluaciones de riesgo. Permite adjuntar, visualizar, descargar y eliminar documentos de evidencia para cada acción del plan.

## Arquitectura

### Frontend
- **Servicio**: `frontend/src/services/documentos.ts`
- **Componente**: `frontend/src/components/common/DocumentManager.tsx`
- **Tipos**: `frontend/src/types/index.ts`

### Backend
- **Modelo**: `backend/app/models/documentos.py`
- **Rutas**: `backend/app/routes/documentos.py`
- **Configuración**: `backend/app/config.py`

## Funcionalidades

### 1. Subida de Documentos
- **Endpoint**: `POST /api/documentos/subir`
- **Tipos permitidos**: PDF, Word, Excel, PowerPoint, imágenes, texto, archivos comprimidos
- **Tamaño máximo**: 10MB
- **Validaciones**: Tipo de archivo, tamaño, nombre seguro

### 2. Consulta de Documentos
- **Endpoint**: `GET /api/documentos/accion/{accion_id}`
- **Retorna**: Lista de documentos asociados a una acción

### 3. Descarga de Documentos
- **Endpoint**: `GET /api/documentos/descargar/{documento_id}`
- **Funcionalidad**: Descarga el archivo original con su nombre

### 4. Eliminación de Documentos
- **Endpoint**: `DELETE /api/documentos/{documento_id}`
- **Seguridad**: Solo el usuario que subió puede eliminar

### 5. Información de Documento
- **Endpoint**: `GET /api/documentos/info/{documento_id}`
- **Retorna**: Metadatos del documento

## Estructura de Base de Datos

### Tabla: documentos_adjuntos
```sql
CREATE TABLE documentos_adjuntos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    accion_id VARCHAR(50) NOT NULL,
    nombre_original VARCHAR(255) NOT NULL,
    nombre_archivo VARCHAR(255) NOT NULL UNIQUE,
    tipo_mime VARCHAR(100) NOT NULL,
    tamaño_bytes BIGINT NOT NULL,
    ruta_archivo VARCHAR(500) NOT NULL,
    descripcion TEXT,
    fecha_subida DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    subido_por INT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (subido_por) REFERENCES usuarios_auth(id_usuario_auth)
);
```

## Configuración

### Variables de Entorno
```env
# Configuración de archivos
UPLOAD_FOLDER=/path/to/uploads
MAX_CONTENT_LENGTH=10485760  # 10MB
```

### Estructura de Directorios
```
backend/
├── uploads/
│   └── documentos/
│       ├── uuid1.pdf
│       ├── uuid2.docx
│       └── ...
```

## Uso en el Frontend

### 1. Importar el servicio
```typescript
import { documentosService } from '../services/documentos';
```

### 2. Usar el componente DocumentManager
```tsx
<DocumentManager
  accionId={accion.id}
  documentos={accion.documentos}
  onDocumentosChange={(docs) => setDocumentos(docs)}
  disabled={false}
/>
```

### 3. Subir un documento
```typescript
const handleFileUpload = async (file: File, accionId: string) => {
  try {
    const documento = await documentosService.subirDocumento(file, accionId, 'Descripción');
    console.log('Documento subido:', documento);
  } catch (error) {
    console.error('Error:', error);
  }
};
```

## Seguridad

### Validaciones
- **Tipos de archivo**: Solo extensiones permitidas
- **Tamaño**: Máximo 10MB por archivo
- **Nombres**: Sanitización con `secure_filename`
- **Autenticación**: Token requerido para todas las operaciones

### Permisos
- **Subir**: Usuario autenticado
- **Ver**: Usuario autenticado
- **Descargar**: Usuario autenticado
- **Eliminar**: Solo el usuario que subió el archivo

## Instalación

### 1. Crear la tabla
```bash
cd backend
python create_documentos_table.py
```

### 2. Crear directorio de uploads
```bash
mkdir -p uploads/documentos
chmod 755 uploads/documentos
```

### 3. Configurar variables de entorno
```bash
# En .env
UPLOAD_FOLDER=/path/to/backend/uploads
```

## API Endpoints

| Método | Endpoint | Descripción | Autenticación |
|--------|----------|-------------|---------------|
| POST | `/api/documentos/subir` | Subir documento | ✅ |
| GET | `/api/documentos/accion/{id}` | Obtener documentos de acción | ✅ |
| GET | `/api/documentos/descargar/{id}` | Descargar documento | ✅ |
| DELETE | `/api/documentos/{id}` | Eliminar documento | ✅ |
| GET | `/api/documentos/info/{id}` | Información del documento | ✅ |

## Ejemplos de Uso

### Subir documento con descripción
```javascript
const formData = new FormData();
formData.append('archivo', file);
formData.append('accionId', 'accion123');
formData.append('descripcion', 'Manual de implementación');

const response = await fetch('/api/documentos/subir', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`
  },
  body: formData
});
```

### Obtener documentos de una acción
```javascript
const response = await fetch('/api/documentos/accion/accion123', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
});
const documentos = await response.json();
```

## Monitoreo y Logs

### Logs importantes
- Subida exitosa de documentos
- Errores de validación
- Intentos de acceso no autorizado
- Eliminación de archivos

### Métricas recomendadas
- Número de documentos por acción
- Tamaño total de almacenamiento
- Tipos de archivos más comunes
- Actividad de usuarios

## Mantenimiento

### Limpieza de archivos
- Los archivos se marcan como inactivos (soft delete)
- Implementar limpieza periódica de archivos huérfanos
- Backup regular de la carpeta de uploads

### Optimizaciones
- Compresión de imágenes
- CDN para archivos grandes
- Cache de metadatos
- Índices en base de datos









