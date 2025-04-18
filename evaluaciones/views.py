# evaluaciones/views.py

from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth import login as auth_login, authenticate
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from django.contrib.auth.models import User
from .models import Perfil, Nino, Especialista, Juego, IntentoJuego, Resultado, Evaluacion

def index(request):
    return render(request, 'evaluaciones/index.html')

def registro(request):
    """
    Vista de registro de nuevos usuarios. Usa el UserCreationForm de Django,
    crea también un Perfil de invitado y loguea al usuario automáticamente.
    """
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            # Creamos el perfil como invitado
            Perfil.objects.create(user=user, rol='invitado')
            # Logueamos al usuario recién creado
            auth_login(request, user)
            return redirect('perfil')
    else:
        form = UserCreationForm()
    return render(request, 'evaluaciones/registro.html', {'form': form})

def login_view(request):
    """
    Vista de inicio de sesión. Si es POST y el formulario es válido,
    loguea y redirige al perfil.
    """
    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)
            return redirect('perfil')
    else:
        form = AuthenticationForm()
    return render(request, 'evaluaciones/login.html', {'form': form})

def perfil(request, nino_id=None):
    """
    Muestra el perfil:
    - Si recibe nino_id, carga el perfil de ese niño.
    - Si el usuario está autenticado y tiene un Perfil de 'nino', lo carga.
    - En otro caso muestra datos de invitado.
    """
    # Perfil de un niño concreto
    if nino_id:
        nino = get_object_or_404(Nino, id=nino_id)
        return render(request, 'evaluaciones/perfil.html', {'nino': nino, 'invitado': False})

    # Perfil del usuario actual
    if request.user.is_authenticated:
        perfil = Perfil.objects.filter(user=request.user).first()
        if perfil and perfil.rol == 'nino':
            # asumimos que existe un Nino vinculado a este User
            nino = Nino.objects.filter(email=request.user.email).first()
            return render(request, 'evaluaciones/perfil.html', {'nino': nino, 'invitado': False})
        else:
            # especialista u otro rol
            nombre = request.user.get_full_name() or request.user.username
            return render(request, 'evaluaciones/perfil.html', {'nombre': nombre, 'invitado': False})

    # Invitado
    return render(request, 'evaluaciones/perfil.html', {'nombre': 'Usuario Libre', 'invitado': True})

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
