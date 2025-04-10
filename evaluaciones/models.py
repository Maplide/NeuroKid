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
    fecha_nacimiento = models.DateField(null=True, blank=True)  # Niños
    especialidad = models.CharField(max_length=100, null=True, blank=True)  # Especialistas

    def __str__(self):
        return f"{self.user.username} - {self.rol}"

# ---------------------------
# NIÑO
# ---------------------------
class Nino(models.Model):
    nombre = models.CharField(max_length=100)
    fecha_nacimiento = models.DateField()
    genero = models.CharField(max_length=10, choices=[('M', 'Masculino'), ('F', 'Femenino')])
    email = models.EmailField(unique=True, null=True, blank=True)

    def __str__(self):
        return self.nombre

# ---------------------------
# ESPECIALISTA
# ---------------------------
class Especialista(models.Model):
    perfil = models.OneToOneField(Perfil, on_delete=models.CASCADE)
    dni = models.CharField(max_length=15)
    rne = models.CharField(max_length=30)  # Registro Nacional de Especialistas
    telefono = models.CharField(max_length=20)
    institucion = models.CharField(max_length=100)

    def __str__(self):
        return f'{self.perfil.user.get_full_name()}'

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
        return f"{self.nombre} ({self.tipo})"

# ---------------------------
# INTENTOS DE JUEGO
# ---------------------------
class IntentoJuego(models.Model):
    juego = models.ForeignKey(Juego, on_delete=models.CASCADE)
    nino = models.ForeignKey(Nino, on_delete=models.CASCADE)
    resultado = models.IntegerField()
    fecha = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nino.nombre} - {self.juego.nombre} - {self.resultado}"

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
        return f"Resultado de {self.nino.nombre} en {self.juego.nombre}"

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
        return f'Evaluación de {self.nino.nombre} en {self.fecha}'
