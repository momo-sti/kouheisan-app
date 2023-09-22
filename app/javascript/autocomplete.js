document.addEventListener('DOMContentLoaded', (event) => {
  const inputForm = document.querySelector('.inputForm');
  const isLoggedIn = inputForm ? inputForm.getAttribute('data-logged-in') === 'true' : false;

  const inputBegin = document.getElementById('inputBegin');
  const inputEnd = document.getElementById('inputEnd');
  const favoriteLocationsListBegin = document.getElementById('favoriteLocationsListBegin');
  const favoriteLocationsListEnd = document.getElementById('favoriteLocationsListEnd');

  let listItemClicked = false;

  function setAddressToInput(element) {
    const address = element.dataset.address;
    const input = (element.closest('#favoriteLocationsListBegin')) ? inputBegin : inputEnd;
    input.value = address;
    favoriteLocationsListBegin.style.display = 'none';
    favoriteLocationsListEnd.style.display = 'none';
  }

  function bindSetAddressToInput() {
    document.querySelectorAll('[data-address]').forEach(element => {
      element.addEventListener('click', function() {
        setAddressToInput(this);
      });
    });
  }

  function updateLocationsList(input, locations) {
    const list = (input === inputBegin) ? favoriteLocationsListBegin : favoriteLocationsListEnd;

    if (!list) return;

    list.innerHTML = ''; // Clear the list

    locations.forEach(location => {
      const li = document.createElement('li');
      li.textContent = location.name;
      li.dataset.address = location.address;
      li.className = "btn btn-sm";
      li.style.position = "relative";
      li.style.margin = "1px 0";
      li.style.width = "325px";
      li.style.left = "30px";
      li.style.textAlign = "left";
      li.style.backgroundColor = "#e5dfdc";
      li.addEventListener('mousedown', function() {
        listItemClicked = true;
        setAddressToInput(this);
      });
      const div = document.createElement('div');
      div.className = "list";
      div.appendChild(li);
      list.appendChild(div);
    });
  }

  if (isLoggedIn && inputBegin && inputEnd) {
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
        fetch(`/search_favorite_location?q=${input.value || ''}`)
          .then(response => {
            if (!response.ok) {
              throw new Error('Network response was not ok');
            }
            return response.json();
          })
          .then(data => {
            if (data.results && Array.isArray(data.results)) {
              updateLocationsList(input, data.results);
              if (input.value === "") {
                if (input === inputBegin) {
                  favoriteLocationsListBegin.style.display = 'block';
                } else if (input === inputEnd) {
                  favoriteLocationsListEnd.style.display = 'block';
                }
              }
            }
          })
          .catch(error => {
            console.error('There was a problem with the fetch operation:', error.message);
          });
      });
    });
  }

  if (inputBegin && inputEnd) {
    bindSetAddressToInput();
  }
});
