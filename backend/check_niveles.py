from app import create_app, db
from app.models import niveles_probabilidad, niveles_impacto

app = create_app()
with app.app_context():
    print('=== NIVELES PROBABILIDAD ===')
    for np in niveles_probabilidad.query.all():
        attrs = dir(np)
        valor_attr = None
        for attr in ['Valor_Numerico', 'valor_numerico', 'ValorNumerico', 'valor']:
            if hasattr(np, attr):
                valor_attr = getattr(np, attr)
                break
        print(f'ID: {np.ID_NivelProbabilidad}, Nombre: "{np.Nombre}", Valor: {valor_attr}')
    
    print('\n=== NIVELES IMPACTO ===')
    for ni in niveles_impacto.query.all():
        attrs = dir(ni)
        valor_attr = None
        for attr in ['Valor_Numerico', 'valor_numerico', 'ValorNumerico', 'valor']:
            if hasattr(ni, attr):
                valor_attr = getattr(ni, attr)
                break
        print(f'ID: {ni.ID_NivelImpacto}, Nombre: "{ni.Nombre}", Valor: {valor_attr}')

