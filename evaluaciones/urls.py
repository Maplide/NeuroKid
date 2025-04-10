from django.urls import path
from . import views  # Importa todas las vistas del archivo views.py

urlpatterns = [
    path('', views.index, name='index'),
    path('registro/', views.registro, name='registro'),
    path('perfil/<int:nino_id>/', views.perfil, name='perfil'),
    path('comenzar/', views.comenzar, name='comenzar'),
    path('nosotros/', views.nosotros, name='nosotros'),  # Ruta para Nosotros
    path('servicios/', views.servicios, name='servicios'),  # Ruta para Servicios
    path('contacto/', views.contacto, name='contacto'),  # Ruta para Contacto
    path('juego_reconocimiento_emocional/', views.juego_reconocimiento_emocional, name='juego_reconocimiento_emocional'),
    path('juego_memoria/', views.juego_memoria, name='juego_memoria'),
    path('login/', views.login_view, name='login'),
]