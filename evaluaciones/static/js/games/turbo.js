document.addEventListener('DOMContentLoaded', () => {
  const startBtn    = document.getElementById('startBtn');
  const gameArea    = document.getElementById('gameArea');
  const stats       = document.getElementById('stats');
  const hitsEl      = document.getElementById('hits');
  const missesEl    = document.getElementById('misses');
  const avgEl       = document.getElementById('avgTime');
  const endModal    = new bootstrap.Modal(document.getElementById('turboEndModal'));
  const finalHits   = document.getElementById('finalHits');
  const finalMisses = document.getElementById('finalMisses');
  const retryBtn    = document.getElementById('turboRetry');
  const pauseBtn    = document.getElementById('pauseBtn');
  const resetBtn    = document.getElementById('resetBtn');

  let hits = 0, misses = 0, times = [], round = 0;
  const maxRounds = 10;
  let circle, timerId, startTime;
  let isPaused = false;

  function placeCircle() {
    if (isPaused) return;

    if (!circle) {
      circle = document.createElement('div');
      circle.className = 'circle';
      gameArea.appendChild(circle);
      circle.addEventListener('click', onHit);
    }

    const rect = gameArea.getBoundingClientRect();
    const x = Math.random() * (rect.width - 50);
    const y = Math.random() * (rect.height - 50);
    circle.style.left = `${x}px`;
    circle.style.top = `${y}px`;
    circle.style.display = 'block';
    startTime = performance.now();

    timerId = setTimeout(onMiss, 1200);
  }

  function nextRound() {
    if (isPaused) return;
    round++;
    if (round > maxRounds) return endGame();
    placeCircle();
  }

  function onHit() {
    if (isPaused) return;
    clearTimeout(timerId);
    const delta = (performance.now() - startTime) / 1000;
    hits++;
    times.push(delta);
    updateStats();
    circle.style.display = 'none';
    setTimeout(nextRound, 500);
  }

  function onMiss() {
    if (isPaused) return;
    misses++;
    updateStats();
    circle.style.display = 'none';
    setTimeout(nextRound, 500);
  }

  function updateStats() {
    hitsEl.textContent = hits;
    missesEl.textContent = misses;
    const avg = times.length
      ? (times.reduce((a, b) => a + b, 0) / times.length).toFixed(2)
      : '0.00';
    avgEl.textContent = avg;
  }

  function startGame() {
    hits = 0; misses = 0; times = []; round = 0; isPaused = false;
    hitsEl.textContent = missesEl.textContent = '0';
    avgEl.textContent = '0.00';
    document.getElementById('controls').style.display = 'none';
    gameArea.style.display = 'block';
    stats.style.display = 'block';
    pauseBtn.textContent = "⏸️ Pausar";
    nextRound();
  }

  function endGame() {
    finalHits.textContent = hits;
    finalMisses.textContent = misses;
    registrarResultadoIA();
    endModal.show();
  }

  function registrarResultadoIA() {
    const avg = times.length ? (times.reduce((a, b) => a + b, 0) / times.length) : 0;
    fetch("/evaluaciones/api/registro_intento/", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        juego: "Atención Turbo",
        resultado: hits,
        aciertos: hits,
        fallos: misses,
        tiempo_promedio: avg
      })
    })
    .then(res => res.json())
    .then(data => {
      if (data.status === "ok") {
        console.log("✅ Resultado IA:", data.prediccion, data.probabilidad);
      } else {
        console.warn("⚠️ Error:", data);
      }
    })
    .catch(err => console.error("❌ Error al registrar intento:", err));
  }

  pauseBtn.addEventListener('click', () => {
    isPaused = !isPaused;
    pauseBtn.textContent = isPaused ? "▶️ Reanudar" : "⏸️ Pausar";
  });

  resetBtn.addEventListener('click', () => {
    if (confirm("¿Reiniciar el juego desde cero?")) {
      location.reload();
    }
  });

  startBtn.addEventListener('click', startGame);
  retryBtn.addEventListener('click', () => {
    endModal.hide();
    startGame();
  });
});
