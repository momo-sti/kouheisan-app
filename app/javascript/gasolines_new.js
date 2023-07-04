document.addEventListener('DOMContentLoaded', function() {
  // セッションストレージからデータを取得
  var km = sessionStorage.getItem('km');
  var time = sessionStorage.getItem('time');

  // HTMLに表示
  document.getElementById('distance').textContent = km;
  document.getElementById('duration').textContent = time;
});
