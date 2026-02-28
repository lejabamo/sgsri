"""
Wrapper de compatibilidad para el modelo DocumentoAdjunto.

El modelo real está definido en `app.models`. Este módulo solo lo
reexporta para mantener las importaciones existentes:
`from app.modelos.documentos import DocumentoAdjunto`
"""

from app.models import DocumentoAdjunto

__all__ = ["DocumentoAdjunto"]