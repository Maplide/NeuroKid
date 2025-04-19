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
  
  let hits=0, misses=0, times=[], round=0, maxRounds=10;
  let circle, timerId, appearTime;
  
  function spawnCircle() {
    if (!circle) {
      circle = document.createElement('div');
      circle.className = 'circle';
      gameArea.appendChild(circle);
      circle.addEventListener('mouseover', onHit);
    }
    const { width, height } = gameArea.getBoundingClientRect();
    const x = Math.random()*(width-50), y = Math.random()*(height-50);
    circle.style.left = `${x}px`;
    circle.style.top  = `${y}px`;
    circle.style.display = 'block';
    appearTime = performance.now();
  
    // si no entra el cursor en 1.5s → miss
    timerId = setTimeout(onMiss, 1500);
  }
  
  function onHit() {
    clearTimeout(timerId);
    const delta = (performance.now() - appearTime)/1000;
    hits++; times.push(delta);
    updateStats();
    circle.style.display = 'none';
    nextRound();
  }
  
  function onMiss() {
    misses++;
    updateStats();
    circle.style.display = 'none';
    nextRound();
  }
  
  function updateStats() {
    hitsEl.textContent   = hits;
    missesEl.textContent = misses;
    const avg = times.length
              ? (times.reduce((a,b)=>a+b,0)/times.length).toFixed(2)
              : '0.00';
    avgEl.textContent = avg;
  }
  
  function nextRound() {
    round++;
    if (round > maxRounds) return endGame();
    // breve pausa
    setTimeout(spawnCircle, 500);
  }
  
  function startGame() {
    hits=0; misses=0; times=[]; round=0;
    hitsEl.textContent = missesEl.textContent = '0';
    avgEl.textContent = '0.00';
    document.getElementById('controls').style.display = 'none';
    gameArea.style.display = 'block';
    stats.style.display    = 'block';
    spawnCircle();
  }
  
  function endGame() {
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
  