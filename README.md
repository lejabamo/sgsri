# 🛡️ SmartAuditorIA - Sistema de Gestión de Riesgos Basado en IA

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║     ███████╗███╗   ███╗ █████╗ ██████╗ ████████╗██╗   ██╗██████╗ ██╗ █████╗ ║
║     ██╔════╝████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██║██╔══██╗║
║     ███████╗██╔████╔██║███████║██████╔╝   ██║   ██║   ██║██║  ██║██║███████║║
║     ╚════██║██║╚██╔╝██║██╔══██║██╔══██╗   ██║   ██║   ██║██║  ██║██║██╔══██║║
║     ███████║██║ ╚═╝ ██║██║  ██║██║  ██║   ██║   ╚██████╔╝██████╔╝██║██║  ██║║
║     ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═╝║
║                                                                              ║
║          Sistema de Gestión de Riesgos de Información                        ║
║          Basado en Inteligencia Artificial Generativa                       ║
║          Cumplimiento ISO 27001/27002/27005 y Marco Legal Colombiano        ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/Flask-2.3+-green.svg)](https://flask.palletsprojects.com/)
[![React](https://img.shields.io/badge/React-18+-61dafb.svg)](https://reactjs.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-orange.svg)](https://www.mysql.com/)
[![ISO 27001](https://img.shields.io/badge/ISO-27001%2F27002%2F27005-red.svg)](https://www.iso.org/)
[![RAG](https://img.shields.io/badge/AI-RAG%20System-purple.svg)](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)
[![GitHub Pages](https://img.shields.io/badge/GitHub-Pages-brightgreen.svg)](https://lejabamo.github.io/sgsri/)

**Universidad del Valle** | **Escuela de Ingeniería de Sistemas y Computación**  
**Maestría en Computación para el Desarrollo de Aplicaciones Inteligentes**  
**Materia:** Trabajo integrador 1  
**Autor:** Ing. Leonardo Javier Bastidas Moreno

</div>

---

## 📋 Tabla de Contenidos

- [🎯 Visión General](#-visión-general)
- [🌟 Características Principales](#-características-principales)
- [🏗️ Arquitectura del Sistema](#️-arquitectura-del-sistema)
- [🤖 Sistema RAG (Retrieval Augmented Generation)](#-sistema-rag-retrieval-augmented-generation)
- [📊 Smart Context Diagram](#-smart-context-diagram)
- [📱 Wireframe y Storyboard](#-wireframe-y-storyboard)
- [⚖️ Marco Legal y Normativo](#️-marco-legal-y-normativo)
- [🛠️ Stack Tecnológico](#️-stack-tecnológico)
- [🚀 Inicio Rápido](#-inicio-rápido)
- [📚 Documentación](#-documentación)
- [🌐 GitHub Pages](#-github-pages)
- [📄 Licencia](#-licencia)

---

## 🎯 Visión General

**SmartAuditorIA** (anteriormente SGRI) es una plataforma integral para la gestión de riesgos de seguridad de la información que combina tecnologías tradicionales con **Inteligencia Artificial Generativa** mediante **RAG (Retrieval Augmented Generation)**.

### ¿Por qué es una "Smart App"?

SmartAuditorIA clasifica como una **Smart App** porque:

1. **🧠 Conciencia de Contexto**: El sistema "sabe" qué norma legal aplicar según el contexto del riesgo, utilizando búsqueda semántica en bases de conocimiento ISO y marco legal colombiano.

2. **⚡ Toma de Decisiones**: Sugiere controles de seguridad mediante análisis inteligente, calcula niveles de confianza y genera justificaciones normativas automáticamente.

3. **🔄 Aprendizaje Continuo**: El motor RAG mejora sus sugerencias basándose en el contexto de cada evaluación de riesgo.

---

## 🌟 Características Principales

### ✅ Gestión Completa de Activos
- Inventario completo de activos de información
- Clasificación por tipo (Hardware, Software, Datos, Usuarios)
- Niveles de criticidad (Muy Alto, Alto, Medio, Bajo)
- Clasificación CIA (Confidencialidad, Integridad, Disponibilidad)
- Integración con GLPI mediante módulo ETL

### ✅ Evaluación de Riesgos Inteligente
- Wizard interactivo paso a paso
- Evaluación inherente y residual
- **Sugerencias IA** de amenazas, vulnerabilidades y controles
- **Justificaciones automáticas** basadas en ISO 27005 y marco legal colombiano
- Matriz de riesgos interactiva

### ✅ Sistema RAG para Justificaciones
- **Retrieval**: Búsqueda semántica en base de conocimiento ISO
- **Augmented**: Enriquecimiento de contexto con normativa
- **Generation**: Generación de justificaciones normativas automáticas
- Múltiples perspectivas de justificación (probabilidad, impacto, eficacia)
- Niveles de confianza calculados (0-1)

### ✅ Dashboard Analítico
- Métricas en tiempo real
- Gráficos de tendencias
- Top riesgos críticos
- Visualización de matriz de riesgos
- Exportación a PDF/Excel

### ✅ Gestión de Incidentes
- Registro de incidentes de seguridad
- Clasificación por tipo y severidad
- Asociación con activos afectados
- Seguimiento y resolución

### ✅ Cumplimiento Normativo
- ISO 27001:2022, ISO 27002:2022, ISO 27005:2022
- Decreto 767 de 2022 (Política de Gobierno Digital)
- CONPES 3995 de 2020 (Política de Seguridad Digital)
- Resolución 500 de 2021 y Resolución 2277 de 2025
- Ley 1581 de 2012 (Protección de Datos Personales)
- Ley 1273 de 2009 (Delitos Informáticos)

---

## 🏗️ Arquitectura del Sistema

### Smart Context Diagram (C4 Model)

El sistema sigue el modelo de arquitectura C4, con los siguientes componentes principales:

```
┌─────────────────────────────────────────────────────────────────┐
│                    ARQUITECTURA SMART AUDITORIA                 │
└─────────────────────────────────────────────────────────────────┘

    ┌──────────────┐
    │ 👤 Gestor    │
    │ de Riesgos   │
    └──────┬───────┘
           │ HTTPS/JSON
           ▼
    ┌──────────────────────────────────────────────────┐
    │         ⚛️ Frontend React                         │
    │  • Wizard de Evaluación                          │
    │  • Dashboard Interactivo                          │
    │  • Gestión de Activos                            │
    └──────────────┬───────────────────────────────────┘
                   │ HTTPS/JSON
                   ▼
    ┌──────────────────────────────────────────────────┐
    │         🔧 Backend Flask API                     │
    │  • REST Services                                 │
    │  • SQLAlchemy ORM                                │
    │  • Autenticación JWT                             │
    └──────┬───────────────────────┬──────────────────┘
           │                       │
           │ HTTP/JSON             │ SQL/ORM
           ▼                       ▼
    ┌──────────────┐        ┌──────────────┐
    │ 🤖 Motor RAG│        │ 🗄️ MySQL     │
    │ / Servicio  │        │ Base de      │
    │    de IA    │        │ Datos        │
    └──────┬──────┘        └──────────────┘
           │
           │ API/Embeddings
           ▼
    ┌──────────────┐
    │ 📊 Vector DB │
    │ Embeddings   │
    │ ISO          │
    └──────────────┘

    ┌──────────────────────────────────────────────────┐
    │         🔄 Módulo ETL                            │
    │  Extract → Transform → Load                      │
    │  Sincronización con GLPI                         │
    └──────────────────────────────────────────────────┘
```

### Componentes Principales

#### 👤 Gestor de Riesgos
Usuario principal que interactúa con el sistema a través del frontend.

#### ⚛️ Frontend React
- **Tecnologías**: React 18+, TypeScript, Material-UI, React Query
- **Componentes**: Wizard, Dashboard, Gestión de Activos, Visualización de Riesgos

#### 🔧 Backend Flask API
- **Tecnologías**: Flask 2.3+, SQLAlchemy, PyJWT, Flask-CORS
- **Endpoints**: `/api/activos`, `/api/riesgos`, `/api/predictive/*`, `/api/dashboard`

#### 🤖 Motor RAG / Servicio de IA
- **Tecnologías**: Python, LangChain, sentence-transformers
- **Funcionalidades**:
  - Búsqueda semántica en base de conocimiento ISO
  - Generación de justificaciones normativas
  - Sugerencias inteligentes de controles
  - Cálculo de niveles de confianza

#### 🗄️ Base de Datos MySQL
- **Versión**: MySQL 8.0+
- **Tablas**: activos, riesgos, evaluacion_riesgo_activo, controles_seguridad, incidentes

#### 📊 Base de Datos Vectorial
- **Tecnologías**: ChromaDB / Pinecone (propuesto)
- **Uso**: Almacenamiento de embeddings para búsqueda semántica

#### 🔄 Módulo ETL
- **Funcionalidad**: Sincronización de datos desde GLPI
- **Proceso**: Extract → Transform → Load

---

## 🤖 Sistema RAG (Retrieval Augmented Generation)

### ¿Qué es RAG?

**RAG (Retrieval Augmented Generation)** es una técnica de IA que combina:
- **Retrieval (Recuperación)**: Búsqueda de información relevante en una base de conocimiento
- **Augmented (Aumentado)**: Enriquecimiento del contexto con información recuperada
- **Generation (Generación)**: Creación de respuestas o sugerencias basadas en el contexto

### Flujo RAG en SmartAuditorIA

```
1. Usuario solicita justificación de riesgo residual
   ↓
2. Context Extraction
   • Extrae datos del riesgo inherente
   • Extrae datos del riesgo residual
   • Identifica controles seleccionados
   ↓
3. Retrieval (Búsqueda Semántica)
   • Consulta Vector DB (embeddings ISO)
   • Consulta MySQL (controles ISO 27002)
   • Busca artículos ISO 27005 relevantes
   ↓
4. Generation (Generación Contextual)
   • Selecciona plantilla según tipo de reducción
   • Inyecta contexto (riesgos, controles, códigos ISO)
   • Genera múltiples justificaciones
   • Calcula niveles de confianza
   ↓
5. Respuesta al Usuario
   • Justificaciones normativas
   • Referencias ISO y marco legal
   • Niveles de confianza
```

### Endpoints RAG

- `POST /api/predictive/suggestions/threats` - Sugerencias de amenazas
- `POST /api/predictive/suggestions/vulnerabilities` - Sugerencias de vulnerabilidades
- `POST /api/predictive/suggestions/controls` - Sugerencias de controles
- `POST /api/predictive/suggestions/residual-justifications` - Justificaciones residuales

---

## 📊 Smart Context Diagram

### Visualización Interactiva

El Smart Context Diagram está disponible en **GitHub Pages** con visualización interactiva:

🌐 **Ver Diagrama**: [https://lejabamo.github.io/sgsri/](https://lejabamo.github.io/sgsri/)

El diagrama incluye:
- Diagrama de Contexto C4
- Flujo 1: Evaluación de Riesgos con RAG
- Flujo 2: Sincronización GLPI mediante ETL
- Flujo 3: Sugerencias Predictivas Inteligentes
- Wizard de Evaluación con IA
- Flujo RAG Detallado

### Archivos de Diagramas

- `AuditorIA_Smart_Context_Diagram.md` - Diagrama en formato Mermaid
- `docs/index.html` - Visualización interactiva en GitHub Pages
- `docs/assets/AuditorIA_Smart_Context_Diagram.jpg` - Imagen estática

---

## 📱 Wireframe y Storyboard

El proyecto incluye un **storyboard completo** con 18 pantallas que muestran el flujo completo de interacción del usuario:

🌐 **Ver Wireframe**: [https://lejabamo.github.io/sgsri/#wireframe](https://lejabamo.github.io/sgsri/#wireframe)

Las pantallas incluyen:
- Pantalla de inicio y autenticación
- Dashboard principal
- Gestión de activos
- Wizard de evaluación de riesgos
- Sugerencias IA
- Visualización de matriz de riesgos
- Gestión de controles
- Reportes y exportación

**Ubicación**: `docs/assets/wireframe-pantalla-*.jpeg`

---

## ⚖️ Marco Legal y Normativo

### Normativas ISO

- **ISO 27001:2022** - Sistemas de gestión de la seguridad de la información
- **ISO 27002:2022** - Controles de seguridad de la información
- **ISO 27005:2022** - Gestión de riesgos de seguridad de la información

### Marco Legal Colombiano

- **Decreto 767 de 2022** - Política de Gobierno Digital
- **CONPES 3995 de 2020** - Política de Seguridad Digital
- **Resolución 500 de 2021** - Controles mínimos de seguridad
- **Resolución 2277 de 2025** - Requisitos de evaluación residual
- **Ley 1581 de 2012** - Protección de datos personales
- **Ley 1273 de 2009** - Delitos informáticos

📖 **Documentación completa**: Ver [MARCO_LEGAL_COLOMBIA.md](MARCO_LEGAL_COLOMBIA.md)

---

## 🛠️ Stack Tecnológico

### Backend

```
• Python 3.8+
• Flask 2.3+ (Framework web)
• SQLAlchemy (ORM)
• MySQL 8.0+ (Base de datos)
• Flask-CORS (Cross-Origin)
• PyJWT (Autenticación JWT)
• bcrypt (Hashing de contraseñas)
• python-dotenv (Configuración)
```

### Frontend

```
• React 18+ (Framework UI)
• TypeScript (Tipado estático)
• Material-UI (MUI) (Componentes)
• React Query (Gestión de estado)
• React Router (Navegación)
• Axios (HTTP Client)
• Recharts (Gráficos)
• jsPDF (Exportación PDF)
• XLSX (Exportación Excel)
```

### IA y RAG

```
• LangChain (Framework RAG)
• sentence-transformers (Embeddings)
• ChromaDB / Pinecone (Vector DB)
• Template-based Generation
```

### DevOps

```
• GitHub Actions (CI/CD)
• GitHub Pages (Documentación)
• Mermaid.js (Diagramas)
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
git clone https://github.com/lejabamo/sgsri.git
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
- **Credenciales por defecto**: admin / admin123

---

## 📚 Documentación

### Documentación Principal

- [📖 Guía de Evaluación de Riesgos](GUIA_EVALUACION_RIESGOS.md)
- [⚖️ Marco Legal Colombia](MARCO_LEGAL_COLOMBIA.md)
- [🗄️ Configuración de Base de Datos](CONFIGURACION_BD.md)
- [🔌 Conexión de Red](CONEXION_RED.md)
- [🚀 Guía de Despliegue](DEPLOY.md)

### Documentación Técnica

- [🏗️ Smart Context Diagram](AuditorIA_Smart_Context_Diagram.md)
- [🤖 Sistema Predictivo](SISTEMA_PREDICTIVO_README.md)
- [🔄 Flujo Técnico RAG](FLUJO_TECNICO_RAG_JUSTIFICACIONES.md)
- [📋 Justificación Smart App](JUSTIFICACION_SMART_APP_SGRI.md)
- [🔧 API Documentation](backend/API_DOCUMENTATION.md)

### Documentación de GitHub Pages

- [🌐 GitHub Pages Setup](GITHUB_PAGES_SETUP.md)
- [🚀 Launch01 Branch](LAUNCH01_GITHUB_PAGES.md)

---

## 🌐 GitHub Pages

### Documentación en Línea

El proyecto tiene documentación interactiva disponible en **GitHub Pages**:

🌐 **URL Principal**: [https://lejabamo.github.io/sgsri/](https://lejabamo.github.io/sgsri/)

### Contenido Disponible

- ✅ Portada académica
- ✅ Smart Context Diagram (6 diagramas interactivos)
- ✅ Wireframe y Storyboard (18 pantallas)
- ✅ Componentes Inteligentes
- ✅ Marco Normativo
- ✅ Diagramas de Flujo Técnico
- ✅ Exportación a PDF

### Configuración

- **Rama**: `launch01`
- **Carpeta**: `/docs`
- **Workflow**: `.github/workflows/pages.yml`

### Links Importantes

- **Repositorio**: [https://github.com/lejabamo/sgsri](https://github.com/lejabamo/sgsri)
- **Rama launch01**: [https://github.com/lejabamo/sgsri/tree/launch01](https://github.com/lejabamo/sgsri/tree/launch01)
- **Settings Pages**: [https://github.com/lejabamo/sgsri/settings/pages](https://github.com/lejabamo/sgsri/settings/pages)
- **GitHub Actions**: [https://github.com/lejabamo/sgsri/actions](https://github.com/lejabamo/sgsri/actions)

---

## 📦 Estructura del Proyecto

```
sgsri/
├── backend/                 # Backend Flask
│   ├── app/
│   │   ├── routes/         # API endpoints
│   │   ├── services/       # Servicios de negocio
│   │   │   └── predictive/ # Servicio RAG
│   │   ├── models/         # Modelos SQLAlchemy
│   │   └── utils/          # Utilidades
│   ├── requirements.txt
│   └── run.py
├── frontend/                # Frontend React
│   ├── src/
│   │   ├── components/     # Componentes React
│   │   ├── pages/          # Páginas
│   │   ├── services/       # Servicios API
│   │   └── utils/          # Utilidades
│   └── package.json
├── docs/                    # GitHub Pages
│   ├── index.html          # Documentación interactiva
│   └── assets/             # Imágenes y recursos
│       ├── wireframe-pantalla-*.jpeg
│       └── AuditorIA_Smart_Context_Diagram.jpg
├── etl_scripts/            # Scripts ETL para GLPI
├── .github/
│   └── workflows/
│       └── pages.yml       # GitHub Actions
├── README.md               # Este archivo
└── [Documentación adicional]
```

---

## 🤝 Contribución

Este proyecto es parte del trabajo académico de la **Maestría en Computación para el Desarrollo de Aplicaciones Inteligentes** de la **Universidad del Valle**.

### Autor

**Ing. Leonardo Javier Bastidas Moreno**

- **Universidad**: Universidad del Valle
- **Escuela**: Escuela de Ingeniería de Sistemas y Computación
- **Programa**: Maestría en Computación para el Desarrollo de Aplicaciones Inteligentes
- **Materia**: Trabajo integrador 1

---

## 📄 Licencia

Este proyecto está desarrollado para fines académicos en el marco de la **Maestría en Computación para el Desarrollo de Aplicaciones Inteligentes** de la **Universidad del Valle**.

---

<div align="center">

**Desarrollado con ❤️ para la gestión inteligente de riesgos de seguridad de la información**

```
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║     SmartAuditorIA - Sistema de Gestión de Riesgos          ║
║     Basado en Inteligencia Artificial                        ║
║                                                              ║
║     Universidad del Valle                                    ║
║     Escuela de Ingeniería de Sistemas y Computación         ║
║     Maestría en Computación para el Desarrollo de           ║
║     Aplicaciones Inteligentes                               ║
║                                                              ║
║     Ing. Leonardo Javier Bastidas Moreno                    ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
```

[![GitHub](https://img.shields.io/badge/GitHub-Repository-black?logo=github)](https://github.com/lejabamo/sgsri)
[![GitHub Pages](https://img.shields.io/badge/GitHub-Pages-brightgreen?logo=github)](https://lejabamo.github.io/sgsri/)
[![ISO 27001](https://img.shields.io/badge/ISO-27001%2F27002%2F27005-red?logo=iso)](https://www.iso.org/)

</div>
