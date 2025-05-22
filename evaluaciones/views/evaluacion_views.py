from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.template.loader import get_template
from django.http import HttpResponse
from django.core.mail import EmailMessage
from django.contrib import messages
from django.core.paginator import Paginator
from django.db.models import Count, Avg
from weasyprint import HTML
from datetime import date

from evaluaciones.models import (
    Perfil, Nino, Especialista, Juego, IntentoJuego, IntentoJuegoInvitado,
    ResultadoIA, LogEnvioReporte
)

def todas_las_medallas():
    return {
        "EmoMatch": ("🥇 Oro", 80),
        "Atención Turbo": ("🥈 Plata", 15),
        "Mano Firme": ("🥉 Bronce", 10),
        "Respira y Flota": ("🌟 Relax", 3),
    }

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
def perfil_nino_pdf(request):
    perfil = Perfil.objects.filter(user=request.user).first()
    if not perfil or perfil.rol != 'nino':
        return redirect('perfil')

    nino = Nino.objects.filter(user=request.user).first()
    return generar_pdf_nino(nino, request)

@login_required
def perfil_nino_pdf_admin(request, nino_id):
    perfil = Perfil.objects.filter(user=request.user).first()
    if not perfil or perfil.rol != 'especialista':
        return redirect('perfil')

    nino = get_object_or_404(Nino, id=nino_id)
    return generar_pdf_nino(nino, request)

def generar_pdf_nino(nino, request):
    intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego')
    resultados_ia = ResultadoIA.objects.filter(nino=nino).select_related('juego')

    intentos_por_juego = {}
    for intento in intentos:
        nombre = intento.juego.nombre
        intentos_por_juego.setdefault(nombre, []).append(intento)

    medallas = {}
    for juego, lista in intentos_por_juego.items():
        mejor = max(i.resultado for i in lista)
        medalla = obtener_medalla(juego, mejor)
        if medalla:
            medallas[juego] = medalla

    recomendaciones = generar_recomendaciones(resultados_ia)

    html_string = get_template('evaluaciones/pdf_perfil_nino.html').render({
        'nino': nino,
        'intentos': intentos_por_juego,
        'resultados_ia': resultados_ia,
        'medallas': medallas,
        'recomendaciones': recomendaciones,
        'fecha': date.today()
    })

    pdf = HTML(string=html_string, base_url=request.build_absolute_uri()).write_pdf()
    return HttpResponse(pdf, content_type='application/pdf')

@login_required
def enviar_reporte_por_email(request, nino_id):
    perfil = Perfil.objects.filter(user=request.user, rol='especialista').first()
    if not perfil:
        return HttpResponse("Acceso no autorizado", status=403)

    especialista = Especialista.objects.get(perfil=perfil)
    nino = get_object_or_404(Nino, id=nino_id)

    # Generar PDF
    intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego')
    resultados_ia = ResultadoIA.objects.filter(nino=nino).select_related('juego')

    intentos_por_juego = {}
    for intento in intentos:
        juego = intento.juego.nombre
        intentos_por_juego.setdefault(juego, []).append(intento)

    medallas = {}
    for juego, lista in intentos_por_juego.items():
        mejor = max(i.resultado for i in lista)
        medalla = obtener_medalla(juego, mejor)
        if medalla:
            medallas[juego] = medalla

    recomendaciones = generar_recomendaciones(resultados_ia)

    html_string = get_template('evaluaciones/pdf_perfil_nino.html').render({
        'nino': nino,
        'intentos': intentos_por_juego,
        'resultados_ia': resultados_ia,
        'medallas': medallas,
        'recomendaciones': recomendaciones,
        'fecha': date.today()
    })
    pdf = HTML(string=html_string, base_url=request.build_absolute_uri()).write_pdf()

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

def generar_recomendaciones(resultados_ia):
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

    return recomendaciones

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

    resultados = ResultadoIA.objects.select_related('nino', 'juego').order_by('nino__id', 'juego__id', '-fecha')

    ultimos = {}
    for r in resultados:
        key = (r.nino.id, r.juego.id)
        if key not in ultimos:
            ultimos[key] = r

    html_string = get_template('evaluaciones/pdf_reporte_global.html').render({
        'total_ninos': total_ninos,
        'total_invitados': total_invitados,
        'total_partidas': total_partidas,
        'resumen_juegos': resumen_juegos,
        'confianza_ia': confianza_dict,
        'resultados': ultimos.values(),
        'fecha': date.today()
    })

    pdf = HTML(string=html_string, base_url=request.build_absolute_uri()).write_pdf()
    return HttpResponse(pdf, content_type='application/pdf')

@login_required
def dashboard_especialista(request):
    perfil = Perfil.objects.filter(user=request.user).first()
    if not perfil or perfil.rol != 'especialista':
        return redirect('perfil')

    total_ninos = Nino.objects.count()
    total_invitados = IntentoJuegoInvitado.objects.values('invitado_id').distinct().count()
    total_partidas = IntentoJuego.objects.count() + IntentoJuegoInvitado.objects.count()

    juegos = Juego.objects.filter(activo=True)
    partidas_por_juego = []
    for juego in juegos:
        reg = IntentoJuego.objects.filter(juego=juego).count()
        libre = IntentoJuegoInvitado.objects.filter(juego=juego).count()
        partidas_por_juego.append({
            'juego': juego.nombre,
            'tipo': juego.get_tipo_display(),
            'total': reg + libre
        })
    partidas_por_juego.sort(key=lambda x: x['total'], reverse=True)

    confianza_ia = ResultadoIA.objects.values('juego__nombre').annotate(
        promedio=Avg('probabilidad')
    )
    confianza_dict = {i['juego__nombre']: round(i['promedio'], 2) for i in confianza_ia}

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
    paginator = Paginator(resultados_query, 20)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

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
        'resultados': page_obj,
        'filtro_nombre': filtro_nombre,
        'filtro_juego': filtro_juego,
        'filtro_fecha': filtro_fecha
    })
