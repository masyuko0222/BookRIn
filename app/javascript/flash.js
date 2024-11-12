const closeFlash= () => {
  const flash = document.getElementById('flash');

  window.closeFlash= () => {
    if (flash) {
      flash.style.transition = 'opacity 0.5s ease';
      flash.style.opacity = '0';
      setTimeout(() => flash.remove(), 500);
    }
  };
}

document.addEventListener('turbo:load', closeFlash);
document.addEventListener('turbo:render', closeFlash);
