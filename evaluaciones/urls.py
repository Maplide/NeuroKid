# evaluaciones/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('',                       views.index,                  name='index'),
    path('registro/',              views.registro,               name='registro'),
    path('login/',                 views.login_view,             name='login'),
    path('logout/',                views.logout_view,            name='logout'),
    
    # Invitado
    path('perfil/libre/',          views.perfil_libre,       name='perfil_libre'),
    # Autenticados
    path('perfil/',                views.perfil,             name='perfil'),
    path('perfil/<int:nino_id>/',  views.perfil,             name='perfil'),
    
    path('comenzar/',              views.comenzar,               name='comenzar'),
    path('nosotros/',              views.nosotros,               name='nosotros'),
    path('servicios/',             views.servicios,              name='servicios'),
    path('contacto/',              views.contacto,               name='contacto'),
    
    path('games/emo_match/',       views.juego_emo_match,        name='juego_emo_match'),
    path('games/turbo/',           views.juego_turbo,            name='juego_turbo'),
    path('games/mano_firme/',      views.juego_mano_firme,       name='juego_mano_firme'),
    path('games/respira_flota/',   views.juego_respira_flota,    name='juego_respira_flota'),
    
    path('api/registro_intento/',  views.api_registrar_intento,  name='api_registro_intento'),
]
