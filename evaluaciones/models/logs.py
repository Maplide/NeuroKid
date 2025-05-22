from django.db import models
from .usuarios import Nino, Especialista

class LogEnvioReporte(models.Model):
    especialista = models.ForeignKey(Especialista, on_delete=models.CASCADE)
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    fecha_envio = models.DateTimeField(auto_now_add=True)
    metodo = models.CharField(max_length=20, choices=[
        ('email', 'Email'),
        ('descarga', 'Descarga directa')
    ])
    exito = models.BooleanField(default=False)
    mensaje = models.TextField(blank=True)

    def __str__(self):
        estado = "✅" if self.exito else "❌"
        return f"{estado} Envío a {self.nino.user.username} ({self.metodo}) – {self.fecha_envio:%Y-%m-%d %H:%M}"
