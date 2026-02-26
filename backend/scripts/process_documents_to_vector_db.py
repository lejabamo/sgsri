#!/usr/bin/env python3
"""
Script para procesar documentos PDF y crear la base de datos vectorial con embeddings
"""

import sys
from pathlib import Path

# Agregar el directorio backend al path
backend_path = Path(__file__).parent.parent
sys.path.insert(0, str(backend_path))

from app.services.predictive.document_processor import DocumentProcessor
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def main():
    """Procesar documentos PDF y crear embeddings"""
    
    print("="*60)
    print("PROCESADOR DE DOCUMENTOS PARA BASE DE DATOS VECTORIAL")
    print("="*60)
    print()
    
    # Buscar carpeta Docs en diferentes ubicaciones
    possible_docs_paths = [
        Path("Docs"),
        Path("../Docs"),
        Path("backend/Docs"),
        Path(__file__).parent.parent.parent / "Docs"
    ]
    
    docs_path = None
    for path in possible_docs_paths:
        if path.exists():
            docs_path = path
            break
    
    if not docs_path:
        print("❌ No se encontró la carpeta Docs")
        print("\nUbicaciones buscadas:")
        for path in possible_docs_paths:
            print(f"  - {path.absolute()}")
        print("\n💡 Crea la carpeta 'Docs' en la raíz del proyecto y coloca tus PDFs allí")
        return
    
    print(f"✅ Carpeta de documentos encontrada: {docs_path.absolute()}")
    print()
    
    # Verificar que hay PDFs
    pdf_files = list(docs_path.glob("*.pdf"))
    if not pdf_files:
        print("⚠️  No se encontraron archivos PDF en la carpeta Docs")
        print(f"\nColoca tus documentos PDF en: {docs_path.absolute()}")
        print("\nDocumentos esperados:")
        print("  - NTC 27002.pdf (ISO 27002)")
        print("  - NTC-ISO-IEC-27005 (1).pdf (ISO 27005)")
        print("  - Norma Pegagogica-ISO-IEC 27001-2022 (1).pdf (ISO 27001)")
        print("  - Resolucion_2277_2025.pdf (Normativa Colombia)")
        print("  - Resolucion_500_2021.pdf (Normativa Colombia)")
        print("  - CONPES_3995_2020.pdf (Normativa Colombia)")
        return
    
    print(f"📄 Archivos PDF encontrados: {len(pdf_files)}")
    for pdf in pdf_files:
        print(f"  - {pdf.name}")
    print()
    
    # Crear procesador
    try:
        processor = DocumentProcessor(docs_path=str(docs_path))
        print("✅ Procesador inicializado")
        print(f"   - Modelo de embeddings: paraphrase-multilingual-MiniLM-L12-v2")
        print(f"   - Vector DB: ChromaDB")
        print()
    except Exception as e:
        print(f"❌ Error al inicializar procesador: {e}")
        print("\n💡 Asegúrate de instalar las dependencias:")
        print("   pip install chromadb sentence-transformers PyPDF2 pdfplumber")
        return
    
    # Preguntar si limpiar la base existente
    print("¿Deseas limpiar la base vectorial existente antes de procesar? (s/N): ", end="")
    respuesta = input().strip().lower()
    clear = respuesta == 's' or respuesta == 'si'
    
    if clear:
        print("🗑️  Limpiando base vectorial...")
        processor.vector_store.clear_collection()
        print("✅ Base vectorial limpiada")
        print()
    
    # Procesar documentos
    print("🔄 Iniciando procesamiento de documentos...")
    print()
    
    stats = processor.process_all_documents()
    
    # Mostrar resultados
    print()
    print("="*60)
    print("RESUMEN DEL PROCESAMIENTO")
    print("="*60)
    print(f"✅ Documentos procesados exitosamente: {stats['processed']}")
    print(f"❌ Documentos fallidos: {stats['failed']}")
    print(f"📊 Total de chunks en Vector DB: {stats['total_chunks']}")
    print()
    
    if stats['documents']:
        print("Detalle por documento:")
        for doc in stats['documents']:
            icon = "✅" if doc['status'] == 'success' else "❌"
            print(f"  {icon} {doc['file']}")
        print()
    
    # Información de la colección
    collection_info = processor.vector_store.get_collection_info()
    print("Información de Vector DB:")
    print(f"  📁 Ubicación: {collection_info.get('persist_directory')}")
    print(f"  📚 Colección: {collection_info.get('collection_name')}")
    print(f"  📄 Documentos (chunks): {collection_info.get('document_count')}")
    print(f"  🤖 Modelo disponible: {collection_info.get('embedding_model_available')}")
    print()
    
    if stats['processed'] > 0:
        print("✅ ¡Base de datos vectorial creada exitosamente!")
        print("\n💡 Ahora puedes usar la búsqueda semántica en el sistema RAG")
        print("   Los documentos están listos para generar sugerencias inteligentes")
    else:
        print("⚠️  No se procesaron documentos. Revisa los errores arriba.")

if __name__ == "__main__":
    main()

