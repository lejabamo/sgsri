# 📋 Guía Paso a Paso: Evaluación de Riesgos de un Activo

Esta guía te ayudará a completar una evaluación completa de riesgos usando el Wizard de Evaluación del sistema SGRI.

## 🎯 Objetivo
Realizar una evaluación completa de riesgos para un activo existente, incluyendo:
- Identificación del riesgo
- Evaluación inherente
- Selección de controles
- Evaluación residual
- Opciones de tratamiento
- Plan de acción

---

## 📍 Paso 1: Acceder al Wizard

1. **Inicia sesión** en el sistema con:
   - Usuario: `admin`
   - Contraseña: `admin123`

2. **Navega al Wizard**:
   - En el menú lateral, busca la opción **"Wizard de Evaluación"** o **"Evaluación de Riesgos"**
   - O accede directamente a: `http://localhost:5173/wizard`

---

## 📍 Paso 2: Selección de Activo (Paso 1 del Wizard)

1. **Buscar un activo existente**:
   - En el campo de búsqueda, escribe parte del nombre de un activo
   - Ejemplos de activos disponibles (de los datos de prueba):
     - "Servidor de Base de Datos Principal"
     - "Sistema de Gestión de Recursos Humanos"
     - "Firewall Perimetral"
     - "Base de Datos de Clientes"

2. **Seleccionar el activo**:
   - Haz clic en la tarjeta del activo que quieres evaluar
   - Verás los detalles del activo (tipo, criticidad, estado, etc.)
   - Opcional: Haz clic en el ícono de información (ℹ️) para ver más detalles

3. **Continuar**:
   - Haz clic en el botón **"Siguiente"** o **"Next"** en la parte inferior

---

## 📍 Paso 3: Identificación de Riesgo (Paso 2 del Wizard)

### 3.1 Seleccionar o Crear Amenaza

1. **Usar amenaza existente**:
   - En el campo "Amenaza", empieza a escribir
   - El sistema mostrará sugerencias automáticas basadas en el tipo de activo
   - Selecciona una amenaza de la lista (ej: "Ataque de ransomware", "Fallo de hardware")

2. **O crear nueva amenaza**:
   - Escribe el nombre de la amenaza directamente
   - Ejemplo: "Pérdida de datos por fallo en sistema de backup"

### 3.2 Seleccionar o Crear Vulnerabilidad

1. **Usar vulnerabilidad existente**:
   - En el campo "Vulnerabilidad", empieza a escribir
   - Selecciona una vulnerabilidad de las sugerencias
   - Ejemplo: "Falta de redundancia en backups"

2. **O crear nueva vulnerabilidad**:
   - Escribe el nombre de la vulnerabilidad
   - Ejemplo: "Configuración incorrecta de permisos"

### 3.3 Completar Información del Riesgo

1. **Tipo de Riesgo**:
   - Selecciona el tipo de riesgo del dropdown:
     - **Seguridad**: Para riesgos relacionados con accesos no autorizados, ataques, etc.
     - **Técnico**: Para fallos de sistemas, hardware, software
     - **Operacional**: Para interrupciones de servicio, errores humanos

2. **Descripción del Riesgo**:
   - Escribe una descripción detallada del riesgo
   - Ejemplo: "Riesgo de pérdida permanente de datos críticos debido a fallos en el sistema de respaldo o errores en los procesos de backup. Esto podría resultar en interrupción de operaciones, impacto financiero y reputacional."

3. **Verificar información**:
   - Revisa que todos los campos estén completos
   - El sistema validará que tengas al menos amenaza y vulnerabilidad

4. **Continuar**:
   - Haz clic en **"Siguiente"**

---

## 📍 Paso 4: Evaluación Inherente (Paso 3 del Wizard)

### 4.1 Seleccionar Probabilidad

1. **Usar el slider o dropdown**:
   - Mueve el slider de "Probabilidad" o selecciona del dropdown
   - Opciones disponibles:
     - **Muy Baja** (1)
     - **Baja** (2)
     - **Media** (3)
     - **Alta** (4)
     - **Muy Alta** (5)

2. **Recomendación**: Para probar, selecciona **"Media" (3)** o **"Alta" (4)**

### 4.2 Seleccionar Impacto

1. **Usar el slider o dropdown**:
   - Mueve el slider de "Impacto" o selecciona del dropdown
   - Opciones disponibles:
     - **Muy Bajo** (1)
     - **Bajo** (2)
     - **Medio** (3)
     - **Alto** (4)
     - **Muy Alto** (5)

2. **Recomendación**: Para probar, selecciona **"Alto" (4)** o **"Muy Alto" (5)**

### 4.3 Ver Nivel de Riesgo Calculado

- El sistema calculará automáticamente el **Nivel de Riesgo Inherente**
- Se mostrará en la tarjeta de resumen:
  - **Alto**: Si probabilidad × impacto ≥ 16
  - **Medio**: Si probabilidad × impacto está entre 9-15
  - **Bajo**: Si probabilidad × impacto ≤ 8

### 4.4 Justificar la Evaluación

1. **Ver sugerencias ISO**:
   - En el panel derecho, verás **"Justificaciones ISO 27005"**
   - Si hay controles seleccionados previamente, aparecerán sugerencias automáticas
   - Haz clic en las sugerencias para agregarlas a tu justificación

2. **Escribir justificación**:
   - En el campo de texto grande, escribe tu justificación
   - Ejemplo: "La probabilidad es Media porque aunque tenemos backups automatizados, existe la posibilidad de fallos en el proceso. El impacto es Alto porque la pérdida de datos críticos afectaría directamente las operaciones del negocio y podría resultar en pérdidas financieras significativas."

3. **Usar sugerencias ISO**:
   - Haz clic en las tarjetas de sugerencias ISO para agregarlas automáticamente
   - Puedes editar o complementar el texto después

4. **Continuar**:
   - Haz clic en **"Siguiente"**

---

## 📍 Paso 5: Controles Existentes (Paso 4 del Wizard)

### 5.1 Buscar y Seleccionar Controles

1. **Buscar controles**:
   - En el campo de búsqueda, escribe parte del nombre de un control
   - El sistema mostrará controles disponibles de la base de datos
   - Ejemplos de controles disponibles (de los datos de prueba):
     - "Backup Automatizado Diario"
     - "Firewall de Próxima Generación"
     - "Autenticación Multifactor (MFA)"
     - "Monitoreo Continuo de Seguridad"

2. **Seleccionar controles**:
   - Haz clic en los controles que quieres seleccionar
   - Los controles seleccionados aparecerán como "chips" (etiquetas) debajo
   - **Recomendación**: Selecciona al menos 2-3 controles para probar

3. **Agregar control manualmente** (opcional):
   - Si no encuentras el control que necesitas, puedes agregarlo manualmente
   - Haz clic en **"Agregar control manualmente"**
   - Escribe el nombre del control
   - Presiona Enter o haz clic en "Agregar"

### 5.2 Evaluar Eficacia de Controles

1. **Seleccionar eficacia**:
   - En el dropdown "Eficacia de los Controles", selecciona:
     - **Alta**: Los controles son muy efectivos
     - **Media**: Los controles son moderadamente efectivos
     - **Baja**: Los controles tienen efectividad limitada

2. **Justificar eficacia** (opcional):
   - Escribe una justificación sobre por qué los controles tienen esa eficacia
   - Ejemplo: "Los controles implementados han demostrado alta eficacia en pruebas periódicas y auditorías. El sistema de backup automatizado se ejecuta correctamente y se verifica semanalmente."

3. **Continuar**:
   - Haz clic en **"Siguiente"**

---

## 📍 Paso 6: Evaluación Residual (Paso 5 del Wizard)

### 6.1 Seleccionar Probabilidad Residual

1. **Considerar los controles**:
   - La probabilidad residual debería ser **menor o igual** a la inherente
   - Si los controles son efectivos, la probabilidad debería reducirse

2. **Seleccionar probabilidad**:
   - Usa el dropdown "Probabilidad Residual"
   - **Recomendación**: Si la inherente era "Media" (3), selecciona "Baja" (2) o "Media" (3)

### 6.2 Seleccionar Impacto Residual

1. **Considerar los controles**:
   - El impacto residual también debería ser **menor o igual** al inherente
   - Los controles de mitigación reducen el impacto

2. **Seleccionar impacto**:
   - Usa el dropdown "Impacto Residual"
   - **Recomendación**: Si la inherente era "Alto" (4), selecciona "Medio" (3) o "Alto" (4)

### 6.3 Ver Nivel de Riesgo Residual

- El sistema calculará automáticamente el **Nivel de Riesgo Residual**
- Debería ser **menor o igual** al riesgo inherente
- Se mostrará en la tarjeta de resumen

### 6.4 Justificar la Evaluación Residual

1. **Ver sugerencias ISO**:
   - En el panel derecho, verás **"Justificaciones ISO 27005"**
   - Las sugerencias aparecerán automáticamente basadas en:
     - Los controles seleccionados
     - La diferencia entre riesgo inherente y residual
     - La normativa ISO 27005

2. **Usar sugerencias**:
   - Haz clic en las tarjetas de sugerencias para agregarlas
   - Las sugerencias explican cómo los controles redujeron el riesgo
   - Ejemplo de sugerencia: "Reducción del Nivel de Riesgo - El nivel de riesgo se ha reducido de Alto a Medio gracias a los controles implementados..."

3. **Escribir justificación**:
   - En el campo de texto, escribe o complementa la justificación
   - Ejemplo: "Los controles de backup automatizado y monitoreo continuo han reducido la probabilidad de pérdida de datos. El impacto se mantiene alto pero con mejores mecanismos de recuperación."

4. **Verificar coherencia**:
   - Asegúrate de que la justificación explique por qué el riesgo residual es menor
   - Menciona los controles específicos que contribuyeron a la reducción

5. **Continuar**:
   - Haz clic en **"Siguiente"**

---

## 📍 Paso 7: Opciones de Tratamiento (Paso 6 del Wizard)

### 7.1 Seleccionar Opción de Tratamiento

1. **Elegir opción**:
   - Selecciona una opción del dropdown:
     - **Mitigar**: Implementar controles adicionales para reducir el riesgo
     - **Aceptar**: Aceptar el riesgo residual como está
     - **Transferir**: Transferir el riesgo (ej: mediante seguro)
     - **Evitar**: Evitar el riesgo eliminando la actividad o activo

2. **Recomendación**: Selecciona **"Mitigar"** para probar el plan de acción

### 7.2 Asignar Responsable

1. **Seleccionar responsable**:
   - En el campo "Responsable", selecciona un usuario del sistema
   - O escribe el nombre del responsable
   - Ejemplo: "María González" o "Equipo de TI"

### 7.3 Fechas de Implementación

1. **Fecha de inicio**:
   - Selecciona la fecha de inicio del tratamiento
   - Usa el selector de fecha

2. **Fecha de fin**:
   - Selecciona la fecha estimada de finalización
   - Debe ser posterior a la fecha de inicio

### 7.4 Presupuesto (opcional)

1. **Ingresar presupuesto**:
   - En el campo "Presupuesto", ingresa el monto estimado
   - Ejemplo: "50000" (en la moneda configurada)

2. **Continuar**:
   - Haz clic en **"Siguiente"**

---

## 📍 Paso 8: Plan de Acción (Paso 7 del Wizard)

### 8.1 Agregar Acciones

1. **Crear nueva acción**:
   - Haz clic en el botón **"Agregar Acción"** o **"+"**
   - Se abrirá un formulario para crear una acción

2. **Completar información de la acción**:
   - **Descripción**: Describe la acción a realizar
     - Ejemplo: "Implementar sistema de backup redundante en ubicación secundaria"
   - **Responsable**: Selecciona o escribe el responsable
   - **Fecha de inicio**: Selecciona la fecha
   - **Fecha de fin**: Selecciona la fecha
   - **Estado**: Selecciona el estado inicial (generalmente "Pendiente")
   - **Prioridad**: Selecciona la prioridad (Alta, Media, Baja)

3. **Guardar acción**:
   - Haz clic en **"Guardar"** o **"Agregar"**
   - La acción aparecerá en la lista

4. **Agregar más acciones** (recomendado):
   - Agrega al menos 2-3 acciones para probar
   - Ejemplos:
     - "Realizar auditoría de configuración de backups"
     - "Capacitar al personal en procedimientos de recuperación"
     - "Implementar monitoreo automatizado de integridad de backups"

### 8.2 Gestionar Acciones

1. **Editar acción**:
   - Haz clic en el ícono de editar (✏️) junto a una acción
   - Modifica la información
   - Guarda los cambios

2. **Eliminar acción**:
   - Haz clic en el ícono de eliminar (🗑️) junto a una acción
   - Confirma la eliminación

3. **Continuar**:
   - Haz clic en **"Siguiente"**

---

## 📍 Paso 9: Resultados Finales (Paso 8 del Wizard)

### 9.1 Revisar Resumen

1. **Ver resumen completo**:
   - El sistema mostrará un resumen de toda la evaluación:
     - Activo seleccionado
     - Riesgo identificado
     - Evaluación inherente
     - Controles seleccionados
     - Evaluación residual
     - Opciones de tratamiento
     - Plan de acción

2. **Ver matriz de riesgos**:
   - Se mostrará una matriz visual con:
     - Riesgo inherente (posición original)
     - Riesgo residual (posición después de controles)
     - Comparación visual del cambio

### 9.2 Exportar o Guardar

1. **Exportar a PDF**:
   - Haz clic en el botón **"Exportar PDF"**
   - Se generará un documento PDF con toda la evaluación
   - Se descargará automáticamente

2. **Exportar a Excel**:
   - Haz clic en el botón **"Exportar Excel"**
   - Se generará un archivo Excel con los datos
   - Se descargará automáticamente

3. **Guardar evaluación**:
   - Haz clic en el botón **"Guardar Evaluación"**
   - La evaluación se guardará en la base de datos
   - Verás un mensaje de confirmación

### 9.3 Finalizar

1. **Verificar que todo esté correcto**:
   - Revisa todos los datos del resumen
   - Asegúrate de que la evaluación esté completa

2. **Guardar y finalizar**:
   - Haz clic en **"Guardar y Finalizar"**
   - La evaluación quedará registrada en el sistema
   - Podrás verla después en el módulo de evaluaciones

---

## ✅ Checklist de Verificación

Antes de finalizar, verifica que tengas:

- [ ] Activo seleccionado
- [ ] Amenaza identificada
- [ ] Vulnerabilidad identificada
- [ ] Tipo de riesgo seleccionado
- [ ] Descripción del riesgo completa
- [ ] Probabilidad inherente seleccionada
- [ ] Impacto inherente seleccionado
- [ ] Justificación inherente escrita
- [ ] Al menos 1 control seleccionado
- [ ] Eficacia de controles evaluada
- [ ] Probabilidad residual seleccionada
- [ ] Impacto residual seleccionado
- [ ] Justificación residual escrita
- [ ] Opción de tratamiento seleccionada
- [ ] Responsable asignado
- [ ] Fechas de tratamiento definidas
- [ ] Al menos 1 acción en el plan de acción

---

## 🎓 Consejos para una Buena Evaluación

1. **Sé específico**: Usa descripciones detalladas en lugar de genéricas
2. **Justifica tus decisiones**: Explica por qué seleccionaste cada nivel
3. **Usa las sugerencias ISO**: Aprovecha las sugerencias automáticas basadas en normativa
4. **Mantén coherencia**: El riesgo residual debe ser menor o igual al inherente
5. **Plan de acción realista**: Define acciones alcanzables con fechas realistas
6. **Revisa antes de guardar**: Verifica toda la información antes de finalizar

---

## 🐛 Solución de Problemas

### No aparecen sugerencias ISO en el paso 5
- **Solución**: Asegúrate de haber seleccionado controles en el paso 4
- Verifica que hayas completado probabilidad e impacto residual

### No puedo avanzar al siguiente paso
- **Solución**: Revisa que todos los campos obligatorios estén completos
- El sistema mostrará mensajes de error indicando qué falta

### No aparecen activos en la búsqueda
- **Solución**: Verifica que los datos de prueba estén cargados
- Ejecuta: `python backend/cargar_datos_prueba.py`

### El nivel de riesgo no se calcula
- **Solución**: Asegúrate de haber seleccionado tanto probabilidad como impacto
- El cálculo es automático: probabilidad × impacto

---

## 📞 Próximos Pasos

Después de completar la evaluación:

1. **Ver la evaluación guardada**: Ve al módulo de evaluaciones para ver tu evaluación
2. **Editar si es necesario**: Puedes editar la evaluación desde el módulo correspondiente
3. **Generar reportes**: Usa el módulo de reportes para generar informes de riesgos
4. **Monitorear el plan de acción**: Revisa periódicamente el estado de las acciones

---

¡Feliz evaluación! 🎉
