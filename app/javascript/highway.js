document.addEventListener('DOMContentLoaded', function() {
  console.log('DOMContentLoaded event fired'); 
  const mainForm = document.getElementById('main_form');
  const externalForm = document.getElementById('external_form');
  
  if (mainForm) {
    mainForm.addEventListener('submit', function(event) {
      console.log('mainForm submit event fired');
      event.preventDefault();

      // メインのフォームのデータを取得
      const formData = new FormData(mainForm);

      // 外部サイトへのフォームのデータを設定
      document.getElementById('startPlaceKana').value = formData.get('start_place');
      document.getElementById('arrivePlaceKana').value = formData.get('arrive_place');
      document.getElementById('searchHour').value = formData.get('hour');
      document.getElementById('searchMinute').value = formData.get('minute');
      document.getElementById('kind').value = formData.get('kind');
      document.getElementById('carType').value = formData.get('car_type');
      const date = formData.get('date').split('-');
      document.getElementById('searchYear').value = date[0];
      document.getElementById('searchMonth').value = parseInt(date[1], 10); // 月を整数に変換
      document.getElementById('searchDay').value = parseInt(date[2], 10); // 日を整数に変換

      // メインのフォームを非同期で送信
      fetch(mainForm.action, {
        method: 'POST',
        body: formData,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',  // RailsがAjaxリクエストと認識するために必要
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content  // CSRF対策
        },
        credentials: 'same-origin'  //クッキーを含むリクエストを送信するために必要
      }).then(function(response) {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }

        // 外部サイトへのフォームを送信
        externalForm.submit();
      }).catch(function(error) {
        console.error('There has been a problem with your fetch operation:', error);
      });
    });
  }
});
