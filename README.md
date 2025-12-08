# 🛡️ Sistema de Gestión de Riesgos de Información (SGRI)

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║     ███████╗ ██████╗ ███████╗██████╗ ██╗                                     ║
║     ██╔════╝██╔════╝ ██╔════╝██╔══██╗██║                                     ║
║     ███████╗██║      █████╗  ██████╔╝██║                                     ║
║     ╚════██║██║      ██╔══╝  ██╔══██╗██║                                     ║
║     ███████║╚██████╗ ███████╗██║  ██║██║                                     ║
║     ╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝                                     ║
║                                                                              ║
║          Sistema de Gestión de Riesgos de Información                        ║
║          Plataforma integral para la gestión de activos y                    ║
║          evaluación de riesgos basada en normativa ISO 27001/27002/27005    ║
║          y marco legal colombiano (Dec. 767, CONPES 3995, Res. 500/2277)     ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/Flask-2.3+-green.svg)](https://flask.palletsprojects.com/)
[![React](https://img.shields.io/badge/React-18+-61dafb.svg)](https://reactjs.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-orange.svg)](https://www.mysql.com/)
[![ISO 27001](https://img.shields.io/badge/ISO-27001%2F27002%2F27005-red.svg)](https://www.iso.org/)
[![Colombia](https://img.shields.io/badge/Marco%20Legal-Colombia-yellow.svg)](MARCO_LEGAL_COLOMBIA.md)

</div>

---

## 📋 Tabla de Contenidos

- [🎯 Visión General](#-visión-general)
- [🏗️ Arquitectura del Sistema](#️-arquitectura-del-sistema)
- [📦 Módulos del Sistema](#-módulos-del-sistema)
- [🤖 Sistema RAG para ISO](#-sistema-rag-para-iso)
- [⚖️ Marco Legal Colombia](#️-marco-legal-colombia)
- [🔄 Flujo de Datos](#-flujo-de-datos)
- [🛠️ Tecnologías](#️-tecnologías)
- [🚀 Inicio Rápido](#-inicio-rápido)
- [📚 Documentación](#-documentación)

---

## 🎯 Visión General

**SGRI** es una plataforma integral para la gestión de riesgos de seguridad de la información que combina:

- ✅ **Gestión completa de activos** de información
- ✅ **Identificación y evaluación de riesgos** basada en ISO 27005 y marco legal colombiano
- ✅ **Sistema predictivo con IA** para sugerencias inteligentes
- ✅ **RAG (Retrieval Augmented Generation)** para justificaciones basadas en normativa ISO y marco legal colombiano
- ✅ **Wizard interactivo** para evaluaciones paso a paso
- ✅ **Dashboard analítico** con métricas y visualizaciones
- ✅ **Gestión de incidentes** y controles de seguridad
- ✅ **Cumplimiento normativo** con Decreto 767, CONPES 3995, Resoluciones 500 y 2277, Leyes 1581 y 1273

---

## 🏗️ Arquitectura del Sistema

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           ARQUITECTURA SGRI                                 │
└─────────────────────────────────────────────────────────────────────────────┘

    ┌──────────────────────────────────────────────────────────────────┐
    │                        FRONTEND (React)                          │
    │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
    │  │   Dashboard  │  │   Wizard     │  │  Gestión     │          │
    │  │   Analytics  │  │  Evaluación  │  │  Activos     │          │
    │  └──────────────┘  └──────────────┘  └──────────────┘          │
    │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
    │  │   Riesgos    │  │  Incidentes  │  │  Reportes    │          │
    │  │   Gestión    │  │  Seguridad   │  │  Exportación │          │
    │  └──────────────┘  └──────────────┘  └──────────────┘          │
    └──────────────────────────────────────────────────────────────────┘
                              │
                              │ HTTP/REST API
                              │ JSON
                              ▼
    ┌──────────────────────────────────────────────────────────────────┐
    │                    BACKEND (Flask + Python)                      │
    │  ┌──────────────────────────────────────────────────────────┐    │
    │  │              API REST Endpoints                          │    │
    │  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐     │    │
    │  │  │ Activos  │ │ Riesgos  │ │Dashboard │ │Predictive│     │    │
    │  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘     │    │
    │  └──────────────────────────────────────────────────────────┘    │
    │  ┌──────────────────────────────────────────────────────────┐    │
    │  │          Servicios de Negocio                            │    │
    │  │  ┌──────────────┐  ┌──────────────┐                      │    │
    │  │  │ Evaluación   │  │  Predictive  │                      │    │
    │  │  │  Riesgos     │  │   Service    │                      │    │
    │  │  └──────────────┘  └──────────────┘                      │    │
    │  │  ┌──────────────┐  ┌──────────────┐                      │    │
    │  │  │ ISO Service  │  │  RAG Engine  │                       │    │
    │  │  └──────────────┘  └──────────────┘                      │    │
    │  └──────────────────────────────────────────────────────────┘    │
    │  ┌──────────────────────────────────────────────────────────┐    │
    │  │              Capa de Acceso a Datos                      │    │
    │  │  ┌──────────────┐  ┌──────────────┐                      │    │
    │  │  │ SQLAlchemy   │  │  ORM Models  │                      │    │
    │  │  │   (ORM)      │  │              │                      │    │
    │  │  └──────────────┘  └──────────────┘                      │    │
    │  └──────────────────────────────────────────────────────────┘    │
    └──────────────────────────────────────────────────────────────────┘
                              │
                              │ SQL Queries
                              │
                              ▼
    ┌──────────────────────────────────────────────────────────────────┐
    │                    BASE DE DATOS (MySQL)                         │
    │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐            │
    │  │   Activos    │  │   Riesgos    │  │  Evaluaciones│            │
    │  │   Tablas     │  │   Tablas     │  │   Tablas     │            │
    │  └──────────────┘  └──────────────┘  └──────────────┘            │
    │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐            │
    │  │  Controles   │  │  Incidentes  │  │   Usuarios   │            │
    │  │   Seguridad  │  │   Tablas     │  │   Tablas     │            │
    │  └──────────────┘  └──────────────┘  └──────────────┘            │
    │  ┌──────────────┐  ┌──────────────┐                              │
    │  │  Niveles     │  │  Documentos  │                              │
    │  │  Riesgo      │  │  Adjuntos    │                              │
    │  └──────────────┘  └──────────────┘                              │
    └──────────────────────────────────────────────────────────────────┘

    ┌──────────────────────────────────────────────────────────────────┐
    │              SISTEMA RAG (Retrieval Augmented Generation)        │
    │  ┌──────────────────────────────────────────────────────────┐    │
    │  │                                                          │    │
    │  │  ┌──────────────┐         ┌──────────────┐               │    │
    │  │  │  Knowledge   │         │   Vector     │             │    │
    │  │  │   Base       │───────▶│   Store       │              │    │
    │  │  │ (ISO Docs)   │  Embed  │  (Embeddings)│               │    │
    │  │  └──────────────┘         └──────────────┘               │  │
    │  │       │                           │                      │  │
    │  │       │                           │                      │  │
    │  │       ▼                           ▼                      │  │
    │  │  ┌──────────────────────────────────────────┐            │  │
    │  │  │      Retrieval Engine                     │           │  │
    │  │  │  • Semantic Search                        │           │  │
    │  │  │  • Context Matching                       │           │  │
    │  │  │  • ISO Article Extraction                 │           │  │
    │  │  └──────────────────────────────────────────┘            │  │
    │  │       │                                                  │  │
    │  │       ▼                                                  │  │
    │  │  ┌──────────────────────────────────────────┐            │  │
    │  │  │      Generation Engine                    │           │  │
    │  │  │  • Template-based Generation              │           │  │
    │  │  │  • Context-aware Suggestions             │            │  │
    │  │  │  • ISO-compliant Justifications          │            │  │
    │  │  └──────────────────────────────────────────┘            │  │
    │  │                                                          │  │
    │  └──────────────────────────────────────────────────────────┘  │
    └──────────────────────────────────────────────────────────────────┘
```

---

## 📦 Módulos del Sistema

### 🎯 Módulo 1: Gestión de Activos

```
┌─────────────────────────────────────────────────────────┐
│              GESTIÓN DE ACTIVOS                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  • Inventario completo de activos de información        │
│  • Clasificación por tipo (Hardware, Software, Datos)   │
│  • Niveles de criticidad (Muy Alto, Alto, Medio, Bajo)  │
│  • Clasificación CIA (Confidencialidad, Integridad,     │
│    Disponibilidad)                                      │
│  • Gestión de propietarios y custodios                  │ 
│  • Configuración de backups y retención                 │
│  • Dependencias entre activos                           │
│  • Integración con sistemas externos (GLPI)             │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### ⚠️ Módulo 2: Identificación de Riesgos

```
┌─────────────────────────────────────────────────────────┐
│          IDENTIFICACIÓN DE RIESGOS                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  • Identificación de amenazas                           │
│  • Identificación de vulnerabilidades                   │
│  • Asociación riesgo-activo                             │
│  • Tipos de riesgo (Seguridad, Técnico, Operacional)    │
│  • Sistema predictivo de sugerencias                    │
│  • Búsqueda semántica de amenazas/vulnerabilidades      │
│  • Historial de riesgos identificados                   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 📊 Módulo 3: Evaluación de Riesgos

```
┌─────────────────────────────────────────────────────────┐
│           EVALUACIÓN DE RIESGOS                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌──────────────────┐    ┌──────────────────┐           │
│  │  Evaluación      │    │  Evaluación       │          │
│  │  Inherente       │───▶│  Residual         │          │
│  │                  │    │                   │          │
│  │ • Probabilidad   │    │ • Probabilidad    │          │
│  │ • Impacto        │    │ • Impacto          │         │
│  │ • Nivel Riesgo   │    │ • Nivel Riesgo    │          │
│  │ • Justificación  │    │ • Justificación   │          │
│  └──────────────────┘    └──────────────────┘           │
│         │                         │                     │
│         └──────────┬──────────────┘                     │
│                    ▼                                     │
│         ┌──────────────────────┐                         │
│         │  Matriz de Riesgos    │                        │
│         │  (Visualización)      │                        │
│         └──────────────────────┘                         │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 🛡️ Módulo 4: Controles de Seguridad

```
┌─────────────────────────────────────────────────────────┐
│         CONTROLES DE SEGURIDAD                          │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  • Catálogo de controles                                │
│  • Categorización (Preventivo, Detectivo, Recuperación) │
│  • Tipo (Tecnológico, Organizacional)                   │
│  • Eficacia esperada                                    │
│  • Asociación con códigos ISO 27002                     │
│  • Selección de controles para mitigación               │
│  • Evaluación de eficacia                               │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 🚨 Módulo 5: Gestión de Incidentes

```
┌─────────────────────────────────────────────────────────┐
│          GESTIÓN DE INCIDENTES                          │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  • Registro de incidentes de seguridad                   │
│  • Clasificación por tipo y severidad                   │
│  • Estados (Abierto, En Proceso, Resuelto)              │
│  • Asociación con activos afectados                     │
│  • Acciones correctivas                                 │
│  • Seguimiento y resolución                             │
│  • Historial de incidentes                              │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 📈 Módulo 6: Dashboard y Analytics

```
┌─────────────────────────────────────────────────────────┐
│         DASHBOARD Y ANALYTICS                           │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  Métricas    │  │  Gráficos    │  │  Alertas     │  │
│  │  Generales   │  │  Tendencias  │  │  Sistema     │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│                                                          │
│  • Salud institucional                                  │
│  • Riesgos activos vs mitigados                         │
│  • Top riesgos críticos                                 │
│  • Matriz de riesgos interactiva                        │
│  • Evolución temporal                                   │
│  • Distribución por tipo                                │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 🧙 Módulo 7: Wizard de Evaluación

```
┌─────────────────────────────────────────────────────────┐
│         WIZARD DE EVALUACIÓN                            │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  Paso 1: Selección de Activo                            │
│    └─▶ Paso 2: Identificación de Riesgo                 │
│          └─▶ Paso 3: Evaluación Inherente                │
│                └─▶ Paso 4: Controles Existentes          │
│                      └─▶ Paso 5: Evaluación Residual     │
│                            └─▶ Paso 6: Tratamiento       │
│                                  └─▶ Paso 7: Plan Acción │
│                                        └─▶ Paso 8: Resumen│
│                                                          │
│  • Guía paso a paso interactiva                         │
│  • Validación en cada paso                              │
│  • Sugerencias contextuales                             │
│  • Exportación a PDF/Excel                              │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 🤖 Módulo 8: Sistema Predictivo (RAG)

```
┌─────────────────────────────────────────────────────────┐
│      SISTEMA PREDICTIVO CON RAG                         │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  • Sugerencias de amenazas basadas en tipo de activo    │
│  • Sugerencias de vulnerabilidades                      │
│  • Sugerencias de controles                             │
│  • Justificaciones basadas en ISO 27005                  │
│  • Búsqueda semántica en base de conocimiento ISO       │
│  • Generación contextual de justificaciones             │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

---

## 🤖 Sistema RAG para ISO

### ¿Qué es RAG?

**RAG (Retrieval Augmented Generation)** es una técnica que combina:
- **Retrieval (Recuperación)**: Búsqueda de información relevante en una base de conocimiento
- **Augmented (Aumentado)**: Enriquecimiento del contexto con información recuperada
- **Generation (Generación)**: Creación de respuestas o sugerencias basadas en el contexto

### Arquitectura RAG en SGRI

```
┌─────────────────────────────────────────────────────────────────────┐
│                    FLUJO RAG PARA SUGERENCIAS ISO                   │
└─────────────────────────────────────────────────────────────────────┘

    ┌─────────────────┐
    │   Usuario       │
    │  (Wizard Step)  │
    └────────┬────────┘
             │
             │ 1. Request: "Necesito justificación para
             │    riesgo residual con controles X, Y, Z"
             ▼
    ┌─────────────────────────────────────────────────────────┐
    │         API Endpoint: /predictive/suggestions/          │
    │              residual-justifications                    │
    └────────┬────────────────────────────────────────────────┘
             │
             ▼
    ┌─────────────────────────────────────────────────────────┐
    │      RETRIEVAL LAYER (Capa de Recuperación)             │
    ├─────────────────────────────────────────────────────────┤
    │                                                         │
    │  ┌──────────────────────────────────────────────┐       │
    │  │  1. Context Extraction                        │     │
    │  │     • Riesgo inherente (prob, impacto, nivel) │     │
    │  │     • Riesgo residual (prob, impacto, nivel)  │     │
    │  │     • Controles seleccionados                 │     │
    │  └──────────────────────────────────────────────┘     │
    │                    │                                    │
    │                    ▼                                    │
    │  ┌──────────────────────────────────────────────┐     │
    │  │  2. Knowledge Base Query                     │     │
    │  │     • Buscar controles en BD                 │     │
    │  │     • Obtener códigos ISO 27002              │     │
    │  │     • Buscar artículos ISO 27005 relevantes  │     │
    │  └──────────────────────────────────────────────┘     │
    │                    │                                    │
    │                    ▼                                    │
    │  ┌──────────────────────────────────────────────┐     │
    │  │  3. Semantic Matching                        │     │
    │  │     • Mapear controles → Artículos ISO       │     │
    │  │     • Identificar reducción riesgo            │     │
    │  │     • Extraer contexto normativo              │     │
    │  └──────────────────────────────────────────────┘     │
    │                                                          │
    └──────────────────────────────────────────────────────────┘
             │
             │ Contexto Enriquecido
             ▼
    ┌─────────────────────────────────────────────────────────┐
    │      GENERATION LAYER (Capa de Generación)               │
    ├─────────────────────────────────────────────────────────┤
    │                                                          │
    │  ┌──────────────────────────────────────────────┐     │
    │  │  1. Template Selection                        │     │
    │  │     • Seleccionar plantilla según tipo       │     │
    │  │     • Reducción probabilidad                  │     │
    │  │     • Reducción impacto                       │     │
    │  │     • Reducción nivel general                 │     │
    │  │     • Eficacia controles                     │     │
    │  └──────────────────────────────────────────────┘     │
    │                    │                                    │
    │                    ▼                                    │
    │  ┌──────────────────────────────────────────────┐     │
    │  │  2. Context Injection                         │     │
    │  │     • Insertar datos del riesgo inherente    │     │
    │  │     • Insertar datos del riesgo residual     │     │
    │  │     • Insertar nombres de controles          │     │
    │  │     • Insertar códigos ISO                   │     │
    │  └──────────────────────────────────────────────┘     │
    │                    │                                    │
    │                    ▼                                    │
    │  ┌──────────────────────────────────────────────┐     │
    │  │  3. ISO Compliance Check                     │     │
    │  │     • Verificar referencias ISO 27005        │     │
    │  │     • Agregar artículos ISO 27002            │     │
    │  │     • Asegurar coherencia normativa          │     │
    │  └──────────────────────────────────────────────┘     │
    │                    │                                    │
    │                    ▼                                    │
    │  ┌──────────────────────────────────────────────┐     │
    │  │  4. Response Generation                      │     │
    │  │     • Generar múltiples sugerencias          │     │
    │  │     • Calcular confianza (0-1)               │     │
    │  │     • Agregar metadatos (norma, artículo)    │     │
    │  └──────────────────────────────────────────────┘     │
    │                                                          │
    └──────────────────────────────────────────────────────────┘
             │
             │ Sugerencias Generadas
             ▼
    ┌─────────────────────────────────────────────────────────┐
    │              RESPUESTA AL USUARIO                       │
    ├─────────────────────────────────────────────────────────┤
    │                                                          │
    │  {                                                       │
    │    "success": true,                                     │
    │    "suggestions": [                                     │
    │      {                                                   │
    │        "id": "1",                                        │
    │        "titulo": "Reducción de Probabilidad",           │
    │        "descripcion": "Los controles implementados...", │
    │        "norma": "ISO 27005",                            │
    │        "articulo": "A.6.1.2",                           │
    │        "confianza": 0.85,                                │
    │        "relacion_inherente": "...",                     │
    │        "controles_mencionados": ["Control X", ...]      │
    │      },                                                  │
    │      ...                                                 │
    │    ]                                                     │
    │  }                                                       │
    │                                                          │
    └──────────────────────────────────────────────────────────┘
```

### Componentes del RAG

#### 1. **Knowledge Base (Base de Conocimiento)**

```
┌─────────────────────────────────────────────────────────┐
│              BASE DE CONOCIMIENTO ISO                    │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  • Normativa ISO 27001:2022                             │
│  • Normativa ISO 27002:2022                             │
│  • Normativa ISO 27005:2022                             │
│  • Controles de seguridad (BD)                          │
│  • Mapeo controles → Artículos ISO                      │
│  • Plantillas de justificación                          │
│  • Contextos de riesgo predefinidos                     │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

#### 2. **Retrieval Engine (Motor de Recuperación)**

```python
# Pseudocódigo del proceso de recuperación

def retrieve_context(inherent_risk, residual_risk, controls):
    context = {}
    
    # 1. Recuperar controles de la BD
    context['controles'] = get_controls_from_db(controls)
    
    # 2. Extraer códigos ISO de controles
    context['iso_codes'] = extract_iso_codes(context['controles'])
    
    # 3. Identificar tipo de reducción
    context['reduccion_tipo'] = identify_reduction_type(
        inherent_risk, residual_risk
    )
    
    # 4. Buscar artículos ISO relevantes
    context['iso_articles'] = find_relevant_iso_articles(
        context['reduccion_tipo'],
        context['iso_codes']
    )
    
    return context
```

#### 3. **Generation Engine (Motor de Generación)**

```python
# Pseudocódigo del proceso de generación

def generate_suggestions(context):
    suggestions = []
    
    # 1. Generar sugerencia por reducción de probabilidad
    if context['reduccion_tipo'] == 'probabilidad':
        suggestion = {
            'titulo': 'Reducción de Probabilidad',
            'descripcion': template_probabilidad.format(
                inherent_prob=context['inherent_risk']['probabilidad'],
                residual_prob=context['residual_risk']['probabilidad'],
                controles=', '.join(context['controles'])
            ),
            'norma': 'ISO 27005',
            'articulo': 'A.6.1.2',
            'confianza': calculate_confidence(context)
        }
        suggestions.append(suggestion)
    
    # 2. Generar sugerencia por reducción de impacto
    if context['reduccion_tipo'] == 'impacto':
        # Similar proceso...
    
    # 3. Generar sugerencia por reducción general
    if context['reduccion_tipo'] == 'nivel':
        # Similar proceso...
    
    return suggestions
```

### Ejemplo de Flujo Completo

```
┌─────────────────────────────────────────────────────────────┐
│  EJEMPLO: Generación de Justificación Residual            │
└─────────────────────────────────────────────────────────────┘

INPUT:
  • Riesgo Inherente: Probabilidad=Media(3), Impacto=Alto(4), Nivel=Alto
  • Riesgo Residual: Probabilidad=Baja(2), Impacto=Medio(3), Nivel=Medio
  • Controles: ["Backup Automatizado", "Monitoreo Continuo"]

PROCESO RAG:

  1. RETRIEVAL:
     ├─ Buscar controles en BD
     ├─ Obtener: Backup Automatizado → ISO 27002 A.12.3
     └─ Obtener: Monitoreo Continuo → ISO 27002 A.12.4

  2. CONTEXT ENRICHMENT:
     ├─ Identificar: Reducción de Probabilidad (3→2)
     ├─ Identificar: Reducción de Impacto (4→3)
     └─ Identificar: Reducción de Nivel (Alto→Medio)

  3. GENERATION:
     ├─ Plantilla: "Los controles {controles} han reducido..."
     ├─ Inyección: Insertar datos específicos
     └─ ISO Compliance: Agregar referencias ISO 27005 A.8.1

OUTPUT:
  {
    "titulo": "Reducción del Nivel de Riesgo",
    "descripcion": "El nivel de riesgo se ha reducido de Alto a Medio. 
                    Los controles implementados ('Backup Automatizado' 
                    conforme a ISO 27002:A.12.3 y 'Monitoreo Continuo' 
                    conforme a ISO 27002:A.12.4) han demostrado su 
                    eficacia en la mitigación del riesgo.",
    "norma": "ISO 27005",
    "articulo": "A.8.1",
    "confianza": 0.90
  }
```

---

## ⚖️ Marco Legal Colombia

El sistema SGRI cumple con el marco legal y normativo colombiano para la gestión de riesgos de seguridad de la información:

### 📜 Normativas Aplicables

```
┌─────────────────────────────────────────────────────────┐
│         MARCO LEGAL COLOMBIANO                           │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  🏛️ Política de Gobierno Digital                        │
│     • Decreto 767 de 2022                               │
│                                                          │
│  🛡️ Política de Seguridad Digital                       │
│     • Documento CONPES 3995 de 2020                     │
│     • Resolución 500 de 2021                            │
│     • Resolución 2277 de 2025                            │
│                                                          │
│  🔒 Protección de Datos Personales                      │
│     • Ley 1581 de 2012                                  │
│                                                          │
│  ⚠️ Delitos Informáticos                                │
│     • Ley 1273 de 2009                                  │
│                                                          │
│  🌐 Estándares Internacionales                         │
│     • ISO 27001:2022                                    │
│     • ISO 27002:2022                                    │
│     • ISO 27005:2022                                    │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 🎯 Cumplimiento Normativo

| Requisito | Normativa | Módulo SGRI |
|-----------|-----------|-------------|
| Gestión de activos | Res. 500, CONPES 3995 | ✅ Módulo Activos |
| Evaluación de riesgos | Res. 500, Res. 2277, ISO 27005 | ✅ Módulo Evaluación |
| Clasificación información | Res. 500, Ley 1581 | ✅ Clasificación CIA |
| Controles de seguridad | Res. 500, ISO 27002 | ✅ Módulo Controles |
| Gestión de incidentes | Res. 500, Ley 1273 | ✅ Módulo Incidentes |
| Justificación evaluaciones | Res. 2277, ISO 27005 | ✅ Sistema RAG |
| Reportes cumplimiento | Decreto 767, CONPES 3995 | ✅ Dashboard + Exportación |

### 🔗 Integración con Sistema RAG

El sistema RAG genera justificaciones que incluyen referencias tanto a:
- **Normativa ISO** (27001, 27002, 27005)
- **Marco legal colombiano** (Decretos, Resoluciones, Leyes)

**Ejemplo de justificación con marco legal**:

```
"La evaluación residual considera la reducción del riesgo desde 
Alto a Medio mediante la implementación de controles de seguridad 
conforme a:

• ISO 27005:2022 A.8.1 - Gestión de Riesgos Residuales
• Resolución 2277 de 2025 - Requisitos de Evaluación Residual
• Resolución 500 de 2021 - Controles Mínimos de Seguridad
• CONPES 3995 de 2020 - Política de Seguridad Digital

Los controles implementados han demostrado eficacia en la 
mitigación del riesgo conforme a los requisitos establecidos 
en el marco normativo colombiano."
```

📖 **Documentación completa**: Ver [Marco Legal Colombia](MARCO_LEGAL_COLOMBIA.md)

---

## 🔄 Flujo de Datos

```
┌─────────────────────────────────────────────────────────────┐
│              FLUJO DE DATOS EN EL SISTEMA                  │
└─────────────────────────────────────────────────────────────┘

    Usuario
      │
      │ 1. Acción (Crear/Editar/Consultar)
      ▼
    Frontend (React)
      │
      │ 2. HTTP Request (JSON)
      ▼
    Backend API (Flask)
      │
      │ 3. Validación y Procesamiento
      ▼
    ┌─────────────────┐
    │  ¿Requiere RAG?  │
    └────────┬─────────┘
             │
        ┌────┴────┐
        │         │
       SÍ        NO
        │         │
        ▼         ▼
    ┌─────────┐ ┌──────────────┐
    │ RAG     │ │ Servicio     │
    │ Engine  │ │ Normal       │
    └────┬────┘ └──────┬───────┘
         │             │
         │             │
         └──────┬──────┘
                │
                ▼
         ┌──────────────┐
         │  SQLAlchemy  │
         │     ORM      │
         └──────┬───────┘
                │
                ▼
         ┌──────────────┐
         │    MySQL     │
         │  Database    │
         └──────────────┘
                │
                │ 4. Response (JSON)
                ▼
         Backend API
                │
                │ 5. HTTP Response
                ▼
         Frontend
                │
                │ 6. Render UI
                ▼
         Usuario
```

---

## 🛠️ Tecnologías

### Backend

```
┌─────────────────────────────────────────────────────────┐
│                    STACK BACKEND                         │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  • Python 3.8+                                          │
│  • Flask 2.3+ (Framework web)                           │
│  • SQLAlchemy (ORM)                                     │
│  • MySQL 8.0+ (Base de datos)                           │
│  • Flask-CORS (Cross-Origin)                            │
│  • python-dotenv (Configuración)                        │
│  • bcrypt (Hashing de contraseñas)                      │
│  • PyJWT (Autenticación JWT)                            │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Frontend

```
┌─────────────────────────────────────────────────────────┐
│                    STACK FRONTEND                        │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  • React 18+ (Framework UI)                             │
│  • TypeScript (Tipado estático)                         │
│  • Material-UI (MUI) (Componentes)                      │
│  • React Query (Gestión de estado)                      │
│  • React Router (Navegación)                            │
│  • Axios (HTTP Client)                                  │
│  • Recharts (Gráficos)                                  │
│  • jsPDF (Exportación PDF)                              │
│  • XLSX (Exportación Excel)                             │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Base de Datos

```
┌─────────────────────────────────────────────────────────┐
│                  ESTRUCTURA BD                          │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  Tablas Principales:                                    │
│    • activos                                            │
│    • riesgos                                            │
│    • riesgo_activo                                      │
│    • evaluacion_riesgo_activo                           │
│    • controles_seguridad                                │
│    • incidentes                                         │
│    • usuarios_sistema                                    │
│    • niveles_probabilidad                               │
│    • niveles_impacto                                    │
│    • nivelesriesgo                                      │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

---

## 🚀 Inicio Rápido

### Prerrequisitos

- Python 3.8+
- Node.js 18+
- MySQL 8.0+
- Git

### Instalación

```bash
# 1. Clonar repositorio
git clone <repository-url>
cd sgsri

# 2. Configurar Backend
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

# 3. Configurar Base de Datos
# Editar .env con credenciales MySQL
python setup_db.py

# 4. Configurar Frontend
cd ../frontend
npm install

# 5. Iniciar Servidores
# Terminal 1 - Backend
cd backend
python run.py

# Terminal 2 - Frontend
cd frontend
npm run dev
```

### Acceso

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:5000
- **Credenciales**: admin / admin123

---

## 📚 Documentación

- [Guía de Evaluación de Riesgos](GUIA_EVALUACION_RIESGOS.md)
- [Marco Legal Colombia](MARCO_LEGAL_COLOMBIA.md) - Cumplimiento normativo
- [Configuración de Base de Datos](CONFIGURACION_BD.md)
- [API Documentation](backend/API_DOCUMENTATION.md)

---

## 📄 Licencia

Este proyecto está desarrollado para la Universidad de Nariño.

---

<div align="center">

**Desarrollado con ❤️ para la gestión de riesgos de seguridad de la información**

```
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║     Sistema de Gestión de Riesgos de Información (SGRI)     ║
║     Universidad de Nariño                                   ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
```

</div>
