#!/usr/bin/env python3
"""
Script para procesar documentos PDF y crear base de datos vectorial
EJECUTAR desde la carpeta backend con el venv activado:
    python procesar_documentos_vector.py
"""

import sys
import os
from pathlib import Path

# Obtener directorio del script (backend/)
script_dir = Path(__file__).parent.absolute()
project_root = script_dir.parent

# Agregar backend al path
sys.path.insert(0, str(script_dir))

try:
    from app.services.predictive.document_processor import DocumentProcessor
    
    print("="*70)
    print("PROCESAMIENTO DE DOCUMENTOS - BASE DE DATOS VECTORIAL")
    print("="*70)
    print()
    
    # Buscar carpeta Docs
    docs_path = project_root / "Docs"
    
    if not docs_path.exists():
        print(f"❌ No se encontró la carpeta Docs en: {docs_path}")
        print(f"💡 Buscando en: {project_root}")
        sys.exit(1)
    
    # Contar PDFs
    pdf_files = list(docs_path.rglob("*.pdf"))
    print(f"📄 PDFs encontrados: {len(pdf_files)}")
    
    if not pdf_files:
        print("⚠️  No hay PDFs para procesar")
        sys.exit(1)
    
    # Mostrar algunos PDFs encontrados
    print("\n📚 Algunos documentos encontrados:")
    for pdf in pdf_files[:5]:
        print(f"   - {pdf.relative_to(docs_path)}")
    if len(pdf_files) > 5:
        print(f"   ... y {len(pdf_files) - 5} más")
    
    # Crear procesador
    print("\n🔄 Inicializando procesador...")
    print("   (Esto puede tardar ~1 minuto la primera vez al descargar el modelo)")
    processor = DocumentProcessor(docs_path=str(docs_path), recursive=True)
    print("✅ Procesador inicializado")
    
    # Procesar documentos
    print("\n🔄 Procesando documentos (esto puede tardar varios minutos)...")
    print("   - Extrayendo texto de PDFs")
    print("   - Generando embeddings")
    print("   - Almacenando en Vector DB")
    print()
    
    stats = processor.process_all_documents()
    
    # Mostrar resultados
    print("\n" + "="*70)
    print("RESULTADOS")
    print("="*70)
    print(f"✅ Procesados exitosamente: {stats['processed']}")
    print(f"❌ Fallidos: {stats['failed']}")
    print(f"📊 Total chunks en Vector DB: {stats['total_chunks']}")
    print()
    
    if stats['documents']:
        print("Documentos procesados:")
        for doc in stats['documents']:
            icon = "✅" if doc['status'] == 'success' else "❌"
            norma = doc.get('norma', 'N/A')
            file_name = doc['file']
            if len(file_name) > 55:
                file_name = file_name[:52] + "..."
            print(f"  {icon} {file_name}")
            if norma != 'N/A':
                print(f"      └─ Norma: {norma}")
    
    # Información de Vector DB
    try:
        collection_info = processor.vector_store.get_collection_info()
        print(f"\n📁 Ubicación Vector DB: {collection_info.get('persist_directory', 'N/A')}")
        print(f"📚 Documentos (chunks): {collection_info.get('document_count', 0)}")
    except Exception as e:
        print(f"\n⚠️  No se pudo obtener info de Vector DB: {e}")
    
    print("\n" + "="*70)
    print("✅ ¡PROCESAMIENTO COMPLETADO!")
    print("="*70)
    print("\n💡 La base de datos vectorial está lista para usar")
    print("   Ubicación: backend/vector_store/")
    print("\n🚀 Ahora puedes usar búsqueda semántica en el sistema RAG")
    
except ImportError as e:
    print(f"❌ Error al importar módulos: {e}")
    print("\n💡 Asegúrate de que:")
    print("   1. Estás en la carpeta backend/")
    print("   2. El venv está activado")
    print("   3. Las dependencias están instaladas:")
    print("      pip install chromadb sentence-transformers PyPDF2 pdfplumber")
    import traceback
    traceback.print_exc()
    sys.exit(1)
except Exception as e:
    print(f"\n❌ Error durante el procesamiento: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)

