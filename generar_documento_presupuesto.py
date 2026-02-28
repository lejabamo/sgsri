"""
Script para generar el documento Word con el presupuesto actualizado de SmartAuditorIA
"""

from docx import Document
from docx.shared import Pt, RGBColor, Inches
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

def crear_tabla_presupuesto(doc):
    """Crea la tabla de presupuesto con formato profesional"""
    
    # Título de la sección
    titulo = doc.add_heading('Presupuesto Realista de SmartAuditorIA (Revisión Técnica)', level=1)
    titulo.alignment = WD_ALIGN_PARAGRAPH.LEFT
    
    # Sección 1: Valor del Desarrollador
    doc.add_heading('1. Valor del Desarrollador Especializado', level=2)
    
    parrafo = doc.add_paragraph()
    parrafo.add_run('Dado el perfil del desarrollador (IA, seguridad, full-stack, sector público, arquitecturas RAG, dev senior), el valor de mercado en Colombia para este perfil es:')
    
    # Lista de valores de mercado
    valores = [
        'Desarrollador IA Senior: 14–22 M COP/mes',
        'Arquitecto de Soluciones IA / RAG: 18–28 M COP/mes',
        'Ingeniero de Datos + Seguridad: 17–25 M COP/mes'
    ]
    
    for valor in valores:
        p = doc.add_paragraph(valor, style='List Bullet')
    
    # Valor aplicado
    p_valor = doc.add_paragraph()
    p_valor.add_run('Valor aplicado: ').bold = True
    p_valor.add_run('20.000.000 COP/mes').bold = True
    
    p_just = doc.add_paragraph()
    p_just.add_run('Justificación: ').italic = True
    p_just.add_run('Rol múltiple que incluye backend, IA, arquitectura, seguridad, modelo predictivo, frontend y despliegue.').italic = True
    
    p_duracion = doc.add_paragraph()
    p_duracion.add_run('Duración del proyecto: ').bold = True
    p_duracion.add_run('6.5 meses')
    
    p_aporte = doc.add_paragraph()
    p_aporte.add_run('Aporte en especie del desarrollador: ').bold = True
    p_aporte.add_run('130.000.000 COP').bold = True
    
    doc.add_paragraph()  # Espacio
    
    # Sección 2: Recursos Tecnológicos
    doc.add_heading('2. Recursos Tecnológicos (Actualizados)', level=2)
    
    # Tabla de recursos tecnológicos
    tabla_recursos = doc.add_table(rows=1, cols=4)
    tabla_recursos.style = 'Light Grid Accent 1'
    tabla_recursos.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    # Encabezados
    hdr_cells = tabla_recursos.rows[0].cells
    hdr_cells[0].text = 'Recurso'
    hdr_cells[1].text = 'Costo Mensual'
    hdr_cells[2].text = 'Costo Proyecto\n(6.5 meses)'
    hdr_cells[3].text = 'Comentario'
    
    # Hacer encabezados en negrita
    for cell in hdr_cells:
        for paragraph in cell.paragraphs:
            for run in paragraph.runs:
                run.bold = True
    
    # Datos
    recursos = [
        ('VPS (4–8 GB RAM)', '200.000 – 350.000', '~2.100.000', 'SmartAuditorIA usa RAG, requiere mayor RAM'),
        ('Vector DB (Pinecone / Chroma Server)', '60.000–120.000', '~480.000', 'Fundamental para embeddings'),
        ('API LLM (OpenAI / Bedrock)', '80.000–120.000', '~640.000', 'Según uso en pruebas y producción'),
        ('Suscripciones técnicas\n(Cursor Pro, GitHub Copilot, IDE)', '70.000–150.000', '~900.000', 'Totalmente justificable'),
        ('Dominios / SSL', '150.000 (1 año)', '150.000', 'Certificado SSL para producción'),
        ('Herramientas de monitoreo / logs', '40.000', '240.000', 'Recomendado para producción')
    ]
    
    for recurso, mensual, proyecto, comentario in recursos:
        row_cells = tabla_recursos.add_row().cells
        row_cells[0].text = recurso
        row_cells[1].text = mensual
        row_cells[2].text = proyecto
        row_cells[3].text = comentario
    
    # Fila de subtotal
    row_subtotal = tabla_recursos.add_row().cells
    row_subtotal[0].text = 'SUBTOTAL RECURSOS TECNOLÓGICOS'
    row_subtotal[1].text = ''
    row_subtotal[2].text = '4.510.000'
    row_subtotal[3].text = ''
    
    # Negrita en subtotal
    for cell in row_subtotal:
        for paragraph in cell.paragraphs:
            for run in paragraph.runs:
                run.bold = True
    
    doc.add_paragraph()  # Espacio
    
    # Sección 3: Hardware
    doc.add_heading('3. Hardware (Depreciación)', level=2)
    
    doc.add_paragraph('Especificaciones: Máquina de desarrollo con 32 GB RAM + GPU')
    doc.add_paragraph('Depreciación mensual: 120.000 COP/mes')
    doc.add_paragraph('Duración: 6.5 meses')
    
    p_hardware = doc.add_paragraph()
    p_hardware.add_run('Total depreciación hardware: ').bold = True
    p_hardware.add_run('780.000 COP').bold = True
    
    doc.add_paragraph()  # Espacio
    
    # Sección 4: Material Académico
    doc.add_heading('4. Material Académico y de Especialización', level=2)
    
    # Tabla de formación
    tabla_formacion = doc.add_table(rows=1, cols=3)
    tabla_formacion.style = 'Light Grid Accent 1'
    tabla_formacion.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    hdr_form = tabla_formacion.rows[0].cells
    hdr_form[0].text = 'Item'
    hdr_form[1].text = 'Costo Estimado'
    hdr_form[2].text = 'Comentario'
    
    for cell in hdr_form:
        for paragraph in cell.paragraphs:
            for run in paragraph.runs:
                run.bold = True
    
    formacion = [
        ('Libros técnicos (Packt, O\'Reilly)', '~500.000', '5–10 libros sobre IA, RAG, Seguridad'),
        ('Cursos especializados', '300.000–800.000', 'FastAPI, RAG, Seguridad, Arquitecturas IA'),
        ('Certificaciones (opcional)', '700.000 – 1.500.000', 'Certificaciones en seguridad y IA')
    ]
    
    for item, costo, comentario in formacion:
        row_cells = tabla_formacion.add_row().cells
        row_cells[0].text = item
        row_cells[1].text = costo
        row_cells[2].text = comentario
    
    row_subtotal_form = tabla_formacion.add_row().cells
    row_subtotal_form[0].text = 'SUBTOTAL FORMACIÓN'
    row_subtotal_form[1].text = '1.800.000'
    row_subtotal_form[2].text = 'Cifra razonable considerando nivel de especialización'
    
    for cell in row_subtotal_form:
        for paragraph in cell.paragraphs:
            for run in paragraph.runs:
                run.bold = True
    
    doc.add_paragraph()  # Espacio
    
    # RESUMEN FINAL
    doc.add_heading('RESUMEN PRESUPUESTO REALISTA', level=1)
    
    tabla_resumen = doc.add_table(rows=1, cols=2)
    tabla_resumen.style = 'Light Grid Accent 1'
    tabla_resumen.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    hdr_resumen = tabla_resumen.rows[0].cells
    hdr_resumen[0].text = 'Rubro'
    hdr_resumen[1].text = 'Valor (COP)'
    
    for cell in hdr_resumen:
        for paragraph in cell.paragraphs:
            for run in paragraph.runs:
                run.bold = True
    
    rubros = [
        ('Aporte de trabajo (ingeniero IA senior)', '130.000.000'),
        ('Infraestructura y APIs', '4.510.000'),
        ('Hardware (depreciación)', '780.000'),
        ('Formación y herramientas', '1.800.000'),
        ('Dominio y SSL', '150.000')
    ]
    
    for rubro, valor in rubros:
        row_cells = tabla_resumen.add_row().cells
        row_cells[0].text = rubro
        row_cells[1].text = valor
    
    # Fila total
    row_total = tabla_resumen.add_row().cells
    row_total[0].text = 'TOTAL REAL'
    row_total[1].text = '137.240.000'
    
    # Negrita y color en total
    for cell in row_total:
        for paragraph in cell.paragraphs:
            for run in paragraph.runs:
                run.bold = True
                run.font.size = Pt(12)
    
    doc.add_paragraph()  # Espacio
    
    # Desglose de financiación
    doc.add_heading('Desglose de Financiación', level=2)
    
    p_fin1 = doc.add_paragraph()
    p_fin1.add_run('• Valor efectivo a pagar por infraestructura: ').bold = True
    p_fin1.add_run('~4.5M COP')
    
    p_fin2 = doc.add_paragraph()
    p_fin2.add_run('• Aporte del desarrollador (contrapartida académica): ').bold = True
    p_fin2.add_run('130M COP')
    
    doc.add_paragraph()  # Espacio
    
    # Justificación
    doc.add_heading('Justificación del Presupuesto', level=2)
    
    doc.add_paragraph('Este presupuesto es:')
    
    justificaciones = [
        '✓ DEFENDIBLE: Basado en valores de mercado reales para perfiles especializados',
        '✓ PROFESIONAL: Refleja el nivel de seniority y especialización requerido',
        '✓ ACADÉMICO: Apropiado para evaluación en contexto universitario',
        '✓ REALISTA: Considera todos los componentes necesarios para un sistema RAG de producción'
    ]
    
    for just in justificaciones:
        doc.add_paragraph(just, style='List Bullet')
    
    doc.add_paragraph()  # Espacio
    
    # Notas adicionales
    doc.add_heading('Notas Adicionales', level=2)
    
    doc.add_heading('1. Valor del desarrollador', level=3)
    doc.add_paragraph('El valor de 20M/mes está justificado por el rol múltiple que incluye:')
    roles = [
        'Desarrollo backend (Flask, Python)',
        'Implementación de sistemas RAG',
        'Arquitectura de soluciones IA',
        'Seguridad de la información',
        'Desarrollo frontend (React, TypeScript)',
        'Despliegue y DevOps'
    ]
    for rol in roles:
        doc.add_paragraph(rol, style='List Bullet')
    
    doc.add_heading('2. Infraestructura', level=3)
    doc.add_paragraph('Los costos reflejan las necesidades reales de un sistema RAG en producción, que requiere:')
    infra = [
        'Mayor capacidad de procesamiento (VPS con más RAM)',
        'Base de datos vectorial para embeddings',
        'APIs de LLM para generación',
        'Herramientas profesionales de desarrollo'
    ]
    for item in infra:
        doc.add_paragraph(item, style='List Bullet')
    
    doc.add_heading('3. Formación continua', level=3)
    doc.add_paragraph('Esencial para mantenerse actualizado en tecnologías emergentes como RAG, LLMs y seguridad de la información.')

def main():
    """Función principal"""
    print("📝 Generando documento Word con presupuesto actualizado...")
    
    # Crear nuevo documento
    doc = Document()
    
    # Configurar estilos
    style = doc.styles['Normal']
    font = style.font
    font.name = 'Calibri'
    font.size = Pt(11)
    
    # Agregar título principal
    titulo_principal = doc.add_heading('SmartAuditorIA', 0)
    subtitulo = doc.add_heading('Presupuesto Realista del Proyecto', level=1)
    
    doc.add_paragraph()  # Espacio
    
    # Crear contenido del presupuesto
    crear_tabla_presupuesto(doc)
    
    # Guardar documento
    nombre_archivo = 'SmartAuditorIA_Presupuesto_Actualizado.docx'
    doc.save(nombre_archivo)
    
    print(f"✅ Documento generado exitosamente: {nombre_archivo}")
    print("\n📊 Resumen del presupuesto:")
    print("   - Desarrollador: 20.000.000 COP/mes")
    print("   - Aporte total: 130.000.000 COP")
    print("   - Infraestructura: 4.510.000 COP")
    print("   - Hardware: 780.000 COP")
    print("   - Formación: 1.800.000 COP")
    print("   - TOTAL: 137.240.000 COP")
    print("\n💡 El documento está listo para incluir en tu trabajo académico.")

if __name__ == '__main__':
    try:
        main()
    except ImportError:
        print("❌ Error: python-docx no está instalado")
        print("   Ejecuta: pip install python-docx")
    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()

