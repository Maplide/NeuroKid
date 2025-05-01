document.addEventListener('DOMContentLoaded', () => {
  const startBtn    = document.getElementById('startBtn');
  const gameArea    = document.getElementById('gameArea');
  const stats       = document.getElementById('stats');
  const hitsEl      = document.getElementById('hits');
  const missesEl    = document.getElementById('misses');
  const avgEl       = document.getElementById('avgTime');
  const endModal    = new bootstrap.Modal(document.getElementById('endModalFirme'));
  const finalHits   = document.getElementById('finalHitsFirme');
  const finalMisses = document.getElementById('finalMissesFirme');
  const retryBtn    = document.getElementById('retryFirme');
  const pauseBtn    = document.getElementById('pauseBtn');
  const resetBtn    = document.getElementById('resetBtn');

  let hits=0, misses=0, times=[], round=0, maxRounds=10;
  let circle, timerId, appearTime;
  let enRonda = false;
  let isPaused = false;

  function spawnCircle() {
    if (isPaused) return; // 🔒 si está en pausa, no lanza
    if (!circle) {
      circle = document.createElement('div');
      circle.className = 'circle';
      gameArea.appendChild(circle);
      circle.addEventListener('mouseover', onHit);
    }
    const { width, height } = gameArea.getBoundingClientRect();
    const x = Math.random() * (width - 50), y = Math.random() * (height - 50);
    circle.style.left = `${x}px`;
    circle.style.top  = `${y}px`;
    circle.style.display = 'block';
    appearTime = performance.now();

    enRonda = true;
    timerId = setTimeout(onMiss, 1500);
  }

  function onHit() {
    if (!enRonda || isPaused) return;
    enRonda = false;

    clearTimeout(timerId);
    const delta = (performance.now() - appearTime) / 1000;
    hits++; times.push(delta);
    updateStats();
    circle.style.display = 'none';
    nextRound();
  }

  function onMiss() {
    if (!enRonda || isPaused) return;
    enRonda = false;

    misses++;
    updateStats();
    circle.style.display = 'none';
    nextRound();
  }

  function updateStats() {
    hitsEl.textContent   = hits;
    missesEl.textContent = misses;
    const avg = times.length
              ? (times.reduce((a, b) => a + b, 0) / times.length).toFixed(2)
              : '0.00';
    avgEl.textContent = avg;
  }

  function nextRound() {
    if (round >= maxRounds) return endGame();
    round++;
    setTimeout(spawnCircle, 500);
  }

  function startGame() {
    hits = 0; misses = 0; times = []; round = 0;
    hitsEl.textContent = missesEl.textContent = '0';
    avgEl.textContent = '0.00';
    document.getElementById('controls').style.display = 'none';
    gameArea.style.display = 'block';
    stats.style.display = 'block';
    isPaused = false;
    pauseBtn.textContent = "⏸️ Pausar";
    nextRound();
  }

  function endGame() {
    finalHits.textContent   = hits;
    finalMisses.textContent = misses;
    endModal.show();

    registrarResultadoIA(hits, misses, calcularPromedio());
  }

  function calcularPromedio() {
    return times.length ? (times.reduce((a, b) => a + b, 0) / times.length).toFixed(2) : 0;
  }

  async function registrarResultadoIA(aciertos, fallos, tiempo) {
    try {
      const response = await fetch("/evaluaciones/api/registro_intento/", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          juego: "Mano Firme",
          resultado: aciertos,
          aciertos: aciertos,
          errores: fallos,
          tiempo: tiempo
        })
      });

      const data = await response.json();
      if (data.status === "ok") {
        console.log("✅ Resultado IA:", data.prediccion, data.probabilidad);
      } else {
        console.warn("⚠️ Error al registrar:", data);
      }
    } catch (error) {
      console.error("❌ Error de red al registrar resultado IA:", error);
    }
  }

  startBtn.addEventListener('click', startGame);
  retryBtn.addEventListener('click', () => {
    endModal.hide();
    startGame();
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
});
