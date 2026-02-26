#!/bin/bash
# Script para instalar dependencias de Vector DB de forma optimizada

echo "========================================"
echo "Instalación de Base de Datos Vectorial"
echo "========================================"
echo ""

# Activar entorno virtual si existe
if [ -d "../venv" ]; then
    echo "Activando entorno virtual..."
    source ../venv/bin/activate
elif [ -d "venv" ]; then
    echo "Activando entorno virtual..."
    source venv/bin/activate
fi

echo ""
echo "Instalando dependencias optimizadas..."
echo ""

# Instalar ChromaDB (ligero y rápido)
echo "[1/4] Instalando ChromaDB..."
pip install chromadb==0.4.22 --no-cache-dir

# Instalar sentence-transformers (modelo multilingüe optimizado)
echo "[2/4] Instalando sentence-transformers..."
pip install sentence-transformers==2.2.2 --no-cache-dir

# Instalar procesadores de PDF (ligeros)
echo "[3/4] Instalando procesadores de PDF..."
pip install PyPDF2==3.0.1 pdfplumber==0.10.3 --no-cache-dir

# Dependencias adicionales
echo "[4/4] Instalando dependencias adicionales..."
pip install numpy==1.24.3 --no-cache-dir

echo ""
echo "========================================"
echo "Instalación completada"
echo "========================================"
echo ""
echo "Verificando instalación..."
python3 -c "import chromadb; print('ChromaDB: OK')" 2>/dev/null || echo "ChromaDB: ERROR"
python3 -c "import sentence_transformers; print('sentence-transformers: OK')" 2>/dev/null || echo "sentence-transformers: ERROR"
python3 -c "import PyPDF2; print('PyPDF2: OK')" 2>/dev/null || echo "PyPDF2: ERROR"

echo ""
echo "✅ Listo para procesar documentos!"
echo "Ejecuta: python3 scripts/process_documents_to_vector_db.py"

