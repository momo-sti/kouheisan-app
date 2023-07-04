var editToggleButton = document.getElementById('edit-toggle-button');
console.log('s')
if (editToggleButton !== null) {
  editToggleButton.addEventListener('click', function() {
    console.log('shown')
    var actionButtons = document.querySelectorAll('.action-buttons');
    actionButtons.forEach(function(button) {
      var parentElement = button.parentElement;
      if (button.classList.contains('hidden')) {
        console.log('nya')
        button.classList.remove('hidden');
        button.classList.add('shown');
        parentElement.classList.add('shown');
      } else {
        console.log('grr')
        button.classList.remove('shown');
        button.classList.add('hidden');
        parentElement.classList.remove('shown');
      }
    });
  });
}
