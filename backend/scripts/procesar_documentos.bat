@echo off
REM Script para procesar documentos en Vector DB
echo ============================================================
echo PROCESAMIENTO DE DOCUMENTOS - BASE VECTORIAL
echo ============================================================
echo.

REM Cambiar al directorio del proyecto
cd /d "%~dp0\..\.."

REM Verificar Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python no encontrado
    pause
    exit /b 1
)

echo [1/3] Verificando dependencias...
python -c "import chromadb" >nul 2>&1
if errorlevel 1 (
    echo Instalando chromadb...
    python -m pip install chromadb --quiet
)

python -c "import sentence_transformers" >nul 2>&1
if errorlevel 1 (
    echo Instalando sentence-transformers...
    python -m pip install sentence-transformers --quiet
)

python -c "import PyPDF2" >nul 2>&1
if errorlevel 1 (
    echo Instalando PyPDF2...
    python -m pip install PyPDF2 --quiet
)

python -c "import pdfplumber" >nul 2>&1
if errorlevel 1 (
    echo Instalando pdfplumber...
    python -m pip install pdfplumber --quiet
)

echo [2/3] Procesando documentos...
python backend\scripts\setup_vector_db.py

echo.
echo [3/3] Proceso completado
echo.
pause

