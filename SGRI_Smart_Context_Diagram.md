# 🏗️ Smart Context Diagram (SCD) - Sistema SGRI

## Diagrama de Contexto C4 - Arquitectura SGRI

```mermaid
graph TB
    %% Definir estilos
    classDef userStyle fill:#e1f5ff,stroke:#01579b,stroke-width:2px,color:#000
    classDef systemStyle fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,color:#000
    classDef aiStyle fill:#fff3e0,stroke:#e65100,stroke-width:3px,color:#000
    classDef dbStyle fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px,color:#000
    classDef externalStyle fill:#fce4ec,stroke:#880e4f,stroke-width:2px,color:#000
    classDef vectorStyle fill:#fff9c4,stroke:#f57f17,stroke-width:2px,color:#000

    %% Usuario
    GestorRiesgos["👤 Gestor de Riesgos<br/>Usuario del Sistema"]
    class GestorRiesgos userStyle

    %% Sistema Central
    SGRI["🛡️ SGRI<br/>Sistema de Gestión de<br/>Riesgos de Información<br/><br/>• Gestión de Activos<br/>• Evaluación de Riesgos<br/>• Dashboard Analytics<br/>• Gestión de Incidentes"]
    class SGRI systemStyle

    %% Frontend
    Frontend["⚛️ Frontend React<br/>Interfaz de Usuario<br/><br/>• Wizard de Evaluación<br/>• Dashboard Interactivo<br/>• Gestión de Activos<br/>• Visualización de Riesgos"]
    class Frontend systemStyle

    %% Backend
    BackendAPI["🔧 Backend Flask API<br/>Servicios REST<br/><br/>• /api/activos<br/>• /api/riesgos<br/>• /api/evaluacion<br/>• /api/dashboard"]
    class BackendAPI systemStyle

    %% Motor RAG / IA (Destacado)
    MotorRAG["🤖 Motor RAG / Servicio de IA<br/>Sistema Predictivo Inteligente<br/><br/>• Retrieval Augmented Generation<br/>• Sugerencias ISO 27005<br/>• Justificaciones Normativas<br/>• Búsqueda Semántica<br/>• Generación Contextual"]
    class MotorRAG aiStyle

    %% Base de Datos Principal
    MySQL["🗄️ Base de Datos MySQL<br/>Almacenamiento Principal<br/><br/>• Activos<br/>• Riesgos<br/>• Evaluaciones<br/>• Controles<br/>• Incidentes<br/>• Usuarios"]
    class MySQL dbStyle

    %% Base de Datos Vectorial
    VectorDB["📊 Base de Datos Vectorial<br/>Almacén de Embeddings<br/><br/>• Embeddings ISO 27001/27002/27005<br/>• Vectores de Controles<br/>• Vectores de Amenazas<br/>• Índices Semánticos"]
    class VectorDB vectorStyle

    %% Sistema Externo GLPI
    GLPI["🔌 GLPI<br/>Sistema de Gestión de<br/>Activos de TI<br/><br/>• Inventario Hardware<br/>• Inventario Software<br/>• Usuarios<br/>• Tickets"]
    class GLPI externalStyle

    %% Conexiones Usuario -> Sistema
    GestorRiesgos -->|"HTTPS/JSON<br/>Solicitudes de Gestión<br/>• Crear/Editar Activos<br/>• Evaluar Riesgos<br/>• Consultar Dashboard"| Frontend

    %% Conexiones Frontend -> Backend
    Frontend -->|"HTTPS/JSON<br/>API REST<br/>• Datos de Activos<br/>• Evaluaciones<br/>• Métricas Dashboard"| BackendAPI

    %% Conexiones Backend -> Motor RAG
    BackendAPI -->|"HTTP/JSON<br/>Solicitud de Justificación Normativa<br/>• Contexto de Riesgo<br/>• Controles Seleccionados<br/>• Tipo de Activo"| MotorRAG
    MotorRAG -->|"HTTP/JSON<br/>Sugerencias Generadas<br/>• Justificaciones ISO<br/>• Referencias Normativas<br/>• Nivel de Confianza"| BackendAPI

    %% Conexiones Motor RAG -> Vector DB
    MotorRAG -->|"API/Embeddings<br/>Búsqueda Semántica<br/>• Query Vectorial<br/>• Retrieval de Contexto<br/>• Similitud Coseno"| VectorDB
    VectorDB -->|"Vectores/JSON<br/>Resultados de Búsqueda<br/>• Documentos Relevantes<br/>• Scores de Similitud<br/>• Metadatos ISO"| MotorRAG

    %% Conexiones Backend -> MySQL
    BackendAPI -->|"SQL/SQLAlchemy ORM<br/>Operaciones CRUD<br/>• Consultas de Activos<br/>• Persistencia de Riesgos<br/>• Transacciones"| MySQL
    MySQL -->|"ResultSet/JSON<br/>Datos Estructurados<br/>• Registros de Activos<br/>• Evaluaciones<br/>• Métricas Agregadas"| BackendAPI

    %% Conexiones GLPI -> Backend (ETL)
    GLPI -->|"MySQL/ETL Scripts<br/>Sincronización de Activos<br/>• Extracción de Hardware<br/>• Extracción de Software<br/>• Extracción de Usuarios"| BackendAPI
    BackendAPI -->|"SQL INSERT/UPDATE<br/>Carga de Datos<br/>• Activos Sincronizados<br/>• Metadatos GLPI<br/>• IDs Externos"| MySQL

    %% Estilo de las flechas
    linkStyle 0 stroke:#01579b,stroke-width:2px
    linkStyle 1 stroke:#4a148c,stroke-width:2px
    linkStyle 2 stroke:#e65100,stroke-width:3px
    linkStyle 3 stroke:#e65100,stroke-width:3px
    linkStyle 4 stroke:#f57f17,stroke-width:2px
    linkStyle 5 stroke:#f57f17,stroke-width:2px
    linkStyle 6 stroke:#1b5e20,stroke-width:2px
    linkStyle 7 stroke:#1b5e20,stroke-width:2px
    linkStyle 8 stroke:#880e4f,stroke-width:2px
    linkStyle 9 stroke:#880e4f,stroke-width:2px
```

## 📋 Descripción de Componentes

### 👤 Gestor de Riesgos
**Rol**: Usuario principal del sistema que gestiona activos, evalúa riesgos y consulta dashboards.

**Interacciones**:
- Accede al sistema mediante navegador web
- Realiza operaciones CRUD sobre activos y riesgos
- Utiliza el wizard de evaluación paso a paso
- Consulta métricas y visualizaciones en el dashboard

---

### 🛡️ SGRI (Sistema Central)
**Descripción**: Plataforma integral para la gestión de riesgos de seguridad de la información.

**Funcionalidades Principales**:
- Gestión completa de activos de información
- Identificación y evaluación de riesgos
- Dashboard analítico con métricas
- Gestión de incidentes de seguridad
- Cumplimiento normativo (ISO 27001/27002/27005, Marco Legal Colombia)

---

### ⚛️ Frontend React
**Tecnologías**: React 18+, TypeScript, Material-UI, React Query

**Componentes Principales**:
- Wizard de Evaluación Interactivo
- Dashboard con gráficos y métricas
- Gestión de Activos (CRUD)
- Visualización de Matriz de Riesgos
- Panel de Sugerencias Predictivas

---

### 🔧 Backend Flask API
**Tecnologías**: Flask 2.3+, SQLAlchemy, PyJWT, Flask-CORS

**Endpoints Principales**:
- `/api/activos` - Gestión de activos
- `/api/riesgos` - Gestión de riesgos
- `/api/evaluacion` - Evaluación de riesgos
- `/api/predictive/*` - Servicios predictivos
- `/api/dashboard` - Métricas y analytics

---

### 🤖 Motor RAG / Servicio de IA
**Tecnologías**: Python, LangChain, LlamaIndex, sentence-transformers

**Funcionalidades**:
- **Retrieval**: Búsqueda semántica en base de conocimiento ISO
- **Augmented**: Enriquecimiento de contexto con normativa
- **Generation**: Generación de justificaciones basadas en ISO 27005
- Sugerencias inteligentes de amenazas, vulnerabilidades y controles
- Cálculo de niveles de confianza (0-1)

**Endpoints**:
- `/api/predictive/suggestions/threats` - Sugerencias de amenazas
- `/api/predictive/suggestions/vulnerabilities` - Sugerencias de vulnerabilidades
- `/api/predictive/suggestions/controls` - Sugerencias de controles
- `/api/predictive/suggestions/residual-justifications` - Justificaciones residuales

---

### 🗄️ Base de Datos MySQL
**Versión**: MySQL 8.0+

**Tablas Principales**:
- `activos` - Inventario de activos de información
- `riesgos` - Catálogo de riesgos
- `evaluacion_riesgo_activo` - Evaluaciones inherentes y residuales
- `controles_seguridad` - Catálogo de controles ISO 27002
- `incidentes` - Registro de incidentes de seguridad
- `usuarios_sistema` - Usuarios y autenticación

---

### 📊 Base de Datos Vectorial
**Tecnologías**: ChromaDB / Pinecone (propuesto), sentence-transformers

**Contenido**:
- Embeddings de documentos ISO 27001:2022
- Embeddings de documentos ISO 27002:2022
- Embeddings de documentos ISO 27005:2022
- Vectores de controles de seguridad
- Vectores de amenazas y vulnerabilidades
- Índices semánticos para búsqueda rápida

**Operaciones**:
- Inserción de embeddings de documentos procesados
- Búsqueda por similitud coseno
- Retrieval de contexto relevante para RAG

---

### 🔌 GLPI (Sistema Externo)
**Descripción**: Sistema de gestión de activos de TI (IT Asset Management)

**Datos Sincronizados**:
- Hardware (computadoras, servidores, dispositivos)
- Software (aplicaciones, licencias)
- Usuarios del sistema
- Tickets y estados

**Integración**:
- Scripts ETL (`etl_scripts/`) ejecutados periódicamente
- Extracción desde MySQL de GLPI
- Transformación y carga en SGRI
- Sincronización bidireccional de IDs externos

---

## 🔄 Flujos de Datos Principales

### 1. Flujo de Evaluación de Riesgos con RAG
```
Gestor de Riesgos 
  → Frontend (Wizard Step 5: Evaluación Residual)
    → Backend API (/api/predictive/suggestions/residual-justifications)
      → Motor RAG (Context Extraction)
        → Vector DB (Semantic Search)
          → Motor RAG (Generation)
            → Backend API (Sugerencias JSON)
              → Frontend (Mostrar Justificaciones)
                → Gestor de Riesgos (Seleccionar/Editar)
```

### 2. Flujo de Sincronización GLPI
```
GLPI (MySQL)
  → ETL Scripts (Extract)
    → Transform (Mapeo de datos)
      → Backend API (Load)
        → MySQL SGRI (Persistencia)
          → Frontend (Visualización actualizada)
```

### 3. Flujo de Sugerencias Predictivas
```
Frontend (Tipo de Activo seleccionado)
  → Backend API (/api/predictive/suggestions/threats)
    → Motor RAG (Knowledge Base Query)
      → MySQL (Controles ISO 27002)
      → Vector DB (Semantic Matching)
        → Motor RAG (Template Generation)
          → Backend API (Sugerencias con Confianza)
            → Frontend (Cards Interactivas)
```

---

## 🎨 Convenciones del Diagrama

- **Color Naranja (#fff3e0)**: Motor RAG / Servicio de IA (componente inteligente destacado)
- **Color Púrpura (#f3e5f5)**: Componentes del sistema SGRI
- **Color Verde (#e8f5e9)**: Bases de datos
- **Color Amarillo (#fff9c4)**: Base de datos vectorial
- **Color Rosa (#fce4ec)**: Sistemas externos
- **Color Azul (#e1f5ff)**: Usuarios

---

## 📝 Notas Técnicas

1. **Protocolos de Comunicación**:
   - Frontend ↔ Backend: HTTPS/JSON (REST API)
   - Backend ↔ Motor RAG: HTTP/JSON (Servicio interno)
   - Motor RAG ↔ Vector DB: API nativa (ChromaDB/Pinecone)
   - Backend ↔ MySQL: SQL/SQLAlchemy ORM
   - GLPI ↔ Backend: MySQL directo (ETL scripts)

2. **Tipos de Datos**:
   - **JSON**: Todas las comunicaciones API
   - **SQL ResultSet**: Consultas a bases de datos relacionales
   - **Vectores/Embeddings**: Comunicación con base vectorial
   - **Context Objects**: Objetos de contexto enriquecido para RAG

3. **Seguridad**:
   - Autenticación JWT en todas las APIs
   - CORS configurado para Frontend
   - Conexiones MySQL con autenticación nativa
   - Variables de entorno para credenciales

---

**Versión**: 1.0  
**Última Actualización**: 2025-01-12  
**Autor**: Arquitecto de Software SGRI

