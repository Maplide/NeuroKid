from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from datetime import date
import uuid

from evaluaciones.models import (
    Perfil, Nino, Especialista, IntentoJuego, IntentoJuegoInvitado, ResultadoIA
)
from .evaluacion_views import obtener_medalla, todas_las_medallas

@login_required
def perfil(request, nino_id=None):
    perfil = Perfil.objects.filter(user=request.user).first()

    # ------------------------------
    # PERFIL DEL NIÑO
    # ------------------------------
    if perfil and perfil.rol == 'nino':
        nino = Nino.objects.filter(user=request.user).first()
        intentos_por_juego = {}
        resultados_ia = {}
        medallas = {}
        recomendaciones = []

        if nino:
            intentos = IntentoJuego.objects.filter(nino=nino).select_related('juego').order_by('-fecha')
            for intento in intentos:
                juego = intento.juego.nombre
                intentos_por_juego.setdefault(juego, []).append(intento)

            for r in ResultadoIA.objects.filter(nino=nino).select_related('juego').order_by('juego', '-fecha'):
                resultados_ia[r.juego.nombre] = r

            for juego, lista in intentos_por_juego.items():
                mejor = max(i.resultado for i in lista)
                medalla = obtener_medalla(juego, mejor)
                if medalla:
                    medallas[juego] = medalla

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

    # ------------------------------
    # PERFIL DEL ESPECIALISTA
    # ------------------------------
    elif perfil and perfil.rol == 'especialista':
        especialista = Especialista.objects.get(perfil=perfil)

        filtro_nombre = request.GET.get('nombre', '')
        filtro_juego = request.GET.get('juego', '')
        filtro_fecha = request.GET.get('fecha', '')

        resultados = ResultadoIA.objects.select_related('nino', 'juego')

        if filtro_nombre:
            resultados = resultados.filter(nino__user__username__icontains=filtro_nombre)
        if filtro_juego:
            resultados = resultados.filter(juego__nombre__icontains=filtro_juego)
        if filtro_fecha:
            resultados = resultados.filter(fecha__date=filtro_fecha)

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


# ------------------------------
# PERFIL INVITADO / MODO LIBRE
# ------------------------------
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
        intentos_por_juego.setdefault(juego, []).append(intento)

    for juego, lista in intentos_por_juego.items():
        mejor_puntaje = max(i.resultado for i in lista)
        medalla = obtener_medalla(juego, mejor_puntaje)
        if medalla:
            medallas[juego] = medalla

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
        'recomendaciones': recomendaciones
    })
