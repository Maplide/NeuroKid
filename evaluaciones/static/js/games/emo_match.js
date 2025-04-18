// static/js/games/emo_match.js

document.addEventListener('DOMContentLoaded', () => {
  // 9 emojis: 4 pares + 1 comodín
  const emojis = ['😃','😞','😲','😠','😃','😞','😲','😠','😊'];
  const totalPairs = Math.floor(emojis.length / 2);  // 4 parejas
  let board      = document.getElementById('board');
  let first      = null, second = null;
  let tries      = 0;
  let times      = [];
  let matchedPairs = 0;

  // Barajar
  emojis.sort(() => Math.random() - 0.5);

  // Crear las cartas
  emojis.forEach(emoji => {
    const card = document.createElement('div');
    card.classList.add('card');
    card.innerHTML = `
      <div class="face front"></div>
      <div class="face back">${emoji}</div>
    `;
    board.appendChild(card);

    card.addEventListener('click', () => {
      if (card.classList.contains('flipped') || second) return;
      card.classList.add('flipped');

      if (!first) {
        first = { card, time: Date.now() };
      } else {
        second = { card, time: Date.now() };
        tries++;
        document.getElementById('tries').textContent = tries;

        // ¿Es pareja?
        const back1 = first.card.querySelector('.back').textContent;
        const back2 = second.card.querySelector('.back').textContent;
        if (back1 === back2) {
          // acierto
          const elapsed = (second.time - first.time) / 1000;
          times.push(elapsed);
          const avg = (times.reduce((a,b)=>a+b,0)/times.length).toFixed(2);
          document.getElementById('avgTime').textContent = avg;

          matchedPairs++;
          first = second = null;

          // Si ya encontró todas las parejas
          if (matchedPairs === totalPairs) {
            setTimeout(() => {
              if (confirm(`¡Terminaste! 🎉\nIntentos: ${tries}\nTiempo medio: ${avg} s\n\n¿Quieres jugar de nuevo?`)) {
                location.reload();
              } else {
                window.location.href = '/evaluaciones/';  // o la ruta que prefieras
              }
            }, 300);
          }
        } else {
          // fallo: desvoltear tras 1 s
          setTimeout(() => {
            first.card.classList.remove('flipped');
            second.card.classList.remove('flipped');
            first = second = null;
          }, 1000);
        }
      }
    });
  });
});