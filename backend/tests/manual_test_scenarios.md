# 🧪 TEST MANUAL - Escenarios de Usuario
## Sistema SGSRI - Evaluación de Riesgos

### 📋 **INSTRUCCIONES GENERALES**

1. **Lanzar el sistema**:
   ```bash
   # Terminal 1 - Backend
   cd backend
   python run.py
   
   # Terminal 2 - Frontend  
   cd frontend
   npm run dev
   ```

2. **Acceder a la aplicación**:
   - URL: `http://localhost:5173/wizard`
   - Verificar que se cargan los activos correctamente

---

## 🎯 **ESCENARIO 1: Evaluación de Activo Nuevo**

### **Objetivo**: Probar el flujo completo de evaluación de un activo

### **Pasos a seguir**:

1. **Seleccionar un activo no evaluado** (debe aparecer en azul)
   - Buscar un activo que no tenga evaluación previa
   - Hacer clic en el activo

2. **Completar el Wizard de 5 pasos**:

   **Paso 1 - Identificación de Riesgo**:
   - **Amenaza**: "Acceso no autorizado a sistemas"
   - **Vulnerabilidad**: "Falta de autenticación multifactor"
   - **Descripción**: "Riesgo de acceso no autorizado debido a la ausencia de autenticación de dos factores"

   **Paso 2 - Evaluación Inherente**:
   - **Probabilidad**: "Ocasional" (Nivel 3)
   - **Impacto**: "Moderado" (Nivel 3)
   - **Justificación**: "El riesgo puede materializarse ocasionalmente y tendría un impacto moderado en las operaciones"

   **Paso 3 - Controles Existentes**:
   - **Controles seleccionados**: "Autenticación básica", "Logs de acceso"
   - **Eficacia**: "Media"
   - **Justificación**: "Los controles existentes proporcionan protección básica pero no son suficientes"

   **Paso 4 - Evaluación Residual**:
   - **Probabilidad**: "Posible" (Nivel 2)
   - **Impacto**: "Menor" (Nivel 2)
   - **Justificación**: "Con los controles implementados, el riesgo residual es menor pero aún presente"

   **Paso 5 - Opciones de Tratamiento**:
   - **Opción**: "Mitigar"
   - **Responsable**: "Equipo de Seguridad"
   - **Fecha Inicio**: Fecha actual
   - **Fecha Fin**: 3 meses después
   - **Presupuesto**: "$5,000"

3. **Verificar resultados**:
   - El activo debe aparecer en verde (completado)
   - Hacer clic en el activo para ver el resumen
   - Verificar que se muestra toda la información ingresada

### **Resultado esperado**: ✅ Activo evaluado completamente con resumen detallado

---

## 🎯 **ESCENARIO 2: Evaluación Parcial (Estado Naranja)**

### **Objetivo**: Probar el sistema de guardado y recuperación de evaluaciones parciales

### **Pasos a seguir**:

1. **Iniciar evaluación de un nuevo activo**
   - Seleccionar otro activo no evaluado
   - Completar solo los primeros 2 pasos del wizard

2. **Salir del wizard**:
   - Cerrar el navegador o navegar a otra página
   - El sistema debe guardar automáticamente el progreso

3. **Regresar y verificar estado naranja**:
   - El activo debe aparecer en naranja con porcentaje de progreso
   - Debe mostrar un botón "Continuar"

4. **Continuar la evaluación**:
   - Hacer clic en "Continuar" o en el activo
   - El sistema debe preguntar si quieres continuar desde donde se quedó
   - Confirmar y completar los pasos restantes

### **Resultado esperado**: ✅ Estado naranja funcional con recuperación de progreso

---

## 🎯 **ESCENARIO 3: Predicción de Riesgo (Simulado)**

### **Objetivo**: Probar el sistema de predicción de riesgos

### **Datos de prueba para predicción**:

**Activo de Prueba**:
- **Nombre**: "SERVIDOR-WEB-01"
- **Tipo**: "Hardware"
- **Criticidad**: "Alto"
- **Estado**: "En Producción"

**Amenaza propuesta**:
- **Amenaza**: "Ataque de denegación de servicio (DDoS)"
- **Vulnerabilidad**: "Falta de protección contra DDoS"
- **Descripción**: "El servidor web está expuesto a ataques DDoS que pueden interrumpir el servicio"

### **Predicción esperada del sistema**:

**Basado en datos históricos similares**:
- **Nivel de Riesgo Predicho**: "Alto"
- **Probabilidad Predicha**: "Probable" (Nivel 4)
- **Impacto Predicho**: "Mayor" (Nivel 4)
- **Confianza de la Predicción**: 85%

**Controles Recomendados**:
1. "Implementar protección DDoS (Cloudflare/AWS Shield)"
2. "Configurar balanceadores de carga"
3. "Monitoreo de tráfico en tiempo real"
4. "Plan de respuesta a incidentes"

### **Pasos a seguir**:

1. **Ingresar los datos del activo**
2. **Completar la evaluación con los datos propuestos**
3. **Verificar que el sistema sugiere controles similares a los recomendados**
4. **Comparar con la predicción esperada**

### **Resultado esperado**: ✅ Sistema sugiere controles relevantes y predicción coherente

---

## 🎯 **ESCENARIO 4: Exportación de PDF**

### **Objetivo**: Probar la funcionalidad de exportación de reportes

### **Pasos a seguir**:

1. **Seleccionar un activo evaluado** (verde)
2. **Hacer clic para ver el resumen**
3. **Hacer clic en "Exportar PDF"**
4. **Verificar que se descarga el PDF**
5. **Abrir el PDF y verificar contenido**:
   - Información del activo
   - Detalles del riesgo
   - Evaluación inherente y residual
   - Controles aplicados
   - Plan de acción

### **Resultado esperado**: ✅ PDF generado con información completa y bien formateada

---

## 🎯 **ESCENARIO 5: Consulta de Base de Conocimiento**

### **Objetivo**: Probar el sistema de consulta de conocimiento (RAG simulado)

### **Consultas de prueba**:

1. **"¿Qué controles debo implementar para proteger contra ataques DDoS?"**
   - **Respuesta esperada**: Información sobre protecciones DDoS, balanceadores, monitoreo

2. **"¿Cuáles son los requisitos de ISO 27001 para gestión de accesos?"**
   - **Respuesta esperada**: Información sobre controles de acceso, autenticación, autorización

3. **"¿Cómo evaluar el riesgo de un servidor web?"**
   - **Respuesta esperada**: Metodología de evaluación, factores a considerar, escalas de riesgo

### **Pasos a seguir**:

1. **Implementar un chat básico** (si está disponible)
2. **Realizar las consultas propuestas**
3. **Verificar que las respuestas son relevantes y útiles**
4. **Evaluar la calidad de las sugerencias**

### **Resultado esperado**: ✅ Respuestas relevantes y útiles basadas en conocimiento ISO

---

## 📊 **CRITERIOS DE EVALUACIÓN**

### **Funcionalidad Básica** (40 puntos)
- [ ] Wizard de 5 pasos funciona correctamente
- [ ] Estados de color (azul/naranja/verde) funcionan
- [ ] Guardado y recuperación de evaluaciones parciales
- [ ] Exportación PDF funciona

### **Calidad de Predicciones** (30 puntos)
- [ ] Sugerencias de controles son relevantes
- [ ] Predicciones de riesgo son coherentes
- [ ] Confianza de predicciones es realista
- [ ] Respuestas de conocimiento son útiles

### **Experiencia de Usuario** (20 puntos)
- [ ] Interfaz es intuitiva y fácil de usar
- [ ] Navegación es fluida
- [ ] Mensajes de error son claros
- [ ] Carga de datos es rápida

### **Robustez del Sistema** (10 puntos)
- [ ] Sistema maneja errores gracefully
- [ ] Datos se guardan correctamente
- [ ] No hay pérdida de información
- [ ] Performance es aceptable

---

## 🚨 **PROBLEMAS CONOCIDOS Y SOLUCIONES**

### **Problema**: Activo no aparece en color correcto
**Solución**: Verificar que la evaluación se guardó correctamente en la BD

### **Problema**: PDF no se genera
**Solución**: Verificar que jsPDF está instalado y funcionando

### **Problema**: Estado naranja no funciona
**Solución**: Verificar localStorage y APIs de evaluación parcial

### **Problema**: Predicciones no son relevantes
**Solución**: Verificar que los modelos ML están entrenados con datos suficientes

---

## 📝 **FORMATO DE REPORTE**

### **Al finalizar las pruebas, reportar**:

1. **Escenarios completados exitosamente**: ✅/❌
2. **Problemas encontrados**: Descripción detallada
3. **Sugerencias de mejora**: Lista de mejoras propuestas
4. **Calificación general**: X/100 puntos
5. **Recomendación**: ¿Proceder con Fase 1? Sí/No

### **Ejemplo de reporte**:
```
ESCENARIO 1: ✅ COMPLETADO
- Wizard funcionó correctamente
- Resumen se mostró completo
- PDF se generó exitosamente

ESCENARIO 2: ❌ PROBLEMA
- Estado naranja no se mostró
- Botón continuar no funcionó
- Error: "Cannot read property 'puedeContinuar'"

CALIFICACIÓN: 75/100
RECOMENDACIÓN: Proceder con Fase 1 después de corregir problemas
```

---

**¡Listo para comenzar las pruebas manuales!** 🚀
