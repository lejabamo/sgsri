# Guía Completa: Evaluación de Riesgos con Wizard

## Objetivo
Realizar una evaluación completa de riesgos para un activo usando el wizard, asegurando que todos los datos se guarden correctamente y se reflejen en los reportes.

## Activo de Prueba
**Computador sin usuario y contraseña**
- Tipo: Hardware
- Estado: En uso
- Criticidad: Alta
- Descripción: Computador de escritorio sin protección de usuario y contraseña

---

## Paso 1: Seleccionar o Crear el Activo

### Si el activo NO existe:
1. En el wizard, hacer clic en "Crear Nuevo Activo"
2. Llenar el formulario:
   - **Nombre**: "Computador Oficina 101"
   - **Descripción**: "Computador de escritorio sin protección de usuario y contraseña, ubicado en oficina 101"
   - **Tipo**: Seleccionar "Hardware"
   - **Estado**: "En uso"
   - **Criticidad**: "Alta"
3. Guardar el activo

### Si el activo YA existe:
1. Buscar el activo en la lista
2. Seleccionarlo haciendo clic en él

---

## Paso 2: Identificar el Riesgo

### Opción A: Crear Nuevo Riesgo
1. Hacer clic en "Crear Nuevo Riesgo"
2. Llenar el formulario:
   - **Nombre**: "Pérdida de datos por acceso no autorizado"
   - **Amenaza**: "Acceso no autorizado"
   - **Vulnerabilidad**: "Falta de autenticación (sin usuario y contraseña)"
   - **Descripción**: "Riesgo de pérdida, modificación o acceso no autorizado a información confidencial debido a la falta de autenticación en el computador"
   - **Tipo de Riesgo**: "Confidencialidad"
3. Guardar el riesgo

### Opción B: Usar Riesgo Existente
1. Buscar "Pérdida de datos" en la lista
2. Seleccionarlo

---

## Paso 3: Evaluación Inherente

### Llenar los campos:
1. **Probabilidad**: 
   - Seleccionar "Alta" o "Muy Alta"
   - Justificación: "El computador está sin protección, cualquier persona puede acceder físicamente"

2. **Impacto**:
   - Seleccionar "Mayor" o "Catastrófico"
   - Justificación: "Pérdida de confidencialidad de información sensible, posible violación de datos personales"

3. **Nivel de Riesgo**: Se calcula automáticamente (debería ser "Alto")

4. **Justificación Inherente**:
   ```
   El riesgo inherente es ALTO debido a que:
   - Probabilidad ALTA: El activo está físicamente accesible sin protección
   - Impacto MAYOR: La información almacenada puede ser confidencial
   - No existen controles de seguridad implementados actualmente
   ```

5. Hacer clic en "Siguiente"

---

## Paso 4: Seleccionar Controles Existentes

### ⚠️ IMPORTANTE: Este paso es OBLIGATORIO

1. **Buscar controles en la base de datos**:
   - El sistema mostrará controles disponibles
   - Buscar: "Autenticación", "Usuario", "Contraseña", "Acceso"

2. **Seleccionar al menos UN control**:
   - Opción 1: Seleccionar control existente de la lista
   - Opción 2: Agregar control manualmente
   - Opción 3: Usar sugerencia de ISO 27001/27002

### Ejemplo de Control a Seleccionar:
- **Nombre**: "Implementar autenticación de usuario y contraseña"
- **Descripción**: "Configurar usuario y contraseña segura para acceso al sistema"
- **Categoría**: "Control de Acceso"
- **Eficacia**: "Alta"

### Si no hay controles en la BD:
1. Hacer clic en "Agregar Control Manualmente"
2. Llenar:
   - **Nombre**: "Implementar autenticación de usuario y contraseña"
   - **Descripción**: "Configurar usuario y contraseña segura para acceso al sistema operativo"
   - **Categoría**: "Control de Acceso"
   - **Tipo**: "Preventivo"
   - **Eficacia**: "Alta"
3. Guardar

### Usar Sugerencias ISO:
1. Hacer clic en "Ver Sugerencias ISO"
2. Seleccionar un control sugerido (ej: ISO 27001 A.9.4.2 - Control de acceso)
3. El control se agregará automáticamente

### ⚠️ NO PODRÁS CONTINUAR SIN SELECCIONAR AL MENOS UN CONTROL

---

## Paso 5: Evaluación Residual

### Después de aplicar controles, evaluar el riesgo residual:

1. **Probabilidad Residual**:
   - Seleccionar "Baja" o "Media"
   - Justificación: "Con autenticación implementada, el acceso no autorizado se reduce significativamente"

2. **Impacto Residual**:
   - Seleccionar "Moderado" o "Menor"
   - Justificación: "Aunque el impacto sigue siendo importante, los controles reducen la exposición"

3. **Nivel de Riesgo Residual**: Se calcula automáticamente (debería ser "Medio" o "Bajo")

4. **Justificación Residual**:
   ```
   El riesgo residual es MEDIO/BAJO debido a:
   - Probabilidad BAJA: Los controles de autenticación reducen el acceso no autorizado
   - Impacto MODERADO: La información sigue siendo valiosa pero está mejor protegida
   - Controles implementados: Autenticación de usuario y contraseña
   ```

5. Hacer clic en "Siguiente"

---

## Paso 6: Tratamiento del Riesgo

### Llenar el formulario:

1. **Opción de Tratamiento**: 
   - Seleccionar "Mitigar" (reducir el riesgo)

2. **Responsable**:
   - Escribir el nombre completo del usuario responsable
   - Ejemplo: "Juan Pérez" o el email: "juan.perez@institucion.com"

3. **Fecha de Inicio**:
   - Seleccionar fecha actual o próxima

4. **Fecha de Fin**:
   - Seleccionar fecha de finalización esperada
   - Ejemplo: 30 días después de la fecha de inicio

5. **Presupuesto** (opcional):
   - Si aplica, ingresar el costo estimado

6. Hacer clic en "Siguiente"

---

## Paso 7: Plan de Acción

### Agregar acciones específicas:

1. Hacer clic en "Agregar Acción"

2. **Acción 1: Configurar Usuario y Contraseña**
   - **Descripción**: "Configurar usuario y contraseña segura en el computador"
   - **Responsable**: "Juan Pérez" (mismo del tratamiento)
   - **Fecha Inicio**: Fecha actual
   - **Fecha Fin**: 7 días después
   - **Estado**: "Pendiente"
   - **Documentos**: 
     - Hacer clic en "Adjuntar Documento"
     - Subir: "Contrato Backup Inc.pdf" o "Procedimiento_Configuracion_Usuario.pdf"
     - ⚠️ IMPORTANTE: El documento debe subirse aquí

3. **Acción 2: Documentar Procedimiento**
   - **Descripción**: "Documentar procedimiento de configuración de usuarios"
   - **Responsable**: "Juan Pérez"
   - **Fecha Inicio**: 8 días después
   - **Fecha Fin**: 15 días después
   - **Estado**: "Pendiente"

4. Hacer clic en "Siguiente"

---

## Paso 8: Revisar y Guardar

1. **Revisar toda la información**:
   - Activo seleccionado ✓
   - Riesgo identificado ✓
   - Evaluación inherente ✓
   - Controles seleccionados ✓
   - Evaluación residual ✓
   - Tratamiento definido ✓
   - Plan de acción con documentos ✓

2. **Hacer clic en "Guardar Evaluación"**

3. **Verificar mensaje de éxito**: "Evaluación guardada exitosamente en la base de datos"

---

## Verificación Post-Evaluación

### 1. Verificar en "Activos"
- Ir a `/activos`
- Buscar el activo "Computador Oficina 101"
- Verificar que aparezca como "Evaluado"
- Verificar que muestre el riesgo asociado

### 2. Verificar en "Reportes"
- Ir a `/reportes/informe-riesgos`
- Verificar que:
  - El activo aparezca en "Activos Evaluados"
  - El riesgo aparezca con nivel "Alto" (inherente) y "Medio/Bajo" (residual)
  - Los controles aparezcan listados (NO debe decir "Sin controles")
  - Los documentos aparezcan en el plan de acción

### 3. Verificar en "Riesgos Altos"
- Ir a `/reportes/informe-riesgos`
- Hacer clic en "Ver" en la tarjeta "Riesgos Altos"
- Verificar que:
  - El riesgo aparezca en la lista
  - Muestre los controles aplicados
  - Muestre los documentos de evidencia
  - Muestre el responsable

### 4. Verificar en "Reportes de Usuarios"
- Ir a `/reportes/reporte-usuarios`
- Verificar que:
  - El usuario responsable aparezca con documentos subidos
  - Los documentos estén categorizados correctamente

---

## Problemas Comunes y Soluciones

### ❌ "Sin controles" aparece en los reportes

**Causa**: Los controles no se guardaron correctamente o no se asociaron a la evaluación.

**Solución**:
1. Verificar que en el Paso 4 se seleccionó al menos un control
2. Verificar que el control tiene `ID_Control` válido
3. Revisar la consola del navegador para errores
4. Verificar en la base de datos:
   ```sql
   SELECT * FROM riesgocontrolaplicado 
   WHERE id_evaluacion_riesgo_activo = [ID_EVALUACION];
   ```

### ❌ Los documentos no aparecen

**Causa**: Los documentos no se asociaron correctamente al plan de acción.

**Solución**:
1. Verificar que los documentos se subieron en el Paso 7
2. Verificar que el responsable existe en la base de datos
3. Verificar que el documento tiene `accion_id` correcto
4. Revisar en la base de datos:
   ```sql
   SELECT * FROM documentos_adjuntos 
   WHERE accion_id LIKE '%[ID_ACCION]%';
   ```

### ❌ El riesgo no aparece en "Riesgos Altos"

**Causa**: El nivel de riesgo no se calculó correctamente o no se guardó.

**Solución**:
1. Verificar que la evaluación inherente tiene probabilidad e impacto
2. Verificar que el nivel de riesgo se calculó (debe ser "ALTO")
3. Revisar en la base de datos:
   ```sql
   SELECT * FROM evaluacion_riesgo_activo 
   WHERE ID_Activo = [ID_ACTIVO] 
   AND ID_Riesgo = [ID_RIESGO];
   ```

---

## Checklist Final

Antes de considerar la evaluación completa, verificar:

- [ ] Activo creado/seleccionado
- [ ] Riesgo creado/seleccionado
- [ ] Evaluación inherente completada (probabilidad, impacto, justificación)
- [ ] **Al menos UN control seleccionado** (OBLIGATORIO)
- [ ] Evaluación residual completada (si aplica)
- [ ] Tratamiento definido con responsable
- [ ] Plan de acción con al menos una acción
- [ ] Documentos adjuntos en el plan de acción
- [ ] Evaluación guardada exitosamente
- [ ] Activo aparece como "Evaluado" en `/activos`
- [ ] Riesgo aparece en reportes con controles visibles
- [ ] Documentos aparecen en reportes de usuarios

---

## Notas Importantes

1. **Los controles son OBLIGATORIOS**: No se puede completar la evaluación sin seleccionar al menos un control.

2. **Los documentos deben subirse en el Plan de Acción**: Los documentos asociados a acciones se vinculan al responsable.

3. **El responsable debe existir**: El nombre o email del responsable debe coincidir con un usuario en la base de datos.

4. **Verificar siempre en los reportes**: Después de guardar, siempre verificar que los datos aparecen correctamente en los reportes.

---

## Soporte

Si encuentras problemas:
1. Revisar la consola del navegador (F12) para errores
2. Revisar los logs del backend
3. Verificar los datos en la base de datos directamente
4. Contactar al equipo de desarrollo con los detalles del error

