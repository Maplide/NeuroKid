# evaluaciones/admin.py

from django.contrib import admin
from .models import Nino, Evaluacion

admin.site.register(Nino)
admin.site.register(Evaluacion)