# Changelog - Versión Estable

## [Versión Actual] - 2025-01-XX

### ✨ Nuevas Funcionalidades

- **Visualización de Documentos**: Los documentos adjuntos ahora se muestran completamente en el resumen final con URLs funcionales
- **Ventana Emergente para Documentos**: Los documentos se pueden ver y descargar en ventana emergente
- **Autocomplete Dinámico**: Amenazas y vulnerabilidades con autocomplete que permite crear nuevas entradas si no existen
- **Justificaciones Residuales Mejoradas**: Generación automática de justificaciones basadas en controles reales de BD con códigos ISO 27005/27002
- **Sugerencias Basadas en Datos Reales**: Todas las sugerencias ahora vienen de la base de datos (cero hardcoding)

### 🔧 Mejoras

- **Paso 2 del Wizard Mejorado**:
  - Banner claro mostrando el activo que se está evaluando
  - Pre-llenado automático de detalles de riesgo al seleccionar o crear uno
  - Resumen visual del riesgo identificado
  - Sugerencias interactivas más descriptivas y contextuales

- **Gestión de Documentos**:
  - Subida automática de documentos al guardar acciones
  - URLs funcionales para ver y descargar documentos
  - Visualización mejorada en el plan de acción y resumen final

- **Base de Datos**:
  - Campo `Nombre` de riesgos cambiado a TEXT para permitir textos largos
  - Endpoint para alterar tabla automáticamente

### 🐛 Correcciones

- Corregido error de "Data too long for column 'Nombre'"
- Corregido error de "Unknown column 'categoria' in vulnerabilidades"
- Corregido import faltante de `AttachFileIcon`
- Mejorado manejo de URLs de documentos

### 📚 Documentación

- Agregada guía completa de despliegue en VPS (`DEPLOY.md`)
- Agregado script de despliegue automático (`deploy.sh`)
- Agregada guía rápida de configuración (`VPS_SETUP.md`)

### 🔐 Seguridad

- Autenticación requerida para descargar documentos
- Validación de tipos de archivo y tamaños
- Manejo seguro de errores en subida de documentos

## Próximos Pasos para Despliegue

1. Ejecutar script SQL para alterar tabla `riesgos` (ver `backend/alter_riesgos_table_fixed.sql`)
2. Configurar variables de entorno en `.env`
3. Ejecutar `./deploy.sh` en el VPS
4. Configurar servicio systemd para backend
5. Configurar Nginx para servir frontend y proxy de API

