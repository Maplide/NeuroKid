from django.db import models
from .usuarios import Nino, Especialista
from .juegos import Juego

class Resultado(models.Model):
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    puntuacion = models.IntegerField()
    interpretacion = models.TextField()
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Resultado {self.nino.user.username} en {self.juego.nombre}"

class Evaluacion(models.Model):
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE, related_name='evaluaciones')
    fecha = models.DateTimeField(auto_now_add=True)
    resultado = models.TextField()
    especialista = models.ForeignKey(Especialista, null=True, blank=True, on_delete=models.SET_NULL)
    observaciones = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"Evaluación de {self.nino.user.username} – {self.fecha:%Y-%m-%d %H:%M}"

class ResultadoIA(models.Model):
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    prediccion = models.CharField(max_length=100)
    probabilidad = models.FloatField()
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nino.user.username} – {self.juego.nombre}: {self.prediccion} ({self.probabilidad:.2f})"
