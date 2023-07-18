document.addEventListener("DOMContentLoaded", function() {
  const toastElement = document.querySelector('#toast')
  toastElement.style.visibility = "visible";

  setTimeout(function() {
    toastElement.style.transform = "translateX(-100%)";
  }, 2000);
})