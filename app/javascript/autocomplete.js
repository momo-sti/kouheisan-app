document.addEventListener('DOMContentLoaded', (event) => {
  const inputBegin = document.getElementById('inputBegin');
  const inputEnd = document.getElementById('inputEnd');
  const favoriteLocationsListBegin = document.getElementById('favoriteLocationsListBegin');
  const favoriteLocationsListEnd = document.getElementById('favoriteLocationsListEnd');

  let listItemClicked = false;

  [inputBegin, inputEnd].forEach(input => {
      input.addEventListener('focus', function() {
          if (input === inputBegin && !input.value) {
              favoriteLocationsListBegin.style.display = 'block';
          } else if (input === inputEnd && !input.value) {
              favoriteLocationsListEnd.style.display = 'block';
          }
      });

      input.addEventListener('blur', function() {
          setTimeout(() => {
              if (!listItemClicked) {
                  if (input === inputBegin) {
                      favoriteLocationsListBegin.style.display = 'none';
                  } else if (input === inputEnd) {
                      favoriteLocationsListEnd.style.display = 'none';
                  }
              }
              listItemClicked = false;
          }, 150);
      });

      input.addEventListener('input', function() {
        if (input.value) { // 値が存在する場合
            if (input === inputBegin) {
                favoriteLocationsListBegin.style.display = 'none';
            } else if (input === inputEnd) {
                favoriteLocationsListEnd.style.display = 'none';
            }
        } else { // 値が空の場合
            if (input === inputBegin) {
                favoriteLocationsListBegin.style.display = 'block';
            } else if (input === inputEnd) {
                favoriteLocationsListEnd.style.display = 'block';
            }
        }
    });
  });

  document.querySelectorAll('#favoriteLocationsListBegin li, #favoriteLocationsListEnd li').forEach(item => {
      item.addEventListener('mousedown', function() {
          listItemClicked = true;
          const activeInput = document.activeElement;
          if (activeInput && activeInput.dataset.autocompleteTarget === "input") {
              activeInput.value = item.dataset.address;
              favoriteLocationsListBegin.style.display = 'none';
              favoriteLocationsListEnd.style.display = 'none';
          }
      });
  });
});
