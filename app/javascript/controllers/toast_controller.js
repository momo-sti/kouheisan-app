document.addEventListener("DOMContentLoaded", function() {
  const toastElement = document.querySelector('#toast')
  if (toastElement) {
    toastElement.style.visibility = "visible";

    setTimeout(function() {
      toastElement.style.transform = "translateX(-100%)";
    }, 2000);
  }
})
