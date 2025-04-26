# evaluaciones/views.py
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from django.contrib.auth import login as auth_login, logout as auth_logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from django.contrib.auth.hashers import make_password
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User
from django.http import JsonResponse

from .models import Perfil, Nino, Especialista, Juego, IntentoJuego, Resultado, Evaluacion

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
        return redirect('perfil')
    
    return render(request, 'evaluaciones/registro.html')

def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)
            return redirect('perfil')
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
    """
    Perfil de niño o especialista, requiere login.
    """
    # Si pasamos un nino_id explícito
    if nino_id:
        nino = get_object_or_404(Nino, id=nino_id)
        return render(request, 'evaluaciones/perfil.html', {
            'nino': nino,
            'invitado': False
        })

    perfil = Perfil.objects.filter(user=request.user).first()

    if perfil and perfil.rol == 'nino':
        # Asumimos que email de User = email en Nino
        nino = Nino.objects.filter(user=request.user).first()
        # HISTORIAL DE INTENTOS POR JUEGO
        intentos_por_juego = {}
        if nino:
            intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego').order_by('-fecha')
            for intento in intentos:
                nombre_juego = intento.juego.nombre
                if nombre_juego not in intentos_por_juego:
                    intentos_por_juego[nombre_juego] = []
                intentos_por_juego[nombre_juego].append(intento)

        return render(request, 'evaluaciones/perfil.html', {
            'nino': nino,
            'invitado': False,
            'intentos': intentos_por_juego
        })

    # Si es especialista u otro
    nombre = request.user.get_full_name() or request.user.username
    return render(request, 'evaluaciones/perfil.html', {
        'nombre': nombre,
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

@csrf_exempt
def api_registrar_intento(request):
    if request.method=="POST" and request.user.is_authenticated:
        data = json.loads(request.body)
        juego = Juego.objects.get(nombre="Emo‑Match")
        nino  = Nino.objects.get(email=request.user.email)
        IntentoJuego.objects.create(juego=juego, nino=nino, resultado=data["intentos"])
        return JsonResponse({"status":"ok"})
    return JsonResponse({"error":"no autorizado"}, status=403)
