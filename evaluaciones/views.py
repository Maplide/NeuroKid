# evaluaciones/views.py
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth import login as auth_login, logout as auth_logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from .models import Perfil, Nino, Especialista, Juego, IntentoJuego, Resultado, Evaluacion
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json

def index(request):
    return render(request, 'evaluaciones/index.html')

def registro(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            Perfil.objects.create(user=user, rol='invitado')
            auth_login(request, user)
            return redirect('perfil')
    else:
        form = UserCreationForm()
    return render(request, 'evaluaciones/registro.html', {'form': form})

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

    # Usuario autenticado, buscamos su perfil
    perfil = Perfil.objects.filter(user=request.user).first()
    if perfil and perfil.rol == 'nino':
        # Asumimos que email de User = email en Nino
        nino = Nino.objects.filter(email=request.user.email).first()
        return render(request, 'evaluaciones/perfil.html', {
            'nino': nino,
            'invitado': False
        })
    else:
        # Especialista u otro
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
