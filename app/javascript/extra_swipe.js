let swipeableRows = document.querySelectorAll('.swipeable-row');

swipeableRows.forEach(function(row) {
    let touchStartX = 0;
    let touchEndX = 0;

    row.addEventListener('touchstart', function(event) {
        touchStartX = event.touches[0].clientX;
    }, false);

    row.addEventListener('touchend', function(event) {
        touchEndX = event.changedTouches[0].clientX;
        handleSwipe(row);
    }, false);

    function handleSwipe(row) {
      if (touchEndX < touchStartX) {
        // left swipe
        row.classList.add('show-buttons');
      } else if (touchEndX > touchStartX) {
        // right swipe
        row.classList.remove('show-buttons');
      }
    }
    
});
