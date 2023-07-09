document.addEventListener('turbo:load', function() {
  // セッションストレージからデータを取得
  var km = sessionStorage.getItem('km');
  var time = sessionStorage.getItem('time');

  // HTMLに表示
  var distanceElement = document.getElementById('distance');
  var durationElement = document.getElementById('duration');
  if (distanceElement) {
    distanceElement.textContent = km;
  }
  if (durationElement) {
    durationElement.textContent = time;
  }
});
