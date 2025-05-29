document.addEventListener('DOMContentLoaded', () => {
  console.log("🟢 emo_match.js cargado correctamente");

  const emojis = ['😃','😞','😲','😠','😃','😞','😲','😠','😊'];
  const totalPairs = Math.floor(emojis.length / 2);
  let board = document.getElementById('board');
  let pauseBtn = document.getElementById('pauseBtn');
  let resetBtn = document.getElementById('resetBtn');

  let first = null, second = null;
  let tries = 0;
  let times = [];
  let matchedPairs = 0;
  let isPaused = false;

  emojis.sort(() => Math.random() - 0.5);

  emojis.forEach(emoji => {
    const card = document.createElement('div');
    card.classList.add('card');
    card.innerHTML = `
      <div class="face front"></div>
      <div class="face back">${emoji}</div>
    `;
    board.appendChild(card);

    card.addEventListener('click', () => {
      if (isPaused || card.classList.contains('flipped') || second) return;

      card.classList.add('flipped');

      if (!first) {
        first = { card, time: Date.now() };
      } else {
        second = { card, time: Date.now() };
        tries++;
        document.getElementById('tries').textContent = tries;

        const back1 = first.card.querySelector('.back').textContent;
        const back2 = second.card.querySelector('.back').textContent;

        if (back1 === back2) {
          const elapsed = (second.time - first.time) / 1000;
          times.push(elapsed);
          const avg = (times.reduce((a,b)=>a+b,0)/times.length).toFixed(2);
          document.getElementById('avgTime').textContent = avg;

          matchedPairs++;
          first = second = null;

          if (matchedPairs === totalPairs) {
            setTimeout(() => {
              document.getElementById('finalHitsFirme').textContent = tries;
              document.getElementById('finalMissesFirme').textContent = emojis.length - tries;

              // Se guarda SIEMPRE, para invitados también
              registrarResultadoIA(tries, parseFloat(avg));

              // Mostramos el modal con botones controlados por el HTML
              const endModal = new bootstrap.Modal(document.getElementById('endModal'));
              endModal.show();
            }, 300);
          }
        } else {
          setTimeout(() => {
            first.card.classList.remove('flipped');
            second.card.classList.remove('flipped');
            first = second = null;
          }, 1000);
        }
      }
    });
  });

  // Botón Pausar/Reanudar
  pauseBtn.addEventListener('click', () => {
    isPaused = !isPaused;
    pauseBtn.textContent = isPaused ? "▶️ Reanudar" : "⏸️ Pausar";
  });

  // Botón Reiniciar
  resetBtn.addEventListener('click', () => {
    if (confirm("¿Seguro que deseas reiniciar el juego?")) {
      location.reload();
    }
  });

  // Enviar intento al backend
  async function registrarResultadoIA(intentos, avgTime) {
    const payload = {
      juego: "EmoMatch",
      resultado: intentos,
      tiempo_promedio: avgTime
    };

    try {
      const response = await fetch("/evaluaciones/api/registro_intento/", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      });

      const data = await response.json();
      if (data.status === "ok") {
        console.log("✅ Resultado registrado correctamente");
      } else {
        console.warn("⚠️ Error desde backend:", data);
      }
    } catch (error) {
      console.error("❌ Error en la conexión con backend:", error);
    }
  }
});
