from django.db import models
from django.contrib.auth.models import User

# ---------------------------
# PERFIL PERSONALIZADO
# ---------------------------
class Perfil(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    rol = models.CharField(max_length=20, choices=[
        ('nino', 'Niño'),
        ('especialista', 'Especialista'),
        ('invitado', 'Invitado'),
    ])
    fecha_nacimiento = models.DateField(null=True, blank=True)      # Para niños
    especialidad = models.CharField(max_length=100, null=True, blank=True)  # Para especialistas

    def __str__(self):
        return f"{self.user.username} ({self.get_rol_display()})"

# ---------------------------
# NIÑO (vinculado a User)
# ---------------------------
class Nino(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    fecha_nacimiento = models.DateField()
    genero = models.CharField(max_length=10, choices=[('M', 'Masculino'), ('F', 'Femenino')])
    email = models.EmailField(unique=True, null=True, blank=True)

    def __str__(self):
        return self.user.get_full_name() or self.user.username

# ---------------------------
# ESPECIALISTA (vinculado a Perfil)
# ---------------------------
class Especialista(models.Model):
    perfil = models.OneToOneField(Perfil, on_delete=models.CASCADE)
    dni = models.CharField(max_length=15)
    rne = models.CharField(max_length=30)      # Registro Nacional de Especialistas
    telefono = models.CharField(max_length=20)
    institucion = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.perfil.user.get_full_name()} – {self.perfil.especialidad}"

# ---------------------------
# JUEGOS
# ---------------------------
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

# ---------------------------
# INTENTOS DE JUEGO
# ---------------------------
class IntentoJuego(models.Model):
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    resultado = models.IntegerField()
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nino.user.username} – {self.juego.nombre} – {self.resultado}"

# ---------------------------
# RESULTADOS
# ---------------------------
class Resultado(models.Model):
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    puntuacion = models.IntegerField()
    interpretacion = models.TextField()
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Resultado {self.nino.user.username} en {self.juego.nombre}"

# ---------------------------
# EVALUACIÓN
# ---------------------------
class Evaluacion(models.Model):
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE, related_name='evaluaciones')
    fecha = models.DateTimeField(auto_now_add=True)
    resultado = models.TextField()
    especialista = models.ForeignKey(Especialista, null=True, blank=True, on_delete=models.SET_NULL)
    observaciones = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"Evaluación de {self.nino.user.username} – {self.fecha:%Y-%m-%d %H:%M}"

# ---------------------------
# RESULTADOS DE PREDICCIÓN IA
# ---------------------------
class ResultadoIA(models.Model):
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    prediccion = models.CharField(max_length=100)
    probabilidad = models.FloatField()  # Para guardar qué tan seguro estuvo el modelo
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nino.user.username} – {self.juego.nombre}: {self.prediccion} ({self.probabilidad:.2f})"
    
# ---------------------------
# INTENTOS DE USUARIOS INVITADOS
# ---------------------------
class IntentoJuegoInvitado(models.Model):
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    invitado_id = models.CharField(max_length=100)  # ID guardado en sesión
    resultado = models.IntegerField()
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.invitado_id} – {self.juego.nombre} – {self.resultado}"
    
# ---------------------------
# LOGS DE ENVÍO DE REPORTES
# ---------------------------
class LogEnvioReporte(models.Model):
    especialista = models.ForeignKey(Especialista, on_delete=models.CASCADE)
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    fecha_envio = models.DateTimeField(auto_now_add=True)
    metodo = models.CharField(max_length=20, choices=[('email', 'Email'), ('descarga', 'Descarga directa')])
    exito = models.BooleanField(default=False)
    mensaje = models.TextField(blank=True)

    def __str__(self):
        estado = "✅" if self.exito else "❌"
        return f"{estado} Envío a {self.nino.user.username} ({self.metodo}) – {self.fecha_envio:%Y-%m-%d %H:%M}"