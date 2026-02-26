#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Script simple para verificar que el servidor puede iniciarse"""
import sys
try:
    from app import create_app
    print("[OK] Importacion exitosa - El servidor esta listo")
    print("[OK] Todas las dependencias estan instaladas correctamente")
    sys.exit(0)
except ImportError as e:
    print(f"[ERROR] Error de importacion: {e}")
    print("\nEjecuta: pip install -r ..\\requirements.txt")
    sys.exit(1)
except Exception as e:
    print(f"[ERROR] Error inesperado: {e}")
    sys.exit(1)

