document.addEventListener('DOMContentLoaded', () => {
  const bubble = document.getElementById('bubble');
  const cyclesSpan = document.getElementById('cycles');
  const avgHoldSpan = document.getElementById('avgHold');
  const finalCycles = document.getElementById('finalCycles');
  const finalAvgHold = document.getElementById('finalAvgHold');
  const endModal = new bootstrap.Modal(document.getElementById('endModal'));
  const retryBtn = document.getElementById('retryBtn');
  const pauseBtn = document.getElementById('pauseBtn');
  const resetBtn = document.getElementById('resetBtn');

  let holdStart = 0;
  const holdTimes = [];
  let cycles = 0;
  const maxCycles = 3;
  let isPaused = false;

  bubble.addEventListener('mousedown', () => {
    if (isPaused || cycles >= maxCycles) return;
    holdStart = Date.now();
    bubble.classList.add('inhale');
  });

  bubble.addEventListener('mouseup', () => {
    if (isPaused || cycles >= maxCycles) return;

    const hold = (Date.now() - holdStart) / 1000;
    bubble.classList.remove('inhale');

    holdTimes.push(hold);
    cycles++;
    cyclesSpan.textContent = cycles;

    const avg = holdTimes.reduce((a, b) => a + b, 0) / holdTimes.length;
    avgHoldSpan.textContent = avg.toFixed(2);

    if (cycles >= maxCycles) {
      finalCycles.textContent = cycles;
      finalAvgHold.textContent = avg.toFixed(2);
      registrarResultadoIA(avg);
      endModal.show();
    }
  });

  retryBtn.addEventListener('click', () => {
    endModal.hide();
    reiniciarJuego();
  });

  pauseBtn.addEventListener('click', () => {
    isPaused = !isPaused;
    pauseBtn.textContent = isPaused ? "▶️ Reanudar" : "⏸️ Pausar";
  });

  resetBtn.addEventListener('click', () => {
    if (confirm("¿Reiniciar el juego desde cero?")) {
      location.reload();
    }
  });

  function reiniciarJuego() {
    holdTimes.length = 0;
    cycles = 0;
    isPaused = false;
    cyclesSpan.textContent = '0';
    avgHoldSpan.textContent = '0.00';
    pauseBtn.textContent = "⏸️ Pausar";
  }

  async function registrarResultadoIA(promedio) {
    try {
      const response = await fetch("/evaluaciones/api/registro_intento/", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          juego: "Respira y Flota",
          resultado: promedio,
          duracion_total: promedio
        })
      });

      const data = await response.json();
      if (data.status === "ok") {
        console.log("✅ Resultado enviado:", data.prediccion, data.probabilidad);
      } else {
        console.warn("⚠️ Respuesta inesperada:", data);
      }
    } catch (error) {
      console.error("❌ Error al enviar resultado:", error);
    }
  }
});
