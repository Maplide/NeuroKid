from django.shortcuts import render, get_object_or_404, redirect
from django.http import JsonResponse
from .models import Nino, Evaluacion
import random  # Simulando la IA por ahora
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import login as auth_login

def index(request):
    return render(request, 'evaluaciones/index.html')

def registro(request):
    return render(request, 'evaluaciones/registro.html')

def nosotros(request):
    return render(request, 'evaluaciones/nosotros.html')

def servicios(request):
    return render(request, 'evaluaciones/servicios.html')

def contacto(request):
    return render(request, 'evaluaciones/contacto.html')

def juego_reconocimiento_emocional(request):
    return render(request, 'evaluaciones/juego_reconocimiento_emocional.html')

def juego_memoria(request):
    return render(request, 'evaluaciones/juego_memoria.html')

def comenzar(request):
    return render(request, 'evaluaciones/comenzar.html')

def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)
            return redirect('perfil')  # Asegurar que 'perfil' esté en urls.py
    else:
        form = AuthenticationForm()

    return render(request, 'evaluaciones/login.html', {'form': form})

def perfil(request, nino_id=None):
    """
    Maneja el perfil de usuario:
    - Si hay un `nino_id`, muestra el perfil del niño.
    - Si el usuario está autenticado, recupera su información.
    - Si entra como invitado, muestra un nombre genérico.
    """
    if nino_id:
        nino = get_object_or_404(Nino, id=nino_id)
        return render(request, 'evaluaciones/perfil.html', {'nino': nino, 'invitado': False})

    if request.user.is_authenticated:
        nino = Nino.objects.filter(usuario=request.user).first()
        nombre = nino.nombre if nino else request.user.username
        invitado = False
    else:
        nombre = "Usuario Libre"
        invitado = True

    return render(request, 'evaluaciones/perfil.html', {'nombre': nombre, 'invitado': invitado})
