@echo off
REM Script para instalar dependencias de Vector DB de forma optimizada

echo ========================================
echo Instalacion de Base de Datos Vectorial
echo ========================================
echo.

REM Activar entorno virtual si existe
if exist "..\venv\Scripts\activate.bat" (
    echo Activando entorno virtual...
    call ..\venv\Scripts\activate.bat
) else if exist "venv\Scripts\activate.bat" (
    echo Activando entorno virtual...
    call venv\Scripts\activate.bat
)

echo.
echo Instalando dependencias optimizadas...
echo.

REM Instalar ChromaDB (ligero y rapido)
echo [1/4] Instalando ChromaDB...
pip install chromadb==0.4.22 --no-cache-dir

REM Instalar sentence-transformers (modelo multilingue optimizado)
echo [2/4] Instalando sentence-transformers...
pip install sentence-transformers==2.2.2 --no-cache-dir

REM Instalar procesadores de PDF (ligeros)
echo [3/4] Instalando procesadores de PDF...
pip install PyPDF2==3.0.1 pdfplumber==0.10.3 --no-cache-dir

REM Dependencias adicionales
echo [4/4] Instalando dependencias adicionales...
pip install numpy==1.24.3 --no-cache-dir

echo.
echo ========================================
echo Instalacion completada
echo ========================================
echo.
echo Verificando instalacion...
python -c "import chromadb; print('ChromaDB: OK')" 2>nul || echo ChromaDB: ERROR
python -c "import sentence_transformers; print('sentence-transformers: OK')" 2>nul || echo sentence-transformers: ERROR
python -c "import PyPDF2; print('PyPDF2: OK')" 2>nul || echo PyPDF2: ERROR

echo.
echo Listo para procesar documentos!
echo Ejecuta: python scripts\process_documents_to_vector_db.py
pause

