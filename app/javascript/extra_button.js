var editToggleButton = document.getElementById('edit-toggle-button');

if (editToggleButton !== null) {
  editToggleButton.addEventListener('click', function() {

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
}

//extrasの更新ボタンを押した後モーダルを閉じる
document.addEventListener('turbo:submit-end', function(event) {
  const formId = event.target.dataset.formId;
  const modalId = `my_modal_${formId}`;
  const modalCheckbox = document.getElementById(modalId);
  
  if (modalCheckbox) {
    modalCheckbox.checked = false;
  }
});
