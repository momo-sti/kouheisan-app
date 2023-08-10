document.addEventListener('DOMContentLoaded', (event) => {
  const inputBegin = document.getElementById('inputBegin');
  const inputEnd = document.getElementById('inputEnd');
  const favoriteLocationsListBegin = document.getElementById('favoriteLocationsListBegin');
  const favoriteLocationsListEnd = document.getElementById('favoriteLocationsListEnd');

  let listItemClicked = false;

  function updateLocationsList(input, locations) {
      const list = (input === inputBegin) ? favoriteLocationsListBegin : favoriteLocationsListEnd;
      list.innerHTML = ''; // Clear the list

      locations.forEach(location => {
          const li = document.createElement('li');
          li.textContent = location.name;
          li.dataset.address = location.address;
          li.addEventListener('mousedown', function() {
              listItemClicked = true;
              input.value = li.dataset.address;
              favoriteLocationsListBegin.style.display = 'none';
              favoriteLocationsListEnd.style.display = 'none';
          });
          list.appendChild(li);
      });
  }

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
          fetch(`/search_favorite_location?q=${input.value || ''}`) // If input is empty, send empty string to get all locations
              .then(response => {
                  if (!response.ok) {
                      throw new Error('Network response was not ok');
                  }
                  return response.json();
              })
              .then(data => {
                  if (data.results && Array.isArray(data.results)) {
                      updateLocationsList(input, data.results);
                  }
              })
              .catch(error => {
                  console.error('There was a problem with the fetch operation:', error.message);
              });
      });
  });
});
