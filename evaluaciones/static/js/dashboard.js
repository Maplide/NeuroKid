document.addEventListener("DOMContentLoaded", function () {
  const partidas = JSON.parse(document.getElementById('jsonPartidas').textContent);
  const edades = JSON.parse(document.getElementById('jsonEdades').textContent);

  // Gráfico: Juegos más jugados
  const juegosLabels = partidas.map(p => p.juego);
  const juegosData = partidas.map(p => p.total);

  const ctxJuegos = document.getElementById('juegosChart').getContext('2d');
  new Chart(ctxJuegos, {
    type: 'bar',
    data: {
      labels: juegosLabels,
      datasets: [{
        label: 'Partidas Jugadas',
        data: juegosData,
        backgroundColor: 'rgba(54, 162, 235, 0.7)'
      }]
    }
  });

  // Gráfico: Distribución por edad
  const edadChartLabels = Object.keys(edades);
  const edadChartData = Object.values(edades);

  const ctxEdad = document.getElementById('edadChart').getContext('2d');
  new Chart(ctxEdad, {
    type: 'pie',
    data: {
      labels: edadChartLabels,
      datasets: [{
        label: 'Distribución por Edad',
        data: edadChartData,
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56']
      }]
    }
  });
});
