#!/usr/bin/env python3
"""
Script para explorar y consultar la base de datos vectorial
Muestra información sobre los documentos almacenados y permite hacer búsquedas
"""

import sys
from pathlib import Path

# Agregar backend al path
backend_path = Path(__file__).parent.parent
sys.path.insert(0, str(backend_path))

from app.services.predictive.vector_store import VectorStore

def mostrar_info_coleccion():
    """Mostrar información general de la colección"""
    print("="*70)
    print("INFORMACIÓN DE LA BASE DE DATOS VECTORIAL")
    print("="*70)
    print()
    
    try:
        vs = VectorStore()
        info = vs.get_collection_info()
        
        print(f"📁 Ubicación: {info.get('persist_directory', 'N/A')}")
        print(f"📚 Colección: {info.get('collection_name', 'N/A')}")
        print(f"📊 Total de documentos (chunks): {info.get('document_count', 0)}")
        print(f"🤖 Modelo de embeddings: {info.get('embedding_model', 'N/A')}")
        print(f"✅ Modelo disponible: {info.get('embedding_model_available', False)}")
        print()
        
        # Obtener algunos documentos de ejemplo
        if info.get('document_count', 0) > 0:
            print("📄 Muestra de documentos almacenados:")
            print("-" * 70)
            
            # Obtener algunos IDs de ejemplo
            try:
                sample_results = vs.collection.get(limit=5)
                if sample_results['ids']:
                    for i, doc_id in enumerate(sample_results['ids'][:5], 1):
                        metadata = sample_results['metadatas'][i-1] if sample_results['metadatas'] else {}
                        text_preview = sample_results['documents'][i-1][:100] if sample_results['documents'] else ""
                        
                        print(f"\n{i}. ID: {doc_id}")
                        print(f"   Norma: {metadata.get('norma', 'N/A')}")
                        print(f"   Tipo: {metadata.get('tipo', 'N/A')}")
                        print(f"   Archivo: {metadata.get('file_path', 'N/A')}")
                        print(f"   Texto: {text_preview}...")
            except Exception as e:
                print(f"   ⚠️  No se pudieron obtener ejemplos: {e}")
        
        return vs
        
    except Exception as e:
        print(f"❌ Error al acceder a la base vectorial: {e}")
        return None

def buscar_documentos(vs: VectorStore, query: str, top_k: int = 5, filtro_norma: str = None):
    """Buscar documentos usando búsqueda semántica"""
    print("\n" + "="*70)
    print(f"BÚSQUEDA SEMÁNTICA: '{query}'")
    print("="*70)
    print()
    
    filter_metadata = None
    if filtro_norma:
        filter_metadata = {"norma": filtro_norma}
        print(f"🔍 Filtro aplicado: Norma = {filtro_norma}")
        print()
    
    results = vs.search(query, top_k=top_k, filter_metadata=filter_metadata)
    
    if not results:
        print("⚠️  No se encontraron resultados")
        return
    
    print(f"✅ Encontrados {len(results)} resultados:\n")
    
    for i, result in enumerate(results, 1):
        print(f"{'='*70}")
        print(f"Resultado {i} (Score: {result['score']:.3f})")
        print(f"{'='*70}")
        print(f"📄 ID: {result['id']}")
        
        metadata = result.get('metadata', {})
        if metadata:
            print(f"📋 Norma: {metadata.get('norma', 'N/A')}")
            print(f"📂 Tipo: {metadata.get('tipo', 'N/A')}")
            print(f"📁 Archivo: {metadata.get('file_path', 'N/A')}")
            print(f"📅 Año: {metadata.get('año', 'N/A')}")
            print(f"🌍 País: {metadata.get('pais', 'N/A')}")
        
        text = result.get('text', '')
        if len(text) > 300:
            print(f"\n📝 Texto (primeros 300 caracteres):")
            print(f"   {text[:300]}...")
        else:
            print(f"\n📝 Texto completo:")
            print(f"   {text}")
        
        print()

def main():
    """Función principal"""
    print("\n" + "="*70)
    print("EXPLORADOR DE BASE DE DATOS VECTORIAL")
    print("="*70)
    print()
    
    # Mostrar información
    vs = mostrar_info_coleccion()
    
    if not vs:
        return
    
    # Ejemplos de búsqueda
    print("\n" + "="*70)
    print("EJEMPLOS DE BÚSQUEDA")
    print("="*70)
    print()
    
    queries_ejemplo = [
        "riesgo residual",
        "control de seguridad de la información",
        "amenaza de malware",
        "vulnerabilidad de software",
        "gestión de incidentes"
    ]
    
    print("💡 Búsquedas de ejemplo:")
    for i, query in enumerate(queries_ejemplo, 1):
        print(f"   {i}. {query}")
    
    print("\n" + "-"*70)
    print("Ejecutando búsquedas de ejemplo...")
    print("-"*70)
    
    for query in queries_ejemplo[:3]:  # Solo las primeras 3
        buscar_documentos(vs, query, top_k=3)
        print("\n")
    
    # Búsqueda interactiva
    print("\n" + "="*70)
    print("BÚSQUEDA INTERACTIVA")
    print("="*70)
    print("\n💡 Escribe 'salir' para terminar")
    print("💡 Escribe 'filtro:ISO 27005' para filtrar por norma")
    print()
    
    while True:
        try:
            user_input = input("🔍 Buscar: ").strip()
            
            if user_input.lower() in ['salir', 'exit', 'quit']:
                break
            
            if not user_input:
                continue
            
            # Verificar si hay filtro
            filtro = None
            if user_input.startswith('filtro:'):
                parts = user_input.split(':', 1)
                if len(parts) > 1:
                    filtro = parts[1].strip()
                    query = "riesgo"  # Query por defecto con filtro
                else:
                    continue
            else:
                query = user_input
            
            buscar_documentos(vs, query, top_k=5, filtro_norma=filtro)
            
        except KeyboardInterrupt:
            print("\n\n👋 Saliendo...")
            break
        except Exception as e:
            print(f"\n❌ Error: {e}\n")

if __name__ == "__main__":
    main()

