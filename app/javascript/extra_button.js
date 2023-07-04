document.getElementById('edit-toggle-button').addEventListener('click', function() {
  var actionButtons = document.querySelectorAll('.action-buttons');
  actionButtons.forEach(function(button) {
    var parentElement = button.parentElement;
    if (button.classList.contains('hidden')) {
      button.classList.remove('hidden');
      button.classList.add('shown');
      parentElement.classList.add('shown');
    } else {
      button.classList.remove('shown');
      button.classList.add('hidden');
      parentElement.classList.remove('shown');
    }
  });
});
