from django.core.mail import EmailMessage
from .models import LogEnvioReporte

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
from .models import IntentoJuegoInvitado

from django.template.loader import get_template
from django.http import HttpResponse
from weasyprint import HTML
from datetime import date

from django.core.paginator import Paginator

import uuid

from django.db.models import Avg, Q

import datetime
from datetime import date

from django.db.models import Count, Avg

import numpy as np

from .models import Perfil, Nino, Especialista, Juego, IntentoJuego, IntentoJuegoInvitado, Resultado, Evaluacion, ResultadoIA

import json

def todas_las_medallas():
    return {
        "EmoMatch": ("🥇 Oro", 80),
        "Atención Turbo": ("🥈 Plata", 15),
        "Mano Firme": ("🥉 Bronce", 10),
        "Respira y Flota": ("🌟 Relax", 3),
    }

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
    if "modo_libre_id" not in request.session:
        request.session["modo_libre_id"] = str(uuid.uuid4())[:8]

    invitado_id = request.session["modo_libre_id"]

    intentos = IntentoJuegoInvitado.objects.filter(invitado_id=invitado_id).select_related('juego').order_by('-fecha')

    intentos_por_juego = {}
    medallas = {}
    recomendaciones = {}

    for intento in intentos:
        juego = intento.juego.nombre
        if juego not in intentos_por_juego:
            intentos_por_juego[juego] = []
        intentos_por_juego[juego].append(intento)

    # Calcular medallas y recomendaciones por juego
    for juego, lista in intentos_por_juego.items():
        mejor_puntaje = max(i.resultado for i in lista)
        medalla = obtener_medalla(juego, mejor_puntaje)
        if medalla:
            medallas[juego] = medalla

        # Simular análisis IA basado solo en puntaje
        if mejor_puntaje >= 9:
            recomendaciones[juego] = "👍 Excelente desempeño. Puede avanzar a retos mayores."
        elif mejor_puntaje >= 6:
            recomendaciones[juego] = "🧐 Desempeño regular. Reforzar mediante práctica continua."
        else:
            recomendaciones[juego] = "⚠️ Desempeño bajo. Sugerimos repetir el juego con apoyo de un adulto."

    return render(request, 'evaluaciones/perfil.html', {
        'nombre': f'Invitado-{invitado_id}',
        'modo_libre_id': invitado_id,
        'invitado': True,
        'intentos': intentos_por_juego,
        'medallas': medallas,
        'todas_medallas': todas_las_medallas(),
        'recomendaciones': recomendaciones  # ✅ ahora por juego
    })

@login_required
def perfil(request, nino_id=None):
    perfil = Perfil.objects.filter(user=request.user).first()

    # Vista personalizada para Niño
    if perfil and perfil.rol == 'nino':
        nino = Nino.objects.filter(user=request.user).first()
        intentos_por_juego = {}
        resultados_ia = {}
        medallas = {}
        recomendaciones = []

        if nino:
            intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego').order_by('-fecha')
            for intento in intentos:
                nombre_juego = intento.juego.nombre
                if nombre_juego not in intentos_por_juego:
                    intentos_por_juego[nombre_juego] = []
                intentos_por_juego[nombre_juego].append(intento)

            # Obtener últimos resultados IA por juego
            for r in ResultadoIA.objects.filter(nino=nino).select_related('juego').order_by('juego', '-fecha'):
                resultados_ia[r.juego.nombre] = r

            # Calcular medallas por juego
            for juego, lista in intentos_por_juego.items():
                mejor_puntaje = max(i.resultado for i in lista)
                medalla = obtener_medalla(juego, mejor_puntaje)
                if medalla:
                    medallas[juego] = medalla

            print("RESULTADOS IA:", resultados_ia)

            # ✅ Recomendaciones según predicciones reales
            for r in resultados_ia.values():
                juego = r.juego.nombre
                pred = r.prediccion

                if juego == "EmoMatch":
                    if pred == "TEA":
                        recomendaciones.append("🧩 Se identifican rasgos compatibles con TEA. Fomentar juegos que expresen emociones.")
                    elif pred == "Ansiedad/Depresión":
                        recomendaciones.append("😟 Posibles signos emocionales. Promover espacios de conversación y actividades de expresión.")
                    elif pred == "Discapacidad Intelectual":
                        recomendaciones.append("📚 Dificultad en reconocimiento emocional. Usar apoyos visuales simples.")
                    elif pred == "TDAH":
                        recomendaciones.append("🎯 Dificultades de enfoque en emociones. Combinar con dinámicas visuales y pausas activas.")

                elif juego == "Atención Turbo":
                    if pred == "TDAH":
                        recomendaciones.append("⚡ Atención inestable. Implementar rutinas visuales y ejercicios de enfoque progresivo.")
                    elif pred == "Discapacidad Intelectual":
                        recomendaciones.append("🧠 Atención general limitada. Sugerimos adaptar tareas con apoyos visuales.")
                    elif pred == "Ansiedad/Depresión":
                        recomendaciones.append("😔 La atención podría verse afectada por el estado emocional. Promover ambientes tranquilos.")
                    elif pred == "TEA":
                        recomendaciones.append("🔁 Atención selectiva observada. Usar señales claras y estructuración de instrucciones.")

                elif juego == "Mano Firme":
                    if pred == "Discapacidad Intelectual":
                        recomendaciones.append("🔧 Se sugiere reforzar motricidad fina. Usar actividades como recortes o modelado.")
                    elif pred == "TDAH":
                        recomendaciones.append("✋ Inestabilidad motora por impulsividad. Probar con trazados guiados y pausas.")
                    elif pred == "TEA":
                        recomendaciones.append("🖍️ Puede presentar rigidez en el trazo. Sugerimos usar herramientas sensoriales.")
                    elif pred == "Ansiedad/Depresión":
                        recomendaciones.append("📐 Motricidad afectada por estado anímico. Actividades suaves como pintar o plastilina.")

                elif juego == "Respira y Flota":
                    if pred == "Ansiedad/Depresión":
                        recomendaciones.append("🌬️ Señales de tensión emocional. Practicar respiración guiada y relajación diaria.")
                    elif pred == "TEA":
                        recomendaciones.append("🧘 Dificultades para seguir ritmo. Reforzar rutinas con apoyo visual y auditivo.")
                    elif pred == "TDAH":
                        recomendaciones.append("🌀 Respiración agitada. Usar juegos de control respiratorio con tiempo y metas.")
                    elif pred == "Discapacidad Intelectual":
                        recomendaciones.append("📉 Limitaciones en autorregulación. Incluir actividades de relajación con apoyo externo.")

        return render(request, 'evaluaciones/perfil.html', {
            'nino': nino,
            'invitado': False,
            'intentos': intentos_por_juego,
            'resultados_ia': resultados_ia,
            'medallas': medallas,
            'todas_medallas': todas_las_medallas(),
            'recomendaciones': recomendaciones
        })

    # Vista para Especialista
    elif perfil and perfil.rol == 'especialista':
        especialista = Especialista.objects.get(perfil=perfil)
        
        filtro_nombre = request.GET.get('nombre', '')
        filtro_juego = request.GET.get('juego', '')
        filtro_fecha = request.GET.get('fecha', '')

        resultados = ResultadoIA.objects.select_related('nino', 'juego')

        # Aplicar filtros
        if filtro_nombre:
            resultados = resultados.filter(nino__user__username__icontains=filtro_nombre)

        if filtro_juego:
            resultados = resultados.filter(juego__nombre__icontains=filtro_juego)

        if filtro_fecha:
            resultados = resultados.filter(fecha__date=filtro_fecha)

        # Ordenar y paginar
        resultados = resultados.order_by('-fecha')
        paginator = Paginator(resultados, 20)
        page_number = request.GET.get('page')
        page_obj = paginator.get_page(page_number)

        return render(request, 'evaluaciones/perfil.html', {
            'nombre': request.user.get_full_name() or request.user.username,
            'rol': 'especialista',
            'especialista': especialista,
            'filtro_nombre': filtro_nombre,
            'filtro_juego': filtro_juego,
            'filtro_fecha': filtro_fecha,
            'resultados_globales': page_obj,
            'invitado': False
        })

    # Otro usuario
    return render(request, 'evaluaciones/perfil.html', {
        'nombre': request.user.get_full_name() or request.user.username,
        'invitado': False
    })

@login_required
def perfil_nino_pdf(request):
    perfil = Perfil.objects.filter(user=request.user).first()
    if not perfil or perfil.rol != 'nino':
        return redirect('perfil')

    nino = Nino.objects.filter(user=request.user).first()
    intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego')
    resultados_ia = ResultadoIA.objects.filter(nino=nino).select_related('juego')

    # Agrupar intentos por juego
    intentos_por_juego = {}
    for intento in intentos:
        nombre_juego = intento.juego.nombre
        if nombre_juego not in intentos_por_juego:
            intentos_por_juego[nombre_juego] = []
        intentos_por_juego[nombre_juego].append(intento)

    # Obtener medallas
    def obtener_medalla(juego_nombre, puntaje):
        if juego_nombre == "EmoMatch":
            return "🥇 Oro" if puntaje >= 80 else None
        elif juego_nombre == "Atención Turbo":
            return "🥈 Plata" if puntaje >= 15 else None
        elif juego_nombre == "Mano Firme":
            return "🥉 Bronce" if puntaje >= 10 else None
        elif juego_nombre == "Respira y Flota":
            return "🌟 Relax" if puntaje >= 3 else None
        return None

    medallas = {}
    for juego, lista in intentos_por_juego.items():
        mejor = max(i.resultado for i in lista)
        medalla = obtener_medalla(juego, mejor)
        if medalla:
            medallas[juego] = medalla

    # Recomendaciones personalizadas (simples por ahora)
    recomendaciones = []

    for r in resultados_ia:
        juego = r.juego.nombre
        pred = r.prediccion

        if juego == "EmoMatch":
            if pred == "TEA":
                recomendaciones.append("🧩 Se identifican rasgos compatibles con TEA. Fomentar juegos que expresen emociones.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("😟 Posibles signos emocionales. Promover espacios de conversación y actividades de expresión.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("📚 Dificultad en reconocimiento emocional. Usar apoyos visuales simples.")
            elif pred == "TDAH":
                recomendaciones.append("🎯 Dificultades de enfoque en emociones. Combinar con dinámicas visuales y pausas activas.")

        elif juego == "Atención Turbo":
            if pred == "TDAH":
                recomendaciones.append("⚡ Atención inestable. Implementar rutinas visuales y ejercicios de enfoque progresivo.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("🧠 Atención general limitada. Sugerimos adaptar tareas con apoyos visuales.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("😔 La atención podría verse afectada por el estado emocional. Promover ambientes tranquilos.")
            elif pred == "TEA":
                recomendaciones.append("🔁 Atención selectiva observada. Usar señales claras y estructuración de instrucciones.")

        elif juego == "Mano Firme":
            if pred == "Discapacidad Intelectual":
                recomendaciones.append("🔧 Se sugiere reforzar motricidad fina. Usar actividades como recortes o modelado.")
            elif pred == "TDAH":
                recomendaciones.append("✋ Inestabilidad motora por impulsividad. Probar con trazados guiados y pausas.")
            elif pred == "TEA":
                recomendaciones.append("🖍️ Puede presentar rigidez en el trazo. Sugerimos usar herramientas sensoriales.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("📐 Motricidad afectada por estado anímico. Actividades suaves como pintar o plastilina.")

        elif juego == "Respira y Flota":
            if pred == "Ansiedad/Depresión":
                recomendaciones.append("🌬️ Señales de tensión emocional. Practicar respiración guiada y relajación diaria.")
            elif pred == "TEA":
                recomendaciones.append("🧘 Dificultades para seguir ritmo. Reforzar rutinas con apoyo visual y auditivo.")
            elif pred == "TDAH":
                recomendaciones.append("🌀 Respiración agitada. Usar juegos de control respiratorio con tiempo y metas.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("📉 Limitaciones en autorregulación. Incluir actividades de relajación con apoyo externo.")


    template = get_template('evaluaciones/pdf_perfil_nino.html')
    html_string = template.render({
        'nino': nino,
        'intentos': intentos_por_juego,
        'resultados_ia': resultados_ia,
        'medallas': medallas,
        'recomendaciones': recomendaciones,
        'fecha': date.today()
    })

    html = HTML(string=html_string, base_url=request.build_absolute_uri())
    pdf = html.write_pdf()

    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = 'inline; filename="perfil_niño.pdf"'
    return response

@login_required
def perfil_nino_pdf_admin(request, nino_id):
    perfil = Perfil.objects.filter(user=request.user).first()
    if not perfil or perfil.rol != 'especialista':
        return redirect('perfil')

    try:
        nino = Nino.objects.get(id=nino_id)
    except Nino.DoesNotExist:
        return HttpResponse("Niño no encontrado.", status=404)

    intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego')
    resultados_ia = ResultadoIA.objects.filter(nino=nino).select_related('juego')

    # Agrupar intentos por juego
    intentos_por_juego = {}
    for intento in intentos:
        nombre_juego = intento.juego.nombre
        if nombre_juego not in intentos_por_juego:
            intentos_por_juego[nombre_juego] = []
        intentos_por_juego[nombre_juego].append(intento)

    # Medallas
    def obtener_medalla(juego_nombre, puntaje):
        if juego_nombre == "EmoMatch":
            return "🥇 Oro" if puntaje >= 80 else None
        elif juego_nombre == "Atención Turbo":
            return "🥈 Plata" if puntaje >= 15 else None
        elif juego_nombre == "Mano Firme":
            return "🥉 Bronce" if puntaje >= 10 else None
        elif juego_nombre == "Respira y Flota":
            return "🌟 Relax" if puntaje >= 3 else None
        return None

    medallas = {}
    for juego, lista in intentos_por_juego.items():
        mejor = max(i.resultado for i in lista)
        medalla = obtener_medalla(juego, mejor)
        if medalla:
            medallas[juego] = medalla

    # Recomendaciones
    recomendaciones = []

    for r in resultados_ia:
        juego = r.juego.nombre
        pred = r.prediccion

        if juego == "EmoMatch":
            if pred == "TEA":
                recomendaciones.append("🧩 Se identifican rasgos compatibles con TEA. Fomentar juegos que expresen emociones.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("😟 Posibles signos emocionales. Promover espacios de conversación y actividades de expresión.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("📚 Dificultad en reconocimiento emocional. Usar apoyos visuales simples.")
            elif pred == "TDAH":
                recomendaciones.append("🎯 Dificultades de enfoque en emociones. Combinar con dinámicas visuales y pausas activas.")

        elif juego == "Atención Turbo":
            if pred == "TDAH":
                recomendaciones.append("⚡ Atención inestable. Implementar rutinas visuales y ejercicios de enfoque progresivo.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("🧠 Atención general limitada. Sugerimos adaptar tareas con apoyos visuales.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("😔 La atención podría verse afectada por el estado emocional. Promover ambientes tranquilos.")
            elif pred == "TEA":
                recomendaciones.append("🔁 Atención selectiva observada. Usar señales claras y estructuración de instrucciones.")

        elif juego == "Mano Firme":
            if pred == "Discapacidad Intelectual":
                recomendaciones.append("🔧 Se sugiere reforzar motricidad fina. Usar actividades como recortes o modelado.")
            elif pred == "TDAH":
                recomendaciones.append("✋ Inestabilidad motora por impulsividad. Probar con trazados guiados y pausas.")
            elif pred == "TEA":
                recomendaciones.append("🖍️ Puede presentar rigidez en el trazo. Sugerimos usar herramientas sensoriales.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("📐 Motricidad afectada por estado anímico. Actividades suaves como pintar o plastilina.")

        elif juego == "Respira y Flota":
            if pred == "Ansiedad/Depresión":
                recomendaciones.append("🌬️ Señales de tensión emocional. Practicar respiración guiada y relajación diaria.")
            elif pred == "TEA":
                recomendaciones.append("🧘 Dificultades para seguir ritmo. Reforzar rutinas con apoyo visual y auditivo.")
            elif pred == "TDAH":
                recomendaciones.append("🌀 Respiración agitada. Usar juegos de control respiratorio con tiempo y metas.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("📉 Limitaciones en autorregulación. Incluir actividades de relajación con apoyo externo.")


    # Renderizar
    template = get_template('evaluaciones/pdf_perfil_nino.html')
    html_string = template.render({
        'nino': nino,
        'intentos': intentos_por_juego,
        'resultados_ia': resultados_ia,
        'medallas': medallas,
        'recomendaciones': recomendaciones,
        'fecha': date.today()
    })

    html = HTML(string=html_string, base_url=request.build_absolute_uri())
    pdf = html.write_pdf()

    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = f'inline; filename="{nino.user.username}_perfil.pdf"'
    return response

@login_required
def reporte_global_pdf(request):
    perfil = Perfil.objects.filter(user=request.user).first()
    if not perfil or perfil.rol != 'especialista':
        return redirect('perfil')

    total_ninos = Nino.objects.count()
    total_invitados = IntentoJuegoInvitado.objects.values('invitado_id').distinct().count()
    total_partidas = IntentoJuego.objects.count() + IntentoJuegoInvitado.objects.count()

    resumen_juegos = Juego.objects.annotate(
        total_partidas=Count('intentojuego') + Count('intentojuegoinvitado')
    ).values('nombre', 'total_partidas')

    confianza_ia = ResultadoIA.objects.values('juego__nombre').annotate(
        promedio=Avg('probabilidad')
    )
    confianza_dict = {i['juego__nombre']: round(i['promedio'], 2) for i in confianza_ia}

    resultados = ResultadoIA.objects.select_related('nino', 'juego') \
                    .order_by('nino__id', 'juego__id', '-fecha')

    ultimos = {}
    for r in resultados:
        key = (r.nino.id, r.juego.id)
        if key not in ultimos:
            ultimos[key] = r

    template = get_template('evaluaciones/pdf_reporte_global.html')
    html_string = template.render({
        'total_ninos': total_ninos,
        'total_invitados': total_invitados,
        'total_partidas': total_partidas,
        'resumen_juegos': resumen_juegos,
        'confianza_ia': confianza_dict,
        'resultados': ultimos.values(),
        'fecha': date.today()
    })

    pdf = HTML(string=html_string, base_url=request.build_absolute_uri()).write_pdf()
    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = 'inline; filename="reporte_global.pdf"'
    return response

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
        from .models import IntentoJuegoInvitado  # asegúrate que esté importado
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

@login_required
def dashboard_especialista(request):
    perfil = Perfil.objects.filter(user=request.user).first()
    if not perfil or perfil.rol != 'especialista':
        return redirect('perfil')

    # --- 1. Totales ---
    total_ninos = Nino.objects.count()
    total_invitados = IntentoJuegoInvitado.objects.values('invitado_id').distinct().count()
    total_partidas = IntentoJuego.objects.count() + IntentoJuegoInvitado.objects.count()

    # --- 2. Juegos más jugados ---
    juegos = Juego.objects.filter(activo=True)
    partidas_por_juego = []
    for juego in juegos:
        reg = IntentoJuego.objects.filter(juego=juego).count()
        libre = IntentoJuegoInvitado.objects.filter(juego=juego).count()
        total = reg + libre
        partidas_por_juego.append({
            'juego': juego.nombre,
            'tipo': juego.get_tipo_display(),
            'total': total
        })
    partidas_por_juego.sort(key=lambda x: x['total'], reverse=True)

    # --- 3. Promedio de confianza IA por juego ---
    confianza_ia = ResultadoIA.objects.values('juego__nombre').annotate(
        promedio=Avg('probabilidad')
    )
    confianza_dict = {i['juego__nombre']: round(i['promedio'], 2) for i in confianza_ia}

    # --- 4. Filtros en resultados IA ---
    filtro_nombre = request.GET.get('nombre', '')
    filtro_juego = request.GET.get('juego', '')
    filtro_fecha = request.GET.get('fecha', '')

    resultados_query = ResultadoIA.objects.select_related('nino', 'juego')

    if filtro_nombre:
        resultados_query = resultados_query.filter(nino__user__username__icontains=filtro_nombre)

    if filtro_juego:
        resultados_query = resultados_query.filter(juego__nombre__icontains=filtro_juego)

    if filtro_fecha:
        resultados_query = resultados_query.filter(fecha__date=filtro_fecha)

    resultados_query = resultados_query.order_by('-fecha')

    # --- Paginación ---
    paginator = Paginator(resultados_query, 20)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    # --- 5. Clasificación por edad ---
    def calcular_edad(nacimiento):
        hoy = date.today()
        return hoy.year - nacimiento.year - ((hoy.month, hoy.day) < (nacimiento.month, nacimiento.day))

    edades = {'4-6': 0, '7-9': 0, '10-11': 0}
    for n in Nino.objects.all():
        edad = calcular_edad(n.fecha_nacimiento)
        if 4 <= edad <= 6:
            edades['4-6'] += 1
        elif 7 <= edad <= 9:
            edades['7-9'] += 1
        elif 10 <= edad <= 11:
            edades['10-11'] += 1

    return render(request, 'evaluaciones/dashboard_especialista.html', {
        'total_ninos': total_ninos,
        'total_invitados': total_invitados,
        'total_partidas': total_partidas,
        'partidas_por_juego': partidas_por_juego,
        'confianza_ia': confianza_dict,
        'edades': edades,
        'resultados': page_obj,  # 👈 con paginación

        # 👇 filtros para el formulario
        'filtro_nombre': filtro_nombre,
        'filtro_juego': filtro_juego,
        'filtro_fecha': filtro_fecha
    })

def obtener_medalla(juego_nombre, puntaje):
    if juego_nombre == "EmoMatch":
        return "🥇 Oro" if puntaje >= 80 else None
    elif juego_nombre == "Atención Turbo":
        return "🥈 Plata" if puntaje >= 15 else None
    elif juego_nombre == "Mano Firme":
        return "🥉 Bronce" if puntaje >= 10 else None
    elif juego_nombre == "Respira y Flota":
        return "🌟 Relax" if puntaje >= 3 else None
    return None

@login_required
def enviar_reporte_por_email(request, nino_id):
    perfil = Perfil.objects.filter(user=request.user, rol='especialista').first()
    if not perfil:
        return HttpResponse("Acceso no autorizado", status=403)

    especialista = Especialista.objects.get(perfil=perfil)
    nino = get_object_or_404(Nino, id=nino_id)

    # Renderizar PDF
    intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego')
    resultados_ia = ResultadoIA.objects.filter(nino=nino).select_related('juego')
    intentos_por_juego = {}
    for intento in intentos:
        nombre_juego = intento.juego.nombre
        intentos_por_juego.setdefault(nombre_juego, []).append(intento)

    medallas = {}
    for juego, lista in intentos_por_juego.items():
        mejor = max(i.resultado for i in lista)
        medalla = obtener_medalla(juego, mejor)
        if medalla:
            medallas[juego] = medalla

    recomendaciones = []

    for r in resultados_ia:
        juego = r.juego.nombre
        pred = r.prediccion

        if juego == "EmoMatch":
            if pred == "TEA":
                recomendaciones.append("🧩 Se identifican rasgos compatibles con TEA. Fomentar juegos que expresen emociones.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("😟 Posibles signos emocionales. Promover espacios de conversación y actividades de expresión.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("📚 Dificultad en reconocimiento emocional. Usar apoyos visuales simples.")
            elif pred == "TDAH":
                recomendaciones.append("🎯 Dificultades de enfoque en emociones. Combinar con dinámicas visuales y pausas activas.")

        elif juego == "Atención Turbo":
            if pred == "TDAH":
                recomendaciones.append("⚡ Atención inestable. Implementar rutinas visuales y ejercicios de enfoque progresivo.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("🧠 Atención general limitada. Sugerimos adaptar tareas con apoyos visuales.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("😔 La atención podría verse afectada por el estado emocional. Promover ambientes tranquilos.")
            elif pred == "TEA":
                recomendaciones.append("🔁 Atención selectiva observada. Usar señales claras y estructuración de instrucciones.")

        elif juego == "Mano Firme":
            if pred == "Discapacidad Intelectual":
                recomendaciones.append("🔧 Se sugiere reforzar motricidad fina. Usar actividades como recortes o modelado.")
            elif pred == "TDAH":
                recomendaciones.append("✋ Inestabilidad motora por impulsividad. Probar con trazados guiados y pausas.")
            elif pred == "TEA":
                recomendaciones.append("🖍️ Puede presentar rigidez en el trazo. Sugerimos usar herramientas sensoriales.")
            elif pred == "Ansiedad/Depresión":
                recomendaciones.append("📐 Motricidad afectada por estado anímico. Actividades suaves como pintar o plastilina.")

        elif juego == "Respira y Flota":
            if pred == "Ansiedad/Depresión":
                recomendaciones.append("🌬️ Señales de tensión emocional. Practicar respiración guiada y relajación diaria.")
            elif pred == "TEA":
                recomendaciones.append("🧘 Dificultades para seguir ritmo. Reforzar rutinas con apoyo visual y auditivo.")
            elif pred == "TDAH":
                recomendaciones.append("🌀 Respiración agitada. Usar juegos de control respiratorio con tiempo y metas.")
            elif pred == "Discapacidad Intelectual":
                recomendaciones.append("📉 Limitaciones en autorregulación. Incluir actividades de relajación con apoyo externo.")

    template = get_template('evaluaciones/pdf_perfil_nino.html')
    html_string = template.render({
        'nino': nino,
        'intentos': intentos_por_juego,
        'resultados_ia': resultados_ia,
        'medallas': medallas,
        'recomendaciones': recomendaciones,
        'fecha': date.today()
    })
    pdf = HTML(string=html_string, base_url=request.build_absolute_uri()).write_pdf()

    # Enviar correo
    try:
        subject = f"Informe de {nino.user.username} – NeuroKid"
        body = "Adjunto encontrará el informe actualizado del desarrollo en NeuroKid.\n\nSaludos."
        email = EmailMessage(subject, body, to=[nino.email])
        email.attach(f"{nino.user.username}_informe.pdf", pdf, "application/pdf")
        email.send()

        LogEnvioReporte.objects.create(
            especialista=especialista,
            nino=nino,
            metodo='email',
            exito=True,
            mensaje='Enviado correctamente.'
        )
        messages.success(request, f"Informe enviado a {nino.email} ✅")
    except Exception as e:
        LogEnvioReporte.objects.create(
            especialista=especialista,
            nino=nino,
            metodo='email',
            exito=False,
            mensaje=str(e)
        )
        messages.error(request, f"No se pudo enviar el informe: {e}")

    return redirect('perfil')
