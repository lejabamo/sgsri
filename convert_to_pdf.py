#!/usr/bin/env python3
"""
Script para convertir README.md a PDF
Usa markdown2 y xhtml2pdf para generar un PDF bien formateado (compatible con Windows)
"""

import os
import sys
import subprocess

def install_requirements():
    """Instala las dependencias necesarias"""
    packages = ['markdown2', 'xhtml2pdf']
    for package in packages:
        try:
            if package == 'xhtml2pdf':
                __import__('xhtml2pdf')
            else:
                __import__(package.replace('-', '_'))
        except ImportError:
            print(f"Instalando {package}...")
            subprocess.check_call([sys.executable, '-m', 'pip', 'install', package])

def markdown_to_pdf(markdown_file, output_pdf):
    """Convierte un archivo Markdown a PDF"""
    try:
        import markdown2
        from xhtml2pdf import pisa
        
        # Leer el archivo markdown
        with open(markdown_file, 'r', encoding='utf-8') as f:
            markdown_content = f.read()
        
        # Convertir markdown a HTML
        html_content = markdown2.markdown(
            markdown_content,
            extras=['fenced-code-blocks', 'tables', 'code-friendly', 'break-on-newline']
        )
        
        # Crear HTML completo con estilos
        html_template = f"""
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <style>
                @page {{
                    size: A4;
                    margin: 2cm;
                }}
                body {{
                    font-family: Arial, sans-serif;
                    line-height: 1.6;
                    color: #333;
                    max-width: 100%;
                }}
                h1 {{
                    color: #1a73e8;
                    border-bottom: 3px solid #1a73e8;
                    padding-bottom: 10px;
                }}
                h2 {{
                    color: #34a853;
                    margin-top: 30px;
                }}
                h3 {{
                    color: #ea4335;
                    margin-top: 25px;
                }}
                h4 {{
                    color: #fbbc04;
                    margin-top: 20px;
                }}
                code {{
                    background-color: #f5f5f5;
                    padding: 2px 6px;
                    border-radius: 3px;
                    font-family: 'Courier New', monospace;
                    font-size: 0.9em;
                }}
                pre {{
                    background-color: #f5f5f5;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    padding: 15px;
                    overflow-x: auto;
                    font-family: 'Courier New', monospace;
                    font-size: 0.85em;
                    line-height: 1.4;
                }}
                pre code {{
                    background-color: transparent;
                    padding: 0;
                }}
                table {{
                    border-collapse: collapse;
                    width: 100%;
                    margin: 20px 0;
                }}
                table th, table td {{
                    border: 1px solid #ddd;
                    padding: 12px;
                    text-align: left;
                }}
                table th {{
                    background-color: #1a73e8;
                    color: white;
                    font-weight: bold;
                }}
                table tr:nth-child(even) {{
                    background-color: #f9f9f9;
                }}
                ul, ol {{
                    margin: 15px 0;
                    padding-left: 30px;
                }}
                li {{
                    margin: 8px 0;
                }}
                blockquote {{
                    border-left: 4px solid #1a73e8;
                    margin: 20px 0;
                    padding-left: 20px;
                    color: #666;
                    font-style: italic;
                }}
                hr {{
                    border: none;
                    border-top: 2px solid #ddd;
                    margin: 30px 0;
                }}
                .center {{
                    text-align: center;
                }}
                a {{
                    color: #1a73e8;
                    text-decoration: none;
                }}
            </style>
        </head>
        <body>
            {html_content}
        </body>
        </html>
        """
        
        # Generar PDF
        print(f"Generando PDF desde {markdown_file}...")
        with open(output_pdf, 'w+b') as pdf_file:
            pisa_status = pisa.CreatePDF(
                html_template,
                dest=pdf_file,
                encoding='utf-8'
            )
        
        if pisa_status.err:
            print(f"⚠️ Advertencias durante la generación del PDF")
        
        print(f"✅ PDF generado exitosamente: {output_pdf}")
        return True
        
    except Exception as e:
        print(f"❌ Error al generar PDF: {str(e)}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    markdown_file = "README.md"
    output_pdf = "README_SGRI.pdf"
    
    if not os.path.exists(markdown_file):
        print(f"❌ Error: No se encontró el archivo {markdown_file}")
        sys.exit(1)
    
    print("Instalando dependencias necesarias...")
    install_requirements()
    
    print(f"\nConvirtiendo {markdown_file} a PDF...")
    if markdown_to_pdf(markdown_file, output_pdf):
        print(f"\n✅ ¡Conversión completada! El archivo PDF está en: {output_pdf}")
    else:
        print("\n❌ La conversión falló.")
        sys.exit(1)

