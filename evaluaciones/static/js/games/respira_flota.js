// js/games/respira_flota.js
document.addEventListener('DOMContentLoaded', () => {
    const bubble = document.getElementById('bubble');
    const cyclesSpan = document.getElementById('cycles');
    const avgHoldSpan = document.getElementById('avgHold');
    const finalCycles = document.getElementById('finalCycles');
    const finalAvgHold = document.getElementById('finalAvgHold');
    const endModal = new bootstrap.Modal(document.getElementById('endModal'));
    const retryBtn = document.getElementById('retryBtn');
  
    let holdStart = 0;
    const holdTimes = [];
    let cycles = 0;
    const maxCycles = 3;
  
    // Inicia inhalación
    bubble.addEventListener('mousedown', () => {
      holdStart = Date.now();
      bubble.classList.add('inhale');
    });
  
    // Termina inhalación (exhalar)
    bubble.addEventListener('mouseup', () => {
      const hold = (Date.now() - holdStart) / 1000;
      bubble.classList.remove('inhale');
  
      holdTimes.push(hold);
      cycles++;
      cyclesSpan.textContent = cycles;
      const avg = holdTimes.reduce((a, b) => a + b, 0) / holdTimes.length;
      avgHoldSpan.textContent = avg.toFixed(2);
  
      if (cycles >= maxCycles) {
        // Mostrar modal con resultados
        finalCycles.textContent = cycles;
        finalAvgHold.textContent = avg.toFixed(2);
        endModal.show();
      }
    });
  
    // Botón repetir
    retryBtn.addEventListener('click', () => {
      endModal.hide();
      // Reiniciar estado
      holdTimes.length = 0;
      cycles = 0;
      cyclesSpan.textContent = '0';
      avgHoldSpan.textContent = '0.00';
    });
  });
  