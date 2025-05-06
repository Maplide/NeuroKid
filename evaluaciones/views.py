# evaluaciones/views.py
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from django.contrib.auth import login as auth_login, logout as auth_logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User
from evaluaciones.utils.ia import predecir_diagnostico
from django.http import JsonResponse
from django.utils.dateparse import parse_date

import datetime

import numpy as np

from .models import Perfil, Nino, Especialista, Juego, IntentoJuego, Resultado, Evaluacion, ResultadoIA

import json

def index(request):
    return render(request, 'evaluaciones/index.html')

# ----------------------------------------------------------------
# Código secreto para validar a los Especialistas
ESPECIALISTA_CODE = "ESPECIALISTA/NK2025"
# ----------------------------------------------------------------

def registro(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        pass1 = request.POST.get('password1')
        pass2 = request.POST.get('password2')
        rol = request.POST.get('rol')
        code = request.POST.get('specialist_code')

        errores = []

        if not username or not pass1 or not pass2:
            errores.append("Todos los campos son obligatorios.")
        elif pass1 != pass2:
            errores.append("Las contraseñas no coinciden.")
        elif User.objects.filter(username=username).exists():
            errores.append("Ese usuario ya existe.")
        elif rol == "especialista" and code != ESPECIALISTA_CODE:
            errores.append("Código de especialista inválido.")

        if errores:
            return render(request, 'evaluaciones/registro.html', {
                'errores': errores,
                'formdata': request.POST
            })

        # Si todo bien, creamos el usuario
        user = User.objects.create(
            username=username,
            password=make_password(pass1)
        )
        Perfil.objects.create(user=user, rol=rol)
        auth_login(request, user)

        if rol == 'nino':
            return redirect('completar_nino')
        elif rol == 'especialista':
            return redirect('completar_especialista')

        return redirect('perfil')  # Fallback

    return render(request, 'evaluaciones/registro.html')

@login_required
def completar_datos_nino(request):
    if request.method == "POST":
        print("🟢 POST recibido:", request.POST)

        fecha_nacimiento = parse_date(request.POST.get("fecha_nacimiento"))
        genero = request.POST.get("genero")
        email = request.POST.get("email")

        try:
            if not fecha_nacimiento:
                raise ValueError("Fecha inválida")

            Nino.objects.create(
                user=request.user,
                fecha_nacimiento=fecha_nacimiento,
                genero=genero,
                email=email
            )
            return redirect('perfil')

        except Exception as e:
            print("❌ Error al guardar:", e)
            messages.error(request, "No se pudo completar el registro del niño.")

    return render(request, 'evaluaciones/completar_nino.html')
@login_required
def completar_datos_especialista(request):
    perfil = Perfil.objects.filter(user=request.user, rol='especialista').first()
    if not perfil:
        return redirect('perfil')  # Seguridad: solo especialistas acceden

    if request.method == 'POST':
        dni = request.POST.get('dni')
        rne = request.POST.get('rne')
        telefono = request.POST.get('telefono')
        institucion = request.POST.get('institucion')

        if dni and rne and telefono and institucion:
            especialista, creado = Especialista.objects.get_or_create(perfil=perfil)
            especialista.dni = dni
            especialista.rne = rne
            especialista.telefono = telefono
            especialista.institucion = institucion
            especialista.save()
            return redirect('perfil')

    return render(request, 'evaluaciones/completar_especialista.html')

def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)

            perfil = Perfil.objects.filter(user=user).first()
            if perfil:
                if perfil.rol == 'nino':
                    nino = Nino.objects.filter(user=user).first()
                    if not nino:
                        return redirect('completar_nino')
                    return redirect('perfil')

                elif perfil.rol == 'especialista':
                    especialista = Especialista.objects.filter(perfil=perfil).first()
                    if not especialista:
                        return redirect('completar_especialista')
                    return redirect('perfil')

            return redirect('perfil')  # Otro tipo
    else:
        form = AuthenticationForm()
    return render(request, 'evaluaciones/login.html', {'form': form})

def logout_view(request):
    auth_logout(request)
    return redirect('index')

def perfil_libre(request):
    """
    Vista exclusiva para usuarios invitados:
    muestra el perfil con invitado=True sin pedir login.
    """
    return render(request, 'evaluaciones/perfil.html', {
        'nombre': 'Usuario Libre',
        'invitado': True
    })

@login_required
def perfil(request, nino_id=None):
    perfil = Perfil.objects.filter(user=request.user).first()

    # Vista personalizada para Niño
    if perfil and perfil.rol == 'nino':
        nino = Nino.objects.filter(user=request.user).first()
        intentos_por_juego = {}
        resultados_ia = {}

        if nino:
            intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego').order_by('-fecha')
            for intento in intentos:
                nombre_juego = intento.juego.nombre
                if nombre_juego not in intentos_por_juego:
                    intentos_por_juego[nombre_juego] = []
                intentos_por_juego[nombre_juego].append(intento)

            # Obtener últimos resultados IA por juego
            for r in ResultadoIA.objects.filter(nino=nino).select_related('juego').order_by('juego', '-fecha'):
                resultados_ia[r.juego.nombre] = r  # sobrescribe dejando el más reciente

        return render(request, 'evaluaciones/perfil.html', {
            'nino': nino,
            'invitado': False,
            'intentos': intentos_por_juego,
            'resultados_ia': resultados_ia
        })

    # Vista personalizada para Especialista
    elif perfil and perfil.rol == 'especialista':
        especialista = Especialista.objects.get(perfil=perfil)  # <-- Añade esta línea
        resultados_globales = ResultadoIA.objects.select_related('nino', 'juego').order_by('-fecha')
        return render(request, 'evaluaciones/perfil.html', {
            'nombre': request.user.get_full_name() or request.user.username,
            'rol': 'especialista',
            'especialista': especialista,  # <-- Y esta línea
            'resultados_globales': resultados_globales,
            'invitado': False
        })

    # Otro tipo de usuario
    return render(request, 'evaluaciones/perfil.html', {
        'nombre': request.user.get_full_name() or request.user.username,
        'invitado': False
    })

def nosotros(request):
    return render(request, 'evaluaciones/nosotros.html')

def servicios(request):
    return render(request, 'evaluaciones/servicios.html')

def contacto(request):
    return render(request, 'evaluaciones/contacto.html')

def comenzar(request):
    return render(request, 'evaluaciones/comenzar.html')

def juego_emo_match(request):
    return render(request, 'evaluaciones/games/game_emo_match.html', {
        'invitado': not request.user.is_authenticated
    })

def juego_turbo(request):
    return render(request, 'evaluaciones/games/game_turbo.html', {
        'invitado': not request.user.is_authenticated
    })

def juego_mano_firme(request):
    return render(request, 'evaluaciones/games/game_mano_firme.html', {
        'invitado': not request.user.is_authenticated
    })

def juego_respira_flota(request):
    return render(request, 'evaluaciones/games/game_respira_flota.html', {
        'invitado': not request.user.is_authenticated
    })

def preparar_vector_para_modelo(nombre_juego, datos_juego):
    """
    Prepara los 10 valores de entrada simulados para cada juego.
    """
    vector = [0]*10  # Todos inicializados en 0

    if nombre_juego == "EmoMatch":
        vector[0] = datos_juego.get("resultado", 0)  # Intentos
        vector[1] = datos_juego.get("tiempo_promedio", 0)  # Tiempo promedio por intento
        vector[2] = 1  # Marcamos que jugó EmoMatch

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

@csrf_exempt
def api_registrar_intento(request):
    if request.method == "POST" and request.user.is_authenticated:
        data = json.loads(request.body)
        print("📥 Datos recibidos:", data)
        print("👤 Usuario autenticado:", request.user.username)

        try:
            nino = Nino.objects.get(user=request.user)
        except Nino.DoesNotExist:
            print("❌ Niño no encontrado para el usuario.")
            return JsonResponse({"error": "Niño no encontrado"}, status=400)

        try:
            juego = Juego.objects.get(nombre=data.get("juego"))
        except Juego.DoesNotExist:
            print("❌ Juego no encontrado:", data.get("juego"))
            return JsonResponse({"error": "Juego no encontrado"}, status=400)

        # Guardar intento clásico
        IntentoJuego.objects.create(
            juego=juego,
            nino=nino,
            resultado=data.get("resultado", 0)
        )

        # IA
        datos_vector = preparar_vector_para_modelo(juego.nombre, data)
        prediccion, probabilidad = predecir_diagnostico(datos_vector)

        # Guardar resultado IA (último por juego)
        ResultadoIA.objects.update_or_create(
            nino=nino,
            juego=juego,
            defaults={
                "prediccion": prediccion,
                "probabilidad": probabilidad
            }
        )

        print(f"✅ Resultado IA guardado: {juego.nombre} = {prediccion} ({probabilidad:.2f})")
        return JsonResponse({
            "status": "ok",
            "prediccion": prediccion,
            "probabilidad": f"{probabilidad:.2f}"
        })

    print("🚫 Usuario no autenticado o método inválido.")
    return JsonResponse({"error": "no autorizado"}, status=403)

@login_required
def dashboard_especialista(request):
    perfil = Perfil.objects.filter(user=request.user).first()
    if not perfil or perfil.rol != 'especialista':
        return redirect('perfil')  # Solo especialistas pueden entrar

    # Última predicción por niño y por juego
    predicciones = ResultadoIA.objects.select_related('nino', 'juego') \
        .order_by('nino__id', 'juego__id', '-fecha')

    resultados = {}
    for pred in predicciones:
        key = (pred.nino.id, pred.juego.id)
        if key not in resultados:
            resultados[key] = pred  # Solo guardamos la más reciente

    # Agrupamos por categoría
    resumen = {
        "TEA": 0,
        "TDAH": 0,
        "Discapacidad Intelectual": 0,
        "Ansiedad/Depresión": 0,
    }
    for p in resultados.values():
        if p.prediccion in resumen:
            resumen[p.prediccion] += 1

    return render(request, 'evaluaciones/dashboard_especialista.html', {
        'resumen': resumen,
        'resultados': resultados.values()
    })
