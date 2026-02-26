#!/usr/bin/env python3
"""
Script optimizado para configurar y procesar documentos en Vector DB
Versión rápida, confiable y efectiva
"""

import sys
import subprocess
from pathlib import Path

def check_and_install_dependencies():
    """Verificar e instalar dependencias necesarias"""
    print("="*60)
    print("VERIFICACIÓN DE DEPENDENCIAS")
    print("="*60)
    print()
    
    required_packages = {
        "chromadb": "chromadb",
        "sentence_transformers": "sentence-transformers",
        "PyPDF2": "PyPDF2",
        "pdfplumber": "pdfplumber"
    }
    
    missing = []
    installed = []
    
    for module_name, package_name in required_packages.items():
        try:
            __import__(module_name)
            installed.append(package_name)
            print(f"✅ {package_name} - Instalado")
        except ImportError:
            missing.append(package_name)
            print(f"❌ {package_name} - No instalado")
    
    if missing:
        print(f"\n⚠️  Faltan {len(missing)} paquetes")
        print("\nInstalando dependencias faltantes...")
        
        for package in missing:
            try:
                print(f"  Instalando {package}...")
                subprocess.check_call([sys.executable, "-m", "pip", "install", package, "--quiet"], 
                                     timeout=300)
                print(f"  ✅ {package} instalado")
            except Exception as e:
                print(f"  ❌ Error instalando {package}: {e}")
                return False
        
        print("\n✅ Todas las dependencias instaladas")
    else:
        print("\n✅ Todas las dependencias ya están instaladas")
    
    return True

def process_documents_optimized():
    """Procesar documentos de forma optimizada"""
    print("\n" + "="*60)
    print("PROCESAMIENTO DE DOCUMENTOS")
    print("="*60)
    print()
    
    # Agregar backend al path
    # Obtener directorio del script
    script_dir = Path(__file__).parent.absolute()
    backend_path = script_dir.parent
    project_root = backend_path.parent
    
    # Agregar ambos al path
    sys.path.insert(0, str(backend_path))
    sys.path.insert(0, str(project_root))
    
    try:
        from app.services.predictive.document_processor import DocumentProcessor
        from app.services.predictive.vector_store import VectorStore
    except ImportError as e:
        print(f"❌ Error al importar módulos: {e}")
        print("\n💡 Asegúrate de estar en el directorio correcto")
        return False
    
    # Buscar carpeta Docs
    possible_paths = [
        project_root / "Docs",
        Path("Docs"),
        Path("../Docs"),
        backend_path.parent / "Docs"
    ]
    
    docs_path = None
    for path in possible_paths:
        if path.exists():
            docs_path = path
            break
    
    if not docs_path:
        print("❌ No se encontró la carpeta Docs")
        return False
    
    print(f"✅ Carpeta encontrada: {docs_path.absolute()}")
    
    # Contar PDFs
    pdf_files = list(docs_path.rglob("*.pdf"))
    print(f"📄 PDFs encontrados: {len(pdf_files)}")
    
    if not pdf_files:
        print("⚠️  No hay PDFs para procesar")
        return False
    
    # Crear procesador
    try:
        print("\n🔄 Inicializando procesador...")
        processor = DocumentProcessor(docs_path=str(docs_path), recursive=True)
        print("✅ Procesador inicializado")
    except Exception as e:
        print(f"❌ Error al inicializar: {e}")
        return False
    
    # Procesar documentos
    print("\n🔄 Procesando documentos (esto puede tardar varios minutos)...")
    print("   - Extrayendo texto de PDFs")
    print("   - Generando embeddings")
    print("   - Almacenando en Vector DB")
    print()
    
    stats = processor.process_all_documents()
    
    # Mostrar resultados
    print("\n" + "="*60)
    print("RESULTADOS")
    print("="*60)
    print(f"✅ Procesados exitosamente: {stats['processed']}")
    print(f"❌ Fallidos: {stats['failed']}")
    print(f"📊 Total chunks en Vector DB: {stats['total_chunks']}")
    print()
    
    if stats['documents']:
        print("Documentos procesados:")
        for doc in stats['documents'][:10]:  # Mostrar primeros 10
            icon = "✅" if doc['status'] == 'success' else "❌"
            norma = doc.get('norma', 'N/A')
            print(f"  {icon} {doc['file']} ({norma})")
        
        if len(stats['documents']) > 10:
            print(f"  ... y {len(stats['documents']) - 10} más")
    
    # Información de Vector DB
    collection_info = processor.vector_store.get_collection_info()
    print(f"\n📁 Ubicación Vector DB: {collection_info.get('persist_directory')}")
    print(f"📚 Documentos (chunks): {collection_info.get('document_count')}")
    
    return stats['processed'] > 0

def main():
    """Función principal"""
    print("\n" + "="*60)
    print("CONFIGURACIÓN Y PROCESAMIENTO DE BASE VECTORIAL")
    print("="*60)
    print()
    
    # Paso 1: Verificar dependencias
    if not check_and_install_dependencies():
        print("\n❌ No se pudieron instalar todas las dependencias")
        print("💡 Instala manualmente: pip install chromadb sentence-transformers PyPDF2 pdfplumber")
        return
    
    # Paso 2: Procesar documentos
    if process_documents_optimized():
        print("\n" + "="*60)
        print("✅ ¡PROCESAMIENTO COMPLETADO EXITOSAMENTE!")
        print("="*60)
        print("\n💡 La base de datos vectorial está lista para usar")
        print("   Ubicación: backend/vector_store/")
        print("\n🚀 Ahora puedes usar búsqueda semántica en el sistema RAG")
    else:
        print("\n❌ Hubo problemas en el procesamiento")
        print("💡 Revisa los errores arriba")

if __name__ == "__main__":
    main()

