document.addEventListener("DOMContentLoaded", () => {
  console.log("✅ Welcome page ready");

  const card = document.querySelector('.welcome-card');
  if (card) {
    card.animate(
      [
        { transform: 'translateY(20px)', opacity: 0 },
        { transform: 'translateY(0)', opacity: 1 }
      ],
      {
        duration: 800,
        easing: 'cubic-bezier(0.4, 0, 0.2, 1)',
        fill: 'forwards'
      }
    );
  }

  // Animación adicional para el balance: contar desde 0 al saldo real
  const balanceEl = document.getElementById('balance-amount');
  if (balanceEl) {
    let current = 0;
    const target = parseInt(balanceEl.textContent.replace(/[^0-9]/g, ''), 10) || 0;
    const duration = 1500;
    const stepTime = 30;
    const steps = Math.ceil(duration / stepTime);
    let stepCount = 0;

    const counter = setInterval(() => {
      stepCount++;
      const val = Math.floor((target / steps) * stepCount);
      balanceEl.textContent = `$${val.toLocaleString()}`;
      if (stepCount >= steps) {
        balanceEl.textContent = `$${target.toLocaleString()}`;
        clearInterval(counter);
      }
    }, stepTime);
  }
});
