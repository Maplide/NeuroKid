from django.db import models
from .usuarios import Nino

class Juego(models.Model):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()
    tipo = models.CharField(max_length=50, choices=[
        ('tea', 'TEA'),
        ('tdha', 'TDHA'),
        ('discapacidad', 'Discapacidad'),
        ('estres', 'Estrés'),
    ])
    activo = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.nombre} ({self.get_tipo_display()})"

class IntentoJuego(models.Model):
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    resultado = models.IntegerField()
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nino.user.username} – {self.juego.nombre} – {self.resultado}"

class IntentoJuegoInvitado(models.Model):
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    invitado_id = models.CharField(max_length=100)
    resultado = models.IntegerField()
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.invitado_id} – {self.juego.nombre} – {self.resultado}"
