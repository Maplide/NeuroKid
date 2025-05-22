from django.db import models
from django.contrib.auth.models import User

class Perfil(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    rol = models.CharField(max_length=20, choices=[
        ('nino', 'Niño'),
        ('especialista', 'Especialista'),
        ('invitado', 'Invitado'),
    ])
    fecha_nacimiento = models.DateField(null=True, blank=True)
    especialidad = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return f"{self.user.username} ({self.get_rol_display()})"

class Nino(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    fecha_nacimiento = models.DateField()
    genero = models.CharField(max_length=10, choices=[('M', 'Masculino'), ('F', 'Femenino')])
    email = models.EmailField(unique=True, null=True, blank=True)

    def __str__(self):
        return self.user.get_full_name() or self.user.username

class Especialista(models.Model):
    perfil = models.OneToOneField(Perfil, on_delete=models.CASCADE)
    dni = models.CharField(max_length=15)
    rne = models.CharField(max_length=30)
    telefono = models.CharField(max_length=20)
    institucion = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.perfil.user.get_full_name()} – {self.perfil.especialidad}"