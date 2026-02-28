# 🚀 GitHub Pages - Rama launch01

## ✅ Estado Actual

**Rama creada:** `launch01`  
**Estructura configurada:** `/docs` (minúscula)  
**Archivos listos:**
- ✅ `docs/index.html` - Reporte principal
- ✅ `docs/assets/AuditorIA_Smart_Context_Diagram.jpg` - Imagen del diagrama
- ✅ `docs/.nojekyll` - Configuración
- ✅ `.github/workflows/pages.yml` - Workflow automático

**Repositorio:** https://github.com/lejabamo/sgsri  
**Rama:** `launch01`

## 🔧 Habilitar GitHub Pages

### Paso 1: Ir a la Configuración

1. Abre tu repositorio: **https://github.com/lejabamo/sgsri**
2. Haz clic en **Settings** (Configuración)
3. O ve directamente a: **https://github.com/lejabamo/sgsri/settings/pages**

### Paso 2: Configurar la Fuente

En la sección **Source** (Fuente):

1. **Branch (Rama):**
   - Selecciona: `launch01`
   
2. **Folder (Carpeta):**
   - Selecciona: `/docs` (minúscula)

3. Haz clic en **Save** (Guardar)

### Paso 3: Esperar el Despliegue

- GitHub procesará el sitio (1-2 minutos)
- Verás un mensaje verde: **"Your site is live at..."**
- El sitio estará disponible en: **https://lejabamo.github.io/sgsri/**

## 📋 Verificación

Una vez habilitado, verifica:

1. ✅ El sitio carga: https://lejabamo.github.io/sgsri/
2. ✅ Los diagramas Mermaid se renderizan correctamente
3. ✅ Las imágenes se muestran
4. ✅ El botón "Exportar a PDF" funciona

## 🔄 Actualizaciones Futuras

Para actualizar el sitio:

```powershell
# Hacer cambios en docs/
git add docs/
git commit -m "Actualizar reporte"
git push origin launch01
```

GitHub Pages se actualizará automáticamente en 1-2 minutos.

## 🎯 Workflow Automático

El workflow `.github/workflows/pages.yml` está configurado para:
- Ejecutarse automáticamente cuando hay cambios en `docs/**`
- Desplegarse desde la rama `launch01`
- Actualizar GitHub Pages automáticamente

Puedes ver el estado en: **https://github.com/lejabamo/sgsri/actions**

## 📞 Enlaces Útiles

- **Repositorio:** https://github.com/lejabamo/sgsri
- **Rama launch01:** https://github.com/lejabamo/sgsri/tree/launch01
- **Settings:** https://github.com/lejabamo/sgsri/settings
- **Pages Config:** https://github.com/lejabamo/sgsri/settings/pages
- **Actions:** https://github.com/lejabamo/sgsri/actions
- **Sitio (después de habilitar):** https://lejabamo.github.io/sgsri/

## 🐛 Solución de Problemas

### El sitio no aparece
- Espera 2-3 minutos después de habilitar Pages
- Verifica que la carpeta sea `/docs` (minúscula)
- Revisa la pestaña "Actions" para ver si hay errores

### Los diagramas no se muestran
- Verifica tu conexión a internet (Mermaid se carga desde CDN)
- Abre la consola del navegador (F12) para ver errores
- Asegúrate de usar un navegador moderno

### Error 404
- Verifica que el archivo se llame exactamente `index.html`
- Confirma que esté en la carpeta `/docs`
- Revisa la configuración de GitHub Pages

---

**¡Listo!** Solo falta habilitar GitHub Pages desde la interfaz web y tu sitio estará en línea. 🎉

