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

  // "km" を取り除く（もし含まれていれば）
  if (km && typeof km === 'string') {
    km = km.replace(' km', '');
  }

  // total_distanceのinputフィールドに値を設定
  var totalDistanceInput = document.querySelector("input[name='gasoline[total_distance]']");
  
  if (totalDistanceInput && km) {
    totalDistanceInput.value = km;
  }
});
