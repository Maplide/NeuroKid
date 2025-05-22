from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
import numpy as np

from evaluaciones.models import (
    Juego, Nino, IntentoJuego, IntentoJuegoInvitado, ResultadoIA
)
from evaluaciones.utils.ia import predecir_diagnostico


@csrf_exempt
def api_registrar_intento(request):
    if request.method != "POST":
        return JsonResponse({"error": "Método no permitido"}, status=405)

    data = json.loads(request.body)
    juego_nombre = data.get("juego")
    resultado = data.get("resultado", 0)

    print("📥 Datos recibidos:", data)

    try:
        juego = Juego.objects.get(nombre=juego_nombre)
    except Juego.DoesNotExist:
        print("❌ Juego no encontrado:", juego_nombre)
        return JsonResponse({"error": "Juego no encontrado"}, status=400)

    # 🧠 IA: preparar datos
    datos_vector = preparar_vector_para_modelo(juego.nombre, data)
    prediccion, probabilidad = predecir_diagnostico(datos_vector)

    # 🔐 Usuario autenticado (registrado)
    if request.user.is_authenticated:
        print("👤 Usuario autenticado:", request.user.username)
        try:
            nino = Nino.objects.get(user=request.user)
        except Nino.DoesNotExist:
            return JsonResponse({"error": "Niño no encontrado"}, status=400)

        # Guardar intento
        IntentoJuego.objects.create(
            juego=juego,
            nino=nino,
            resultado=resultado
        )

        # Guardar resultado IA
        ResultadoIA.objects.update_or_create(
            nino=nino,
            juego=juego,
            defaults={"prediccion": prediccion, "probabilidad": probabilidad}
        )

    # 🕹️ Usuario no autenticado → Modo libre
    else:
        invitado_id = request.session.get("modo_libre_id")
        if not invitado_id:
            print("🚫 Usuario sin sesión de modo libre.")
            return JsonResponse({"error": "No autorizado"}, status=403)

        print("👤 Usuario en modo libre:", invitado_id)
        IntentoJuegoInvitado.objects.create(
            juego=juego,
            invitado_id=invitado_id,
            resultado=resultado
        )

    print(f"✅ Resultado IA generado: {prediccion} ({probabilidad:.2f})")
    return JsonResponse({
        "status": "ok",
        "prediccion": prediccion,
        "probabilidad": f"{probabilidad:.2f}"
    })


def preparar_vector_para_modelo(nombre_juego, datos_juego):
    """
    Prepara los 10 valores de entrada simulados para cada juego.
    """
    vector = [0]*10

    if nombre_juego == "EmoMatch":
        vector[0] = datos_juego.get("resultado", 0)
        vector[1] = datos_juego.get("tiempo_promedio", 0)
        vector[2] = 1

    elif nombre_juego == "Atención Turbo":
        vector[3] = datos_juego.get("aciertos", 0)
        vector[4] = datos_juego.get("fallos", 0)
        vector[5] = datos_juego.get("tiempo_promedio", 0)

    elif nombre_juego == "Mano Firme":
        vector[6] = datos_juego.get("aciertos", 0)
        vector[7] = datos_juego.get("errores", 0)
        vector[8] = datos_juego.get("tiempo", 0)

    elif nombre_juego == "Respira y Flota":
        vector[9] = datos_juego.get("duracion_total", 0)

    return np.array(vector)
