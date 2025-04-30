from django.core.management.base import BaseCommand
from evaluaciones.models import Nino, Juego, ResultadoIA, User
from evaluaciones.utils.ia import predecir_diagnostico
import numpy as np
import random
from django.utils.crypto import get_random_string
from datetime import date

class Command(BaseCommand):
    help = 'Crea 100 niños y simula 1 resultado por juego para cada uno'

    def handle(self, *args, **kwargs):
        juegos = Juego.objects.all()
        if not juegos.exists():
            self.stdout.write(self.style.ERROR("No hay juegos registrados."))
            return

        for i in range(100):
            username = f"nino_simulado_{i+1}"
            email = f"{username}@neurokid.pe"

            user = User.objects.create(username=username)
            nino = Nino.objects.create(
                user=user,
                fecha_nacimiento=date(2016, 1, 1),
                genero=random.choice(['M', 'F']),
                email=email
            )

            for juego in juegos:
                vector = generar_vector_simulado(juego.nombre)
                prediccion, prob = predecir_diagnostico(vector)

                ResultadoIA.objects.create(
                    nino=nino,
                    juego=juego,
                    prediccion=prediccion,
                    probabilidad=prob
                )

            self.stdout.write(self.style.SUCCESS(f"✓ Simulaciones creadas para {username}"))

def generar_vector_simulado(nombre_juego):
    vector = [0] * 10

    if nombre_juego == "EmoMatch":
        vector[0] = random.randint(1, 10)
        vector[1] = round(random.uniform(1.0, 5.0), 2)
        vector[2] = 1

    elif nombre_juego == "Atención Turbo":
        vector[3] = random.randint(5, 20)
        vector[4] = random.randint(0, 5)
        vector[5] = round(random.uniform(0.5, 2.0), 2)

    elif nombre_juego == "Mano Firme":
        vector[6] = random.randint(3, 15)
        vector[7] = random.randint(0, 3)
        vector[8] = round(random.uniform(5.0, 20.0), 2)

    elif nombre_juego == "Respira y Flota":
        vector[9] = round(random.uniform(10.0, 60.0), 2)

    return np.array(vector)
