# Flujo Técnico de Datos: Interacción con Componentes Inteligentes
## Sistema RAG para Generación de Justificaciones de Riesgo Residual

---

## 1. Introducción

El sistema de justificación de riesgos residuales implementa un enfoque híbrido de **Retrieval Augmented Generation (RAG)** que combina recuperación de información estructurada desde bases de datos relacionales con generación de texto contextual basada en plantillas. Aunque el sistema está diseñado para integrar una base de datos vectorial para búsqueda semántica (según la arquitectura propuesta), la implementación actual utiliza búsqueda por texto y plantillas predefinidas.

---

## 2. Arquitectura del Flujo de Datos

### 2.1 Componentes Principales

- **Frontend (React)**: Componente `ResidualJustificationSuggestions.tsx`
- **Backend API (Flask)**: Endpoint `/api/predictive/suggestions/residual-justifications`
- **Servicio de Sugerencias**: `PredictiveSuggestionService` (base de conocimiento JSON)
- **Base de Datos MySQL**: Tabla `controles_seguridad` con códigos ISO 27002
- **Base de Conocimiento JSON**: Archivo `iso_knowledge_base.json` (estructura de amenazas, vulnerabilidades, controles)

### 2.2 Flujo General

```
Usuario (Frontend)
  ↓ HTTP POST /api/predictive/suggestions/residual-justifications
Backend API (Flask)
  ↓ Extracción de Contexto
Servicio RAG (Hybrid)
  ├─→ MySQL (Retrieval: Búsqueda de Controles)
  ├─→ Knowledge Base JSON (Retrieval: Mapeo ISO)
  └─→ Generación de Plantillas (Generation)
  ↓ Respuesta JSON
Frontend (Renderizado)
```

---

## 3. Proceso Detallado: De Datos de Riesgo a Justificación

### 3.1 Fase 1: Recepción y Extracción de Contexto

**Endpoint**: `POST /api/predictive/suggestions/residual-justifications`

**Datos de Entrada (JSON)**:
```json
{
  "inherent_risk": {
    "probabilidad": "Media",
    "impacto": "Alto",
    "nivel": "HIGH"
  },
  "residual_risk": {
    "probabilidad": "Baja",
    "impacto": "Medio",
    "nivel": "MEDIUM"
  },
  "controls": ["Backup Automatizado", "Monitoreo Continuo"]
}
```

**Procesamiento Inicial** (Líneas 219-236 de `predictive.py`):
```python
# Extracción de parámetros del riesgo inherente
inherent_prob = inherent_risk.get('probabilidad', '')
inherent_impact = inherent_risk.get('impacto', '')
inherent_level = inherent_risk.get('nivel', '')

# Extracción de parámetros del riesgo residual
residual_prob = residual_risk.get('probabilidad', '')
residual_impact = residual_risk.get('impacto', '')
residual_level = residual_risk.get('nivel', '')
```

**Análisis de Reducción**:
El sistema identifica automáticamente el tipo de reducción:
- **Reducción de Probabilidad**: `inherent_prob != residual_prob`
- **Reducción de Impacto**: `inherent_impact != residual_impact`
- **Reducción de Nivel General**: `inherent_level != residual_level`

---

### 3.2 Fase 2: Conversión a Prompt/Query (Context Extraction)

**Paso 2.1: Construcción de Query para Retrieval de Controles**

El sistema transforma los nombres de controles en queries SQL para recuperar información estructurada:

```python
# Para cada control en la lista de controles seleccionados
for control_name in controls:
    # Query SQL con búsqueda por texto (ILIKE para case-insensitive)
    query = controles_seguridad.query.filter(
        or_(
            controles_seguridad.Nombre.ilike(f'%{control_name}%'),
            controles_seguridad.Descripcion.ilike(f'%{control_name}%')
        )
    )
    control = query.first()
```

**Estructura del Query Implícito**:
- **Objetivo**: Recuperar metadatos de controles (códigos ISO, eficacia, descripción)
- **Método**: Búsqueda por coincidencia de texto parcial (fuzzy matching)
- **Resultado**: Objeto `control` con atributos: `ID_Control`, `Nombre`, `Descripcion`, `codigo_control_iso`, `Eficacia_Esperada`, `Tipo`

**Paso 2.2: Construcción de Contexto Enriquecido**

El sistema construye un objeto de contexto estructurado:

```python
controles_reales.append({
    'id': control.ID_Control,
    'nombre': control.Nombre,
    'descripcion': descripcion,
    'codigo_iso': codigo_iso,  # Ej: "A.12.3"
    'categoria_iso': categoria_iso,
    'eficacia': eficacia,  # "Muy Alta", "Alta", "Media", "Baja"
    'tipo': tipo  # "Preventivo", "Detectivo", "Recuperación"
})
```

**Contexto Final para Generación**:
```python
context = {
    'inherent_risk': {
        'probabilidad': inherent_prob,
        'impacto': inherent_impact,
        'nivel': inherent_level
    },
    'residual_risk': {
        'probabilidad': residual_prob,
        'impacto': residual_impact,
        'nivel': residual_level
    },
    'controles': controles_reales,  # Lista de controles con metadatos ISO
    'reduccion_tipo': identificado_automaticamente  # 'probabilidad', 'impacto', 'nivel'
}
```

---

### 3.3 Fase 3: Retrieval (Recuperación de Información)

**3.3.1 Retrieval desde Base de Datos MySQL**

El sistema realiza consultas SQL para recuperar controles y sus metadatos normativos:

```sql
-- Query implícito generado por SQLAlchemy
SELECT ID_Control, Nombre, Descripcion, codigo_control_iso, 
       Eficacia_Esperada, Tipo, Categoria
FROM controles_seguridad
WHERE (Nombre ILIKE '%Backup Automatizado%' 
    OR Descripcion ILIKE '%Backup Automatizado%')
  AND activo = TRUE
LIMIT 1
```

**Datos Recuperados**:
- **Códigos ISO 27002**: Mapeo directo de controles a artículos normativos (ej: `A.12.3`, `A.12.4`)
- **Eficacia Esperada**: Valoración cualitativa que influye en el cálculo de confianza
- **Tipo de Control**: Clasificación funcional (Preventivo, Detectivo, Recuperación)

**3.3.2 Clasificación de Controles por Función**

El sistema clasifica automáticamente los controles según su función en la mitigación:

```python
# Controles que reducen probabilidad (preventivos/detectivos)
controles_preventivos = [c for c in controles_reales if 
    'prevención' in c['descripcion'].lower() or 
    'preventivo' in c['tipo'].lower() or
    'detección' in c['descripcion'].lower() or
    'monitoreo' in c['descripcion'].lower() or
    c['codigo_iso'] and ('A.6' in str(c['codigo_iso']) or 
                         'A.7' in str(c['codigo_iso']) or 
                         'A.9' in str(c['codigo_iso']))
]

# Controles que reducen impacto (protección/recuperación)
controles_proteccion = [c for c in controles_reales if 
    'protección' in c['descripcion'].lower() or 
    'recuperación' in c['descripcion'].lower() or
    'backup' in c['descripcion'].lower() or
    'respaldo' in c['descripcion'].lower() or
    'continuidad' in c['descripcion'].lower() or
    c['codigo_iso'] and ('A.12' in str(c['codigo_iso']) or 
                         'A.17' in str(c['codigo_iso']) or 
                         'A.18' in str(c['codigo_iso']))
]
```

**Nota sobre Base Vectorial**: 
Según la arquitectura propuesta, esta fase debería implementar búsqueda semántica mediante embeddings. La implementación actual utiliza búsqueda por texto y heurísticas basadas en códigos ISO. Una implementación futura con base vectorial realizaría:

1. **Embedding del Query**: Conversión del contexto de riesgo a vector de embeddings
2. **Búsqueda por Similitud Coseno**: Retrieval de documentos ISO más relevantes
3. **Re-ranking**: Ordenamiento de resultados por relevancia semántica

---

### 3.4 Fase 4: Generation (Generación de Justificaciones)

**3.4.1 Selección de Plantilla según Tipo de Reducción**

El sistema genera múltiples justificaciones según el tipo de reducción identificado:

**Justificación 1: Reducción de Probabilidad** (Líneas 296-338)

```python
if inherent_prob != residual_prob:
    # Plantilla base
    prob_reduction_text = f"La probabilidad del riesgo se ha reducido de '{inherent_prob}' a '{residual_prob}' mediante la implementación de controles de seguridad preventivos y de detección."
    
    # Inyección de contexto: Nombres de controles con códigos ISO
    controles_texto = []
    for ctrl in controles_preventivos[:3]:
        if ctrl['codigo_iso']:
            controles_texto.append(f"'{ctrl['nombre']}' (ISO 27002:{ctrl['codigo_iso']})")
        else:
            controles_texto.append(f"'{ctrl['nombre']}'")
    
    # Construcción de texto con controles
    if controles_texto:
        prob_reduction_text += f" Los controles {', '.join(controles_texto)} han demostrado eficacia en la reducción de la probabilidad de materialización del riesgo."
    
    # Inyección de descripción de control (primeros 150 caracteres)
    if controles_preventivos[0]['descripcion']:
        prob_reduction_text += f" Específicamente, {controles_preventivos[0]['descripcion'][:150]}..."
    
    # Referencias normativas (hardcoded pero contextualizadas)
    prob_reduction_text += " Esta reducción cumple con los requisitos de ISO 27005:2022 A.6.1.2 y con la Resolución 2277 de 2025..."
```

**Justificación 2: Reducción de Impacto** (Líneas 341-391)

Similar al proceso anterior, pero enfocado en controles de protección y recuperación:

```python
if inherent_impact != residual_impact:
    impact_reduction_text = f"El impacto del riesgo se ha reducido de '{inherent_impact}' a '{residual_impact}' gracias a los controles de protección, recuperación y continuidad implementados."
    
    # Inyección de eficacia del control
    if controles_proteccion[0]['eficacia']:
        eficacia_map = {
            'Muy Alta': 'muy alta eficacia',
            'Alta': 'alta eficacia',
            'Media': 'eficacia moderada',
            'Baja': 'eficacia limitada'
        }
        eficacia = eficacia_map.get(controles_proteccion[0]['eficacia'], 'eficacia')
        impact_reduction_text += f" El control '{controles_proteccion[0]['nombre']}' tiene {eficacia} según la evaluación realizada."
```

**Justificación 3: Reducción General del Nivel** (Líneas 394-426)

```python
if inherent_level != residual_level:
    inherent_level_text = level_map.get(inherent_level, inherent_level)  # "HIGH" → "Alto"
    residual_level_text = level_map.get(residual_level, residual_level)  # "MEDIUM" → "Medio"
    
    general_reduction_text = f"El nivel de riesgo se ha reducido de {inherent_level_text} a {residual_level_text}. "
    general_reduction_text += f"Esta reducción se debe a la combinación estratégica de {len(controles_reales)} controles que han mitigado tanto la probabilidad como el impacto del riesgo."
    
    # Referencias normativas combinadas
    general_reduction_text += " Según ISO 27005:2022, la evaluación residual debe considerar la efectividad real de los controles implementados... "
    general_reduction_text += "Esta evaluación cumple además con la Resolución 2277 de 2025, que establece los lineamientos para la gestión de riesgos residuales, y con el CONPES 3995 de 2020 sobre Política de Seguridad Digital."
```

**3.4.2 Cálculo de Confianza (Confidence Score)**

Cada justificación incluye un score de confianza calculado heurísticamente:

```python
suggestions.append({
    'id': 'prob-reduction',
    'titulo': 'Reducción de Probabilidad',
    'descripcion': prob_reduction_text,
    'norma': 'ISO 27005 + Res. 2277/2025',
    'articulo': 'ISO 27005 A.6.1.2 - Res. 2277/2025',
    'confianza': 0.92,  # Score fijo basado en tipo de justificación
    'relacion_inherente': f"El riesgo inherente tenía una probabilidad '{inherent_prob}', que ha sido mitigada a '{residual_prob}' mediante los controles implementados...",
    'controles_mencionados': [c['nombre'] for c in controles_preventivos[:3]]
})
```

**Factores que influyen en la confianza** (implícitos en el código):
- **Presencia de códigos ISO**: Justificaciones con referencias ISO tienen mayor confianza (0.90-0.96)
- **Número de controles**: Más controles mencionados aumentan la confianza
- **Eficacia de controles**: Controles con "Muy Alta" o "Alta" eficacia aumentan la confianza
- **Referencias normativas**: Inclusión de marco legal colombiano aumenta confianza (0.90-0.95)

---

### 3.5 Fase 5: Post-procesamiento y Respuesta

**Ordenamiento de Sugerencias**:
```python
# Las sugerencias se ordenan implícitamente por tipo:
# 1. Reducción de Probabilidad
# 2. Reducción de Impacto
# 3. Reducción General
# 4. Análisis de Eficacia
# 5. Justificación ISO + Marco Legal
```

**Limitación de Resultados**:
```python
return jsonify({
    'success': True,
    'suggestions': suggestions[:5]  # Máximo 5 sugerencias
}), 200
```

**Estructura de Respuesta JSON**:
```json
{
  "success": true,
  "suggestions": [
    {
      "id": "prob-reduction",
      "titulo": "Reducción de Probabilidad",
      "descripcion": "La probabilidad del riesgo se ha reducido de 'Media' a 'Baja' mediante la implementación de controles de seguridad preventivos y de detección. Los controles 'Backup Automatizado' (ISO 27002:A.12.3) y 'Monitoreo Continuo' (ISO 27002:A.12.4) han demostrado eficacia...",
      "norma": "ISO 27005 + Res. 2277/2025",
      "articulo": "ISO 27005 A.6.1.2 - Res. 2277/2025",
      "confianza": 0.92,
      "relacion_inherente": "El riesgo inherente tenía una probabilidad 'Media', que ha sido mitigada a 'Baja' mediante los controles implementados según ISO 27005:2022 y Resolución 2277 de 2025.",
      "controles_mencionados": ["Backup Automatizado", "Monitoreo Continuo"]
    }
  ]
}
```

---

## 4. Análisis Técnico del Flujo

### 4.1 Ventajas del Enfoque Actual

1. **Búsqueda Estructurada**: Utiliza metadatos estructurados (códigos ISO) para recuperación precisa
2. **Trazabilidad Normativa**: Cada justificación incluye referencias explícitas a normativas ISO y marco legal colombiano
3. **Contextualización**: Las plantillas se adaptan dinámicamente según el tipo de reducción identificado
4. **Múltiples Perspectivas**: Genera hasta 5 justificaciones desde diferentes ángulos (probabilidad, impacto, nivel, eficacia, normativa)

### 4.2 Limitaciones y Oportunidades de Mejora

1. **Búsqueda por Texto vs. Semántica**: 
   - **Actual**: Búsqueda por coincidencia de texto parcial (`ILIKE`)
   - **Propuesto**: Búsqueda semántica mediante embeddings y similitud coseno

2. **Plantillas Estáticas vs. Generación Dinámica**:
   - **Actual**: Plantillas predefinidas con inserción de variables
   - **Propuesto**: Generación mediante modelos de lenguaje (LLM) con contexto enriquecido

3. **Base de Conocimiento JSON vs. Vectorial**:
   - **Actual**: Archivo JSON estático con mapeos predefinidos
   - **Propuesto**: Base vectorial con embeddings de documentos ISO completos

### 4.3 Propuesta de Evolución hacia RAG Completo

**Fase de Retrieval Mejorada**:
```python
# Pseudocódigo para implementación futura
def retrieve_context_vectorial(context):
    # 1. Generar embedding del contexto
    query_embedding = embedding_model.encode(
        f"Riesgo inherente: {context['inherent_risk']}, "
        f"Riesgo residual: {context['residual_risk']}, "
        f"Controles: {context['controles']}"
    )
    
    # 2. Búsqueda por similitud en base vectorial
    results = vector_db.similarity_search(
        query_embedding,
        top_k=5,
        filter={"norma": "ISO 27005"}
    )
    
    # 3. Extraer documentos relevantes
    relevant_docs = [r['text'] for r in results if r['score'] > 0.7]
    
    return relevant_docs
```

**Fase de Generation Mejorada**:
```python
# Pseudocódigo para generación con LLM
def generate_justification_llm(context, retrieved_docs):
    prompt = f"""
    Contexto del Riesgo:
    - Riesgo Inherente: {context['inherent_risk']}
    - Riesgo Residual: {context['residual_risk']}
    - Controles Implementados: {context['controles']}
    
    Documentos ISO Relevantes:
    {retrieved_docs}
    
    Genera una justificación técnica que explique la reducción del riesgo,
    citando los artículos ISO 27005 y 27002 relevantes, y cumpliendo con
    el marco legal colombiano (Res. 2277/2025, Res. 500/2021, CONPES 3995/2020).
    """
    
    response = llm.generate(prompt, temperature=0.3, max_tokens=500)
    return response
```

---

## 5. Conclusiones

El sistema actual implementa un **RAG híbrido** que combina:

1. **Retrieval estructurado** desde MySQL con búsqueda por texto
2. **Retrieval de conocimiento** desde base JSON con mapeos ISO
3. **Generation basada en plantillas** con inserción contextual de datos

Aunque no utiliza búsqueda semántica vectorial actualmente, el diseño arquitectónico contempla esta evolución, lo que permitiría:

- **Mayor precisión** en la recuperación de contexto normativo relevante
- **Generación más natural** mediante modelos de lenguaje
- **Adaptabilidad** a cambios en normativas sin modificar plantillas

El flujo actual es **funcional y trazable**, proporcionando justificaciones normativas válidas con referencias explícitas a ISO 27005, ISO 27002 y el marco legal colombiano.

---

**Referencias Técnicas**:
- Código fuente: `backend/app/routes/predictive.py` (líneas 211-538)
- Servicio de sugerencias: `backend/app/services/predictive/suggestion_service.py`
- Arquitectura propuesta: `backend/architecture_design.md`
- Base de conocimiento: `backend/app/services/predictive/iso_knowledge_base.json`

