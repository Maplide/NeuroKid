# evaluaciones/admin.py

from django.contrib import admin
from .models import (
    Perfil,
    Nino,
    Especialista,
    Juego,
    IntentoJuego,
    Resultado,
    Evaluacion,
)

@admin.register(Perfil)
class PerfilAdmin(admin.ModelAdmin):
    list_display = ('user', 'rol', 'fecha_nacimiento', 'especialidad')
    list_filter = ('rol',)

@admin.register(Nino)
class NinoAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'fecha_nacimiento', 'genero', 'email')
    search_fields = ('nombre', 'email')

@admin.register(Especialista)
class EspecialistaAdmin(admin.ModelAdmin):
    list_display = ('perfil', 'dni', 'rne', 'telefono', 'institucion')
    search_fields = ('perfil__user__username', 'dni')

@admin.register(Juego)
class JuegoAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'tipo', 'activo')
    list_filter = ('tipo', 'activo')
    search_fields = ('nombre',)

@admin.register(IntentoJuego)
class IntentoJuegoAdmin(admin.ModelAdmin):
    list_display = ('nino', 'juego', 'resultado', 'fecha')
    list_filter = ('juego',)
    date_hierarchy = 'fecha'

@admin.register(Resultado)
class ResultadoAdmin(admin.ModelAdmin):
    list_display = ('nino', 'juego', 'puntuacion', 'fecha')
    list_filter = ('juego',)
    date_hierarchy = 'fecha'

@admin.register(Evaluacion)
class EvaluacionAdmin(admin.ModelAdmin):
    list_display = ('nino', 'especialista', 'fecha')
    list_filter = ('especialista',)
    date_hierarchy = 'fecha'
