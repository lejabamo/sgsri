#!/usr/bin/env python3
"""
Script para generar imagen JPG del diagrama Mermaid de AuditorIA
Usa la API de Mermaid.ink para renderizar el diagrama
"""

import requests
import base64
import urllib.parse
from pathlib import Path

def obtener_codigo_mermaid():
    """Lee el código Mermaid del archivo markdown"""
    mermaid_code = """
graph LR
    %% Definir estilos
    classDef userStyle fill:#e1f5ff,stroke:#01579b,stroke-width:2px,color:#000
    classDef systemStyle fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,color:#000
    classDef aiStyle fill:#fff3e0,stroke:#e65100,stroke-width:3px,color:#000
    classDef dbStyle fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px,color:#000
    classDef externalStyle fill:#fce4ec,stroke:#880e4f,stroke-width:2px,color:#000
    classDef vectorStyle fill:#fff9c4,stroke:#f57f17,stroke-width:2px,color:#000
    classDef etlStyle fill:#e1bee7,stroke:#6a1b9a,stroke-width:2px,color:#000

    %% === COLUMNA IZQUIERDA: EXTERNO Y ETL ===
    subgraph LeftCol[" "]
        direction TB
        GLPI["🔌 GLPI<br/>Hardware • Software"]
        ModuloETL["🔄 Módulo ETL<br/>Extract • Transform • Load"]
        MySQL["🗄️ MySQL<br/>Activos • Riesgos"]
    end
    
    class GLPI externalStyle
    class ModuloETL etlStyle
    class MySQL dbStyle

    %% === COLUMNA CENTRAL: APLICACIÓN ===
    subgraph CenterCol[" "]
        direction TB
        GestorRiesgos["👤 Gestor de Riesgos"]
        Frontend["⚛️ Frontend React<br/>Wizard • Dashboard"]
        BackendAPI["🔧 Backend API<br/>REST Services"]
    end
    
    class GestorRiesgos userStyle
    class Frontend systemStyle
    class BackendAPI systemStyle

    %% === COLUMNA DERECHA: IA Y VECTOR ===
    subgraph RightCol[" "]
        direction TB
        MotorRAG["🤖 Motor RAG / IA<br/>Sugerencias ISO<br/>Justificaciones"]
        VectorDB["📊 Vector DB<br/>Embeddings ISO"]
    end
    
    class MotorRAG aiStyle
    class VectorDB vectorStyle

    %% === CONEXIONES VERTICALES EN CADA COLUMNA ===
    GLPI -->|"MySQL/SQL"| ModuloETL
    ModuloETL -->|"SQL INSERT"| MySQL
    
    GestorRiesgos -->|"HTTPS/JSON"| Frontend
    Frontend -->|"HTTPS/JSON"| BackendAPI
    
    MotorRAG -->|"API/Embeddings"| VectorDB
    VectorDB -->|"Vectores"| MotorRAG

    %% === CONEXIONES HORIZONTALES ENTRE COLUMNAS ===
    BackendAPI -->|"HTTP/JSON"| MotorRAG
    MotorRAG -->|"HTTP/JSON"| BackendAPI
    BackendAPI -->|"SQL/ORM"| MySQL
    MySQL -->|"ResultSet"| BackendAPI

    %% Estilo de las flechas
    linkStyle 0 stroke:#880e4f,stroke-width:2px
    linkStyle 1 stroke:#6a1b9a,stroke-width:2px
    linkStyle 2 stroke:#01579b,stroke-width:2px
    linkStyle 3 stroke:#4a148c,stroke-width:2px
    linkStyle 4 stroke:#e65100,stroke-width:3px
    linkStyle 5 stroke:#f57f17,stroke-width:2px
    linkStyle 6 stroke:#e65100,stroke-width:3px
    linkStyle 7 stroke:#e65100,stroke-width:3px
    linkStyle 8 stroke:#1b5e20,stroke-width:2px
    linkStyle 9 stroke:#1b5e20,stroke-width:2px
    """
    return mermaid_code.strip()

def generar_imagen_mermaid_api(mermaid_code):
    """Genera imagen usando la API de Mermaid.ink"""
    try:
        # Codificar el diagrama en base64
        encoded = base64.urlsafe_b64encode(mermaid_code.encode('utf-8')).decode('utf-8')
        # Remover padding
        encoded = encoded.rstrip('=')
        
        url = f"https://mermaid.ink/img/{encoded}"
        
        print("Generando imagen desde API de Mermaid...")
        response = requests.get(url, timeout=30)
        
        if response.status_code == 200:
            return response.content
        else:
            print(f"Error en API: {response.status_code}")
            return None
    except Exception as e:
        print(f"Error al generar imagen: {e}")
        return None

def generar_imagen_playwright(mermaid_code):
    """Genera imagen usando Playwright (requiere instalación)"""
    try:
        from playwright.sync_api import sync_playwright
        
        html_content = f"""
        <!DOCTYPE html>
        <html>
        <head>
            <script type="module">
                import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
                mermaid.initialize({{ startOnLoad: true }});
            </script>
        </head>
        <body>
            <div class="mermaid">
{mermaid_code}
            </div>
        </body>
        </html>
        """
        
        with sync_playwright() as p:
            browser = p.chromium.launch()
            page = browser.new_page()
            page.set_content(html_content)
            page.wait_for_selector('.mermaid svg', timeout=10000)
            screenshot = page.screenshot(type='jpeg', quality=90, full_page=True)
            browser.close()
            return screenshot
    except ImportError:
        print("Playwright no está instalado. Instalando...")
        return None
    except Exception as e:
        print(f"Error con Playwright: {e}")
        return None

def main():
    print("=" * 60)
    print("Generador de Imagen JPG - Diagrama AuditorIA")
    print("=" * 60)
    
    mermaid_code = obtener_codigo_mermaid()
    
    # Intentar con API primero
    print("\n[1/2] Intentando generar imagen con API de Mermaid...")
    imagen_data = generar_imagen_mermaid_api(mermaid_code)
    
    if imagen_data:
        output_file = "AuditorIA_Smart_Context_Diagram.jpg"
        with open(output_file, 'wb') as f:
            f.write(imagen_data)
        print(f"✅ Imagen generada exitosamente: {output_file}")
        print(f"   Tamaño: {len(imagen_data)} bytes")
        return
    
    # Si falla, intentar con Playwright
    print("\n[2/2] Intentando con Playwright...")
    try:
        import subprocess
        import sys
        
        print("Instalando Playwright...")
        subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'playwright', '--quiet'])
        subprocess.check_call(['playwright', 'install', 'chromium', '--quiet'])
        
        imagen_data = generar_imagen_playwright(mermaid_code)
        if imagen_data:
            output_file = "AuditorIA_Smart_Context_Diagram.jpg"
            with open(output_file, 'wb') as f:
                f.write(imagen_data)
            print(f"✅ Imagen generada exitosamente: {output_file}")
            return
    except Exception as e:
        print(f"Error con Playwright: {e}")
    
    print("\n❌ No se pudo generar la imagen automáticamente.")
    print("\n💡 Alternativa manual:")
    print("   1. Abre 'visualizar_auditoria_diagrama.html' en tu navegador")
    print("   2. Haz clic derecho en el diagrama")
    print("   3. Selecciona 'Guardar imagen como...' o usa Snipping Tool")

if __name__ == "__main__":
    main()

