from django.shortcuts import render, redirect
from django.contrib.auth import login as auth_login, logout as auth_logout
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.utils.dateparse import parse_date

from evaluaciones.models import Perfil, Nino, Especialista

# Código secreto para especialistas
ESPECIALISTA_CODE = "ESPECIALISTA/NK2025"

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

        # Crear usuario y perfil
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

        return redirect('perfil')

    return render(request, 'evaluaciones/registro.html')

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

            return redirect('perfil')
    else:
        form = AuthenticationForm()
    return render(request, 'evaluaciones/login.html', {'form': form})

def logout_view(request):
    auth_logout(request)
    return redirect('index')

@login_required
def completar_datos_nino(request):
    if request.method == "POST":
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
        return redirect('perfil')  # Seguridad

    if request.method == 'POST':
        dni = request.POST.get('dni')
        rne = request.POST.get('rne')
        telefono = request.POST.get('telefono')
        institucion = request.POST.get('institucion')

        if dni and rne and telefono and institucion:
            especialista, _ = Especialista.objects.get_or_create(perfil=perfil)
            especialista.dni = dni
            especialista.rne = rne
            especialista.telefono = telefono
            especialista.institucion = institucion
            especialista.save()
            return redirect('perfil')

    return render(request, 'evaluaciones/completar_especialista.html')
