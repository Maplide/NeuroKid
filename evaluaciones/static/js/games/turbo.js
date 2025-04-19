document.addEventListener('DOMContentLoaded', () => {
    const startBtn = document.getElementById('startBtn');
    const gameArea = document.getElementById('gameArea');
    const stats    = document.getElementById('stats');
    const hitsEl   = document.getElementById('hits');
    const missesEl = document.getElementById('misses');
    const avgEl    = document.getElementById('avgTime');
    const endModal = new bootstrap.Modal(document.getElementById('turboEndModal'));
    const finalHits   = document.getElementById('finalHits');
    const finalMisses = document.getElementById('finalMisses');
    const retryBtn    = document.getElementById('turboRetry');
  
    let hits=0, misses=0, times=[], round=0;
    const maxRounds = 10;
    let circle, timerId, startTime;
  
    function placeCircle() {
      // crea o reutiliza
      if (!circle) {
        circle = document.createElement('div');
        circle.className = 'circle';
        gameArea.appendChild(circle);
        circle.addEventListener('click', onHit);
      }
      // posición aleatoria dentro de gameArea
      const rect = gameArea.getBoundingClientRect();
      const x = Math.random()*(rect.width-50);
      const y = Math.random()*(rect.height-50);
      circle.style.left = x+'px';
      circle.style.top  = y+'px';
      circle.style.display = 'block';
      startTime = performance.now();
  
      // si no haces clic en 1.2 seg → fallo
      timerId = setTimeout(onMiss, 1200);
    }
  
    function nextRound() {
      round++;
      if (round > maxRounds) return endGame();
      placeCircle();
    }
  
    function onHit(e) {
      clearTimeout(timerId);
      const delta = (performance.now() - startTime)/1000;
      hits++;
      times.push(delta);
      updateStats();
      circle.style.display = 'none';
      // breve pausa antes de siguiente
      setTimeout(nextRound, 500);
    }
  
    function onMiss() {
      misses++;
      updateStats();
      circle.style.display = 'none';
      setTimeout(nextRound, 500);
    }
  
    function updateStats() {
      hitsEl.textContent   = hits;
      missesEl.textContent = misses;
      const avg = times.length
                ? (times.reduce((a,b)=>a+b,0)/times.length).toFixed(2)
                : '0.00';
      avgEl.textContent = avg;
    }
  
    function startGame() {
      // reset
      hits=0; misses=0; times=[]; round=0;
      hitsEl.textContent = missesEl.textContent = '0';
      avgEl.textContent = '0.00';
      document.getElementById('controls').style.display = 'none';
      gameArea.style.display = 'block';
      stats.style.display    = 'block';
      nextRound();
    }
  
    function endGame() {
      // muestra modal
      finalHits.textContent   = hits;
      finalMisses.textContent = misses;
      endModal.show();
    }
  
    startBtn.addEventListener('click', startGame);
    retryBtn.addEventListener('click', () => {
      endModal.hide();
      startGame();
    });
  });
  