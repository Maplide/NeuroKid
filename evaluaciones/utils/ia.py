# utils/ia.py
import os
import numpy as np
import joblib
from django.conf import settings

# Ruta al modelo
MODEL_PATH = os.path.join(settings.BASE_DIR, 'static', 'model', 'modelo_neurokid.pkl')

# Carga el modelo al iniciar
modelo_ia = joblib.load(MODEL_PATH)

# Etiquetas de salida del modelo
CLASES = ["TEA", "TDAH", "Discapacidad Intelectual", "Ansiedad/Depresión"]

def predecir_diagnostico(datos_entrada):
    """Predice la condición a partir del vector de entrada (10 valores)."""
    X = np.array([datos_entrada])
    predicciones = modelo_ia.predict_proba(X)
    idx_mayor = np.argmax(predicciones)
    return CLASES[idx_mayor], float(predicciones[0][idx_mayor])
