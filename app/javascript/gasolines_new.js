//取得した距離と時間を表示
$(document).ready(function() {
  // セッションストレージからデータを取得
  var km = sessionStorage.getItem('km');
  var time = sessionStorage.getItem('time');

  // HTMLに表示
  $('#distance').text(km);
  $('#duration').text(time);
});