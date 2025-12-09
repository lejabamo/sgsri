"""
Script para actualizar el presupuesto en el documento Word SmartAuditorIA_editado.docx
"""

from docx import Document
from docx.shared import Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
import re

def actualizar_presupuesto():
    """Actualiza el presupuesto en el documento Word"""
    
    # Abrir el documento
    doc = Document('SmartAuditorIA_editado.docx')
    
    # Valores nuevos
    valores_nuevos = {
        'desarrollador_mensual': '20.000.000',
        'desarrollador_total': '130.000.000',
        'infraestructura_total': '4.510.000',
        'hardware_total': '780.000',
        'formacion_total': '1.800.000',
        'dominio_total': '150.000',
        'total_general': '137.240.000'
    }
    
    # Patrones a buscar y reemplazar
    patrones = [
        # Valor mensual del desarrollador
        (r'8\.?000\.?000.*mes', f'{valores_nuevos["desarrollador_mensual"]} COP/mes'),
        (r'8M.*mes', f'{valores_nuevos["desarrollador_mensual"]} COP/mes'),
        (r'8\.?000\.?000.*COP.*mes', f'{valores_nuevos["desarrollador_mensual"]} COP/mes'),
        
        # Aporte total del desarrollador
        (r'52\.?000\.?000', valores_nuevos["desarrollador_total"]),
        (r'104\.?000\.?000', valores_nuevos["desarrollador_total"]),
        (r'aporte.*desarrollador.*\d+\.?\d*\.?\d*\.?\d*', f'Aporte de trabajo (ingeniero IA senior): {valores_nuevos["desarrollador_total"]}'),
        
        # Totales
        (r'1\.?67\.?000\.?000', valores_nuevos["infraestructura_total"]),
        (r'infraestructura.*\d+\.?\d*\.?\d*\.?\d*', f'Infraestructura y APIs: {valores_nuevos["infraestructura_total"]}'),
        
        # Hardware
        (r'hardware.*\d+\.?\d*\.?\d*\.?\d*', f'Hardware (depreciación): {valores_nuevos["hardware_total"]}'),
        
        # Formación
        (r'formación.*\d+\.?\d*\.?\d*\.?\d*', f'Formación y herramientas: {valores_nuevos["formacion_total"]}'),
        
        # Total general
        (r'total.*\d+\.?\d*\.?\d*\.?\d*', f'TOTAL REAL: {valores_nuevos["total_general"]}'),
    ]
    
    # Recorrer todos los párrafos
    for paragraph in doc.paragraphs:
        texto_original = paragraph.text
        
        # Aplicar reemplazos
        for patron, reemplazo in patrones:
            if re.search(patron, texto_original, re.IGNORECASE):
                nuevo_texto = re.sub(patron, reemplazo, texto_original, flags=re.IGNORECASE)
                paragraph.text = nuevo_texto
                print(f"Actualizado: {texto_original[:50]}... -> {nuevo_texto[:50]}...")
    
    # Recorrer todas las tablas
    for table in doc.tables:
        for row in table.rows:
            for cell in row.cells:
                texto_celda = cell.text
                
                # Aplicar reemplazos en celdas
                for patron, reemplazo in patrones:
                    if re.search(patron, texto_celda, re.IGNORECASE):
                        nuevo_texto = re.sub(patron, reemplazo, texto_celda, flags=re.IGNORECASE)
                        cell.text = nuevo_texto
                        print(f"Actualizado en tabla: {texto_celda[:50]}...")
    
    # Guardar el documento
    doc.save('SmartAuditorIA_editado_ACTUALIZADO.docx')
    print("\n✅ Documento actualizado guardado como: SmartAuditorIA_editado_ACTUALIZADO.docx")
    print("\n📋 Cambios realizados:")
    print(f"   - Desarrollador mensual: {valores_nuevos['desarrollador_mensual']} COP/mes")
    print(f"   - Aporte total desarrollador: {valores_nuevos['desarrollador_total']} COP")
    print(f"   - Infraestructura: {valores_nuevos['infraestructura_total']} COP")
    print(f"   - Hardware: {valores_nuevos['hardware_total']} COP")
    print(f"   - Formación: {valores_nuevos['formacion_total']} COP")
    print(f"   - Total general: {valores_nuevos['total_general']} COP")

if __name__ == '__main__':
    try:
        actualizar_presupuesto()
    except FileNotFoundError:
        print("❌ Error: No se encontró el archivo 'SmartAuditorIA_editado.docx'")
        print("   Asegúrate de que el archivo esté en el directorio actual")
    except Exception as e:
        print(f"❌ Error: {e}")
        print("\n💡 Alternativa: Usa el archivo PRESUPUESTO_ACTUALIZADO.md como referencia")
        print("   y copia el contenido manualmente al documento Word")

