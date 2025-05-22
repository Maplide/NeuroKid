from django.shortcuts import render

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