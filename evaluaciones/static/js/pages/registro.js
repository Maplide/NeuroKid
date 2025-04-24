document.addEventListener('DOMContentLoaded', function () {
    const codeField = document.getElementById('specialist_code_field');
    const radios = document.querySelectorAll('input[name="rol"]');
  
    function toggleCodeField() {
      const selected = document.querySelector('input[name="rol"]:checked').value;
      codeField.style.display = (selected === 'especialista') ? 'block' : 'none';
    }
  
    radios.forEach(radio => radio.addEventListener('change', toggleCodeField));
    toggleCodeField(); // Llama al cargar la página
  });
  