"""
Script para mejorar el formato de todas las tablas en SmartAuditorIA_editado.docx
Aplica estilos profesionales similares a las tablas del presupuesto actualizado
"""

from docx import Document
from docx.shared import Pt, RGBColor, Inches
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT, WD_ALIGN_VERTICAL
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

def set_cell_background(cell, color):
    """Establece el color de fondo de una celda"""
    shading_elm = OxmlElement('w:shd')
    shading_elm.set(qn('w:fill'), color)
    cell._element.get_or_add_tcPr().append(shading_elm)

def set_cell_border(cell, border_style='single', border_size='4', border_color='000000'):
    """Establece bordes de una celda"""
    tc = cell._element
    tcPr = tc.get_or_add_tcPr()
    
    # Bordes
    borders = OxmlElement('w:tcBorders')
    
    for border_name in ['top', 'left', 'bottom', 'right']:
        border = OxmlElement(f'w:{border_name}')
        border.set(qn('w:val'), border_style)
        border.set(qn('w:sz'), border_size)
        border.set(qn('w:color'), border_color)
        borders.append(border)
    
    tcPr.append(borders)

def mejorar_formato_tabla(tabla, es_encabezado=False):
    """Mejora el formato de una tabla completa"""
    
    # Aplicar estilo de tabla profesional
    try:
        tabla.style = 'Light Grid Accent 1'
    except:
        # Si el estilo no existe, aplicar formato manual
        pass
    
    # Centrar la tabla
    tabla.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    # Procesar primera fila (encabezados)
    if len(tabla.rows) > 0:
        primera_fila = tabla.rows[0]
        
        for cell in primera_fila.cells:
            # Fondo azul oscuro para encabezados
            set_cell_background(cell, '1E3A8A')
            
            # Texto en negrita y blanco
            for paragraph in cell.paragraphs:
                paragraph.alignment = WD_ALIGN_PARAGRAPH.CENTER
                for run in paragraph.runs:
                    run.bold = True
                    run.font.color.rgb = RGBColor(255, 255, 255)
                    run.font.size = Pt(11)
                    run.font.name = 'Calibri'
            
            # Si no hay texto, agregar formato de todas formas
            if not cell.text.strip():
                p = cell.paragraphs[0]
                p.alignment = WD_ALIGN_PARAGRAPH.CENTER
                run = p.add_run()
                run.font.bold = True
                run.font.color.rgb = RGBColor(255, 255, 255)
                run.font.size = Pt(11)
            
            # Bordes
            set_cell_border(cell)
            
            # Alineación vertical
            cell.vertical_alignment = WD_ALIGN_VERTICAL.CENTER
    
    # Procesar filas de datos
    for i, row in enumerate(tabla.rows[1:], start=1):
        # Alternar colores de fondo para mejor legibilidad
        color_fondo = 'F9FAFB' if i % 2 == 0 else 'FFFFFF'
        
        for cell in row.cells:
            # Fondo alternado
            set_cell_background(cell, color_fondo)
            
            # Formato de texto
            for paragraph in cell.paragraphs:
                for run in paragraph.runs:
                    run.font.size = Pt(10)
                    run.font.name = 'Calibri'
                    run.font.color.rgb = RGBColor(0, 0, 0)
            
            # Bordes
            set_cell_border(cell)
            
            # Alineación vertical
            cell.vertical_alignment = WD_ALIGN_VERTICAL.CENTER
    
    # Ajustar ancho de columnas automáticamente
    for row in tabla.rows:
        for cell in row.cells:
            # Ajustar ancho mínimo
            cell.width = Inches(1.0)

def identificar_tablas_especiales(tabla, texto_anterior=""):
    """Identifica si una tabla necesita formato especial"""
    texto_tabla = ""
    if len(tabla.rows) > 0:
        for cell in tabla.rows[0].cells:
            texto_tabla += cell.text.lower()
    
    # Tablas de resumen/total
    if any(palabra in texto_tabla for palabra in ['total', 'resumen', 'subtotal']):
        return 'resumen'
    
    # Tablas de presupuesto
    if any(palabra in texto_tabla for palabra in ['presupuesto', 'costo', 'valor']):
        return 'presupuesto'
    
    # Tablas de cronograma/sprints
    if any(palabra in texto_tabla for palabra in ['sprint', 'iteración', 'momento', 'actividades']):
        return 'cronograma'
    
    return 'normal'

def aplicar_formato_especial(tabla, tipo):
    """Aplica formato especial según el tipo de tabla"""
    
    if tipo == 'resumen' and len(tabla.rows) > 0:
        # Última fila en color destacado
        ultima_fila = tabla.rows[-1]
        for cell in ultima_fila.cells:
            set_cell_background(cell, '1E3A8A')
            for paragraph in cell.paragraphs:
                for run in paragraph.runs:
                    run.bold = True
                    run.font.color.rgb = RGBColor(255, 255, 255)
                    run.font.size = Pt(12)
    
    elif tipo == 'cronograma':
        # Formato especial para tablas de cronograma
        if len(tabla.rows) > 0:
            primera_fila = tabla.rows[0]
            for cell in primera_fila.cells:
                set_cell_background(cell, '3B82F6')  # Azul más claro
                for paragraph in cell.paragraphs:
                    for run in paragraph.runs:
                        run.bold = True
                        run.font.color.rgb = RGBColor(255, 255, 255)

def mejorar_documento():
    """Mejora todas las tablas del documento"""
    
    print("📝 Abriendo documento SmartAuditorIA_editado.docx...")
    
    try:
        doc = Document('SmartAuditorIA_editado.docx')
    except FileNotFoundError:
        print("❌ Error: No se encontró el archivo 'SmartAuditorIA_editado.docx'")
        return
    
    print(f"✅ Documento abierto. Encontradas {len(doc.tables)} tablas.")
    
    tablas_mejoradas = 0
    
    # Procesar todas las tablas
    for idx, tabla in enumerate(doc.tables, start=1):
        print(f"   Procesando tabla {idx}/{len(doc.tables)}...")
        
        # Identificar tipo de tabla
        tipo = identificar_tablas_especiales(tabla)
        
        # Aplicar formato base
        mejorar_formato_tabla(tabla)
        
        # Aplicar formato especial si es necesario
        if tipo != 'normal':
            aplicar_formato_especial(tabla, tipo)
            print(f"      → Aplicado formato especial: {tipo}")
        
        tablas_mejoradas += 1
    
    # Guardar documento mejorado
    nombre_salida = 'SmartAuditorIA_editado_MEJORADO.docx'
    doc.save(nombre_salida)
    
    print(f"\n✅ Documento mejorado guardado como: {nombre_salida}")
    print(f"📊 Tablas mejoradas: {tablas_mejoradas}")
    print("\n💡 Mejoras aplicadas:")
    print("   ✓ Encabezados con fondo azul oscuro y texto blanco")
    print("   ✓ Filas alternadas con colores para mejor legibilidad")
    print("   ✓ Bordes definidos en todas las celdas")
    print("   ✓ Texto centrado en encabezados")
    print("   ✓ Formato especial para tablas de resumen y cronograma")
    print("   ✓ Fuente Calibri 10-11pt para consistencia")
    print("\n🎉 ¡Listo para consolidar en tu documento final!")

if __name__ == '__main__':
    try:
        mejorar_documento()
    except ImportError:
        print("❌ Error: python-docx no está instalado")
        print("   Ejecuta: pip install python-docx")
    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()

