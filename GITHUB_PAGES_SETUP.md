# 🚀 Guía de Configuración de GitHub Pages

Esta guía te ayudará a publicar el reporte del Smart Context Diagram en GitHub Pages.

## 📦 Archivos Preparados

✅ **Carpeta `/docs`** creada con:
- `index.html` - Reporte principal
- `assets/` - Recursos estáticos (imágenes)

✅ **Workflow de GitHub Actions** configurado en:
- `.github/workflows/pages.yml`

## 🔧 Pasos para Publicar

### Paso 1: Subir los Archivos a GitHub

```powershell
# Agregar los archivos nuevos
git add docs/
git add .github/workflows/pages.yml
git add GITHUB_PAGES_SETUP.md

# Hacer commit
git commit -m "feat: Agregar reporte Smart Context Diagram para GitHub Pages"

# Subir a GitHub
git push origin evaluation
```

### Paso 2: Habilitar GitHub Pages (Método Manual)

1. **Ve a tu repositorio en GitHub**
   - URL: `https://github.com/TU_USUARIO/sgsri` (o tu repositorio)

2. **Abre la configuración**
   - Haz clic en **Settings** (Configuración)
   - En el menú lateral izquierdo, busca **Pages**

3. **Configura la fuente**
   - En **Source**, selecciona:
     - **Branch**: `evaluation` (o tu rama principal)
     - **Folder**: `/docs`
   - Haz clic en **Save** (Guardar)

4. **Espera el despliegue**
   - GitHub procesará el sitio (1-2 minutos)
   - Verás un mensaje: "Your site is live at..."

5. **Accede a tu sitio**
   - URL: `https://TU_USUARIO.github.io/sgsri/`
   - O: `https://TU_USUARIO.github.io/TU_REPOSITORIO/`

### Paso 3: Verificar el Sitio

- Abre la URL en tu navegador
- Verifica que los diagramas Mermaid se rendericen correctamente
- Prueba el botón "Exportar a PDF"

## 🔄 Actualizaciones Automáticas

Una vez configurado, cada vez que hagas `git push` a la rama `evaluation` con cambios en `/docs`, GitHub Pages se actualizará automáticamente.

## 🎨 Características del Sitio

- ✅ Diagramas Mermaid interactivos (renderizado vectorial)
- ✅ Diseño responsivo
- ✅ Exportación a PDF integrada
- ✅ Estilos profesionales con Tailwind CSS
- ✅ Compatible con todos los navegadores modernos

## 🐛 Solución de Problemas

### El sitio no se actualiza
- Espera 2-3 minutos después del push
- Verifica que los archivos estén en `/docs`
- Revisa la pestaña "Actions" en GitHub para ver si hay errores

### Los diagramas no se muestran
- Verifica que tengas conexión a internet (Mermaid se carga desde CDN)
- Abre la consola del navegador (F12) para ver errores
- Asegúrate de que el navegador sea moderno (Chrome, Firefox, Edge)

### Error 404
- Verifica que el archivo se llame exactamente `index.html`
- Confirma que esté en la carpeta `/docs`
- Revisa la configuración de GitHub Pages (debe apuntar a `/docs`)

## 📚 Recursos Adicionales

- [Documentación de GitHub Pages](https://docs.github.com/en/pages)
- [Mermaid.js Documentation](https://mermaid.js.org/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)

## ✨ Próximos Pasos

1. Personaliza el contenido si es necesario
2. Agrega más secciones al reporte
3. Comparte la URL con tu equipo o profesores
4. Usa el botón "Exportar a PDF" para generar documentos

---

**Nota**: Si tu repositorio es privado, GitHub Pages también funcionará, pero solo los colaboradores podrán acceder al sitio.

