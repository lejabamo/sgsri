#!/usr/bin/env python3
"""
Ejemplo de cómo usar la base vectorial en el sistema RAG
para generar justificaciones y sugerencias inteligentes
"""

import sys
from pathlib import Path

# Agregar backend al path
backend_path = Path(__file__).parent.parent
sys.path.insert(0, str(backend_path))

from app.services.predictive.vector_store import VectorStore

def generar_justificacion_rag(control_id: str, control_nombre: str, vector_store: VectorStore) -> str:
    """
    Generar justificación para un control usando RAG
    
    Args:
        control_id: ID del control (ej: "A.5.1")
        control_nombre: Nombre del control
        vector_store: Instancia de VectorStore
    
    Returns:
        Justificación generada
    """
    # Construir query para buscar información relevante
    query = f"{control_id} {control_nombre} implementación control seguridad"
    
    # Buscar documentos relevantes
    resultados = vector_store.search(query, top_k=3)
    
    if not resultados:
        return f"Control {control_id}: {control_nombre}. No se encontró información adicional en la base de conocimiento."
    
    # Construir justificación basada en los resultados
    justificacion = f"Control {control_id}: {control_nombre}\n\n"
    justificacion += "Justificación basada en normativa ISO:\n\n"
    
    for i, resultado in enumerate(resultados, 1):
        metadata = resultado.get('metadata', {})
        norma = metadata.get('norma', 'Normativa')
        texto = resultado.get('text', '')[:200]  # Primeros 200 caracteres
        
        justificacion += f"{i}. Según {norma}:\n"
        justificacion += f"   {texto}...\n\n"
    
    return justificacion

def sugerir_controles_rag(amenaza: str, tipo_activo: str, vector_store: VectorStore) -> list:
    """
    Sugerir controles para una amenaza usando RAG
    
    Args:
        amenaza: Descripción de la amenaza
        tipo_activo: Tipo de activo afectado
        vector_store: Instancia de VectorStore
    
    Returns:
        Lista de controles sugeridos
    """
    # Construir query
    query = f"control mitigar {amenaza} {tipo_activo} seguridad"
    
    # Buscar en base vectorial
    resultados = vector_store.search(query, top_k=5)
    
    controles = []
    for resultado in resultados:
        metadata = resultado.get('metadata', {})
        texto = resultado.get('text', '')
        
        # Extraer información de control del texto
        if 'control' in texto.lower() or 'A.' in texto:
            controles.append({
                'texto': texto[:150],
                'norma': metadata.get('norma', 'N/A'),
                'score': resultado.get('score', 0)
            })
    
    return controles

def ejemplo_completo_rag():
    """Ejemplo completo de uso de RAG en el sistema"""
    print("="*70)
    print("EJEMPLO DE USO DE RAG EN EL SISTEMA")
    print("="*70)
    print()
    
    # Inicializar Vector Store
    print("🔄 Inicializando base vectorial...")
    vs = VectorStore()
    info = vs.get_collection_info()
    print(f"✅ Base vectorial cargada: {info.get('document_count', 0)} documentos")
    print()
    
    # Ejemplo 1: Generar justificación para un control
    print("="*70)
    print("EJEMPLO 1: Generar Justificación para Control")
    print("="*70)
    print()
    
    control_id = "A.5.1"
    control_nombre = "Políticas de seguridad de la información"
    
    justificacion = generar_justificacion_rag(control_id, control_nombre, vs)
    print(justificacion)
    print()
    
    # Ejemplo 2: Sugerir controles para una amenaza
    print("="*70)
    print("EJEMPLO 2: Sugerir Controles para Amenaza")
    print("="*70)
    print()
    
    amenaza = "malware"
    tipo_activo = "servidor"
    
    print(f"🔍 Buscando controles para mitigar '{amenaza}' en '{tipo_activo}'...")
    controles = sugerir_controles_rag(amenaza, tipo_activo, vs)
    
    if controles:
        print(f"\n✅ Encontrados {len(controles)} controles relevantes:\n")
        for i, control in enumerate(controles, 1):
            print(f"{i}. [{control['norma']}] Score: {control['score']:.3f}")
            print(f"   {control['texto']}...")
            print()
    else:
        print("⚠️  No se encontraron controles específicos")
    
    # Ejemplo 3: Búsqueda semántica directa
    print("="*70)
    print("EJEMPLO 3: Búsqueda Semántica Directa")
    print("="*70)
    print()
    
    query = "riesgo residual evaluación"
    print(f"🔍 Buscando: '{query}'")
    resultados = vs.search(query, top_k=3)
    
    if resultados:
        print(f"\n✅ Encontrados {len(resultados)} resultados:\n")
        for i, resultado in enumerate(resultados, 1):
            metadata = resultado.get('metadata', {})
            print(f"{i}. [{metadata.get('norma', 'N/A')}] Score: {resultado['score']:.3f}")
            print(f"   {resultado['text'][:200]}...")
            print()
    else:
        print("⚠️  No se encontraron resultados")

if __name__ == "__main__":
    ejemplo_completo_rag()

