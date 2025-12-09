# Instrucciones para Actualizar el Presupuesto en el Documento Word

## Pasos para Actualizar el Documento

### 1. Localizar la Sección de Presupuesto

Busca en el documento Word la sección que contiene:
- "Presupuesto"
- "8.000.000" o "8M"
- Tablas con costos del desarrollador

### 2. Reemplazar el Valor del Desarrollador

**Buscar y reemplazar:**
- ❌ **Antes**: 8.000.000 COP/mes (o cualquier valor menor)
- ✅ **Después**: **20.000.000 COP/mes**

**Buscar y reemplazar:**
- ❌ **Antes**: Aporte total del desarrollador (cualquier valor menor a 130M)
- ✅ **Después**: **130.000.000 COP** (6.5 meses × 20.000.000)

### 3. Actualizar la Tabla de Recursos Tecnológicos

Reemplazar la tabla existente con esta nueva estructura:

| Recurso | Costo Mensual | Costo Proyecto (6.5 meses) | Comentario |
|---------|---------------|----------------------------|------------|
| VPS (4–8 GB RAM) | 200.000 – 350.000 | ~2.100.000 | SmartAuditorIA usa RAG, requiere mayor RAM |
| Vector DB (Pinecone / Chroma Server) | 60.000–120.000 | ~480.000 | Fundamental para embeddings |
| API LLM (OpenAI / Bedrock) | 80.000–120.000 | ~640.000 | Según uso en pruebas y producción |
| Suscripciones técnicas (Cursor Pro, GitHub Copilot, IDE) | 70.000–150.000 | ~900.000 | Totalmente justificable |
| Dominios / SSL | 150.000 (1 año) | 150.000 | Certificado SSL |
| Herramientas de monitoreo / logs | 40.000 | 240.000 | Recomendado para producción |
| **Subtotal** | | **4.510.000** | |

### 4. Actualizar Hardware

**Buscar y reemplazar:**
- ❌ **Antes**: Cualquier valor diferente
- ✅ **Después**: 
  - Depreciación mensual: **120.000 COP/mes**
  - Total (6.5 meses): **780.000 COP**

### 5. Actualizar Material Académico

**Buscar y reemplazar:**
- ❌ **Antes**: Cualquier valor diferente
- ✅ **Después**: **1.800.000 COP**

Incluir desglose:
- Libros técnicos: ~500.000
- Cursos especializados: 300.000–800.000
- Certificaciones (opcional): 700.000 – 1.500.000

### 6. Actualizar Tabla Resumen Final

Reemplazar con esta tabla:

| Rubro | Valor (COP) |
|-------|-------------|
| **Aporte de trabajo (ingeniero IA senior)** | **130.000.000** |
| Infraestructura y APIs | 4.510.000 |
| Hardware (depreciación) | 780.000 |
| Formación y herramientas | 1.800.000 |
| Dominio y SSL | 150.000 |
| **TOTAL REAL** | **137.240.000** |

### 7. Agregar Sección de Desglose de Financiación

Agregar después del resumen:

**Desglose de Financiación:**
- Valor efectivo a pagar por infraestructura: ~4.5M COP
- Aporte del desarrollador (contrapartida académica): 130M COP

### 8. Mejorar Formato de Tablas

Para que las tablas se vean mejor en Word:

1. **Seleccionar la tabla**
2. **Diseño de tabla** → **Estilos de tabla**
3. Elegir un estilo profesional (ej: "Tabla con encabezados")
4. Ajustar ancho de columnas para que el texto no se corte
5. Centrar números en columnas de valores
6. Aplicar formato de moneda a valores (Formato → Número → Moneda)

### 9. Verificar Consistencia

- ✅ Todos los valores suman correctamente
- ✅ Formato de números consistente (puntos para miles)
- ✅ Todas las referencias al presupuesto actualizadas
- ✅ Justificaciones incluidas

### 10. Agregar Nota Justificativa

Al final de la sección de presupuesto, agregar:

**Justificación del Presupuesto:**

Este presupuesto es defendible, profesional, académico y realista porque:
- El valor del desarrollador (20M/mes) refleja el mercado colombiano para perfiles IA senior
- La infraestructura considera las necesidades reales de un sistema RAG en producción
- Los costos de formación son esenciales para mantenerse actualizado en tecnologías emergentes

---

## Texto Completo para Copiar y Pegar

Si prefieres, puedes copiar el contenido completo del archivo `PRESUPUESTO_ACTUALIZADO.md` y pegarlo en el documento Word, luego ajustar el formato.

