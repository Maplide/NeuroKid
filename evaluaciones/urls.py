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
    
    path('completar/nino/', views.completar_datos_nino, name='completar_nino'),
    path('completar/especialista/', views.completar_datos_especialista, name='completar_especialista'),

    path('comenzar/',              views.comenzar,               name='comenzar'),
    path('nosotros/',              views.nosotros,               name='nosotros'),
    path('servicios/',             views.servicios,              name='servicios'),
    path('contacto/',              views.contacto,               name='contacto'),
    
    path('games/emo_match/',       views.juego_emo_match,        name='juego_emo_match'),
    path('games/turbo/',           views.juego_turbo,            name='juego_turbo'),
    path('games/mano_firme/',      views.juego_mano_firme,       name='juego_mano_firme'),
    path('games/respira_flota/',   views.juego_respira_flota,    name='juego_respira_flota'),
    
    path('api/registro_intento/',  views.api_registrar_intento,  name='api_registro_intento'),

    path('dashboard/', views.dashboard_especialista, name='dashboard_especialista'),

    path('perfil/pdf/', views.perfil_nino_pdf, name='perfil_nino_pdf'),
    path('perfil/pdf/<int:nino_id>/', views.perfil_nino_pdf_admin, name='perfil_nino_pdf_admin'),
    path('dashboard/pdf_global/', views.reporte_global_pdf, name='reporte_global_pdf'),

    path('enviar-reporte/<int:nino_id>/', views.enviar_reporte_por_email, name='enviar_reporte_email'),
]
