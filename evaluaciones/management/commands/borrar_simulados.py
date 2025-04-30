from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from evaluaciones.models import Nino, ResultadoIA, IntentoJuego, Resultado

class Command(BaseCommand):
    help = "Elimina los datos de niños simulados junto con sus resultados."

    def handle(self, *args, **kwargs):
        usuarios_simulados = User.objects.filter(username__startswith="nino_simulado_")
        total = usuarios_simulados.count()

        if total == 0:
            self.stdout.write(self.style.WARNING("No se encontraron niños simulados."))
            return

        for usuario in usuarios_simulados:
            try:
                nino = Nino.objects.get(user=usuario)
                ResultadoIA.objects.filter(nino=nino).delete()
                IntentoJuego.objects.filter(nino=nino).delete()
                Resultado.objects.filter(nino=nino).delete()
                nino.delete()
                usuario.delete()
                self.stdout.write(self.style.SUCCESS(f"🗑️ Niño simulado eliminado: {usuario.username}"))
            except Nino.DoesNotExist:
                usuario.delete()
                self.stdout.write(self.style.WARNING(f"⚠️ Usuario sin modelo Nino: {usuario.username}"))

        self.stdout.write(self.style.SUCCESS(f"✅ Eliminación finalizada. Total eliminados: {total}"))
