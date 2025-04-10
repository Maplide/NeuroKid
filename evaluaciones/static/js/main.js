// Inicializar AOS para animaciones
document.addEventListener('DOMContentLoaded', function() {
    AOS.init({
      duration: 800,
      easing: 'ease-in-out',
      once: true
    });
  
    // Cambiar clase de navbar al hacer scroll
    const navbar = document.querySelector('.main-navbar');
    
    if (navbar) {
      window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
          navbar.classList.add('navbar-scrolled');
        } else {
          navbar.classList.remove('navbar-scrolled');
        }
      });
    }
  
    // Puedes agregar más funcionalidades aquí
    console.log('NeuroKid JS cargado correctamente');
  });
  
  // Funciones reutilizables
  function toggleMobileMenu() {
    const navbarCollapse = document.getElementById('mainNav');
    if (navbarCollapse) {
      navbarCollapse.classList.toggle('show');
    }
  }
  
  // Exportar funciones si es necesario
  export { toggleMobileMenu };