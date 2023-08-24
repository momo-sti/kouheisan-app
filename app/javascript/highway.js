document.addEventListener('turbo:load', function() {
  const mainForm = document.getElementById('main_form');
  const searchButton = document.querySelector('.search .btn');

  // セッションストレージからフォームの値を取得
  function getFormData() {
    return JSON.parse(sessionStorage.getItem('mainForm') || '[]');
  }

  // フォームの値をセッションストレージに保存
  function setFormData() {
    const formDataArray = Array.from(new FormData(mainForm).entries());
    sessionStorage.setItem('mainForm', JSON.stringify(formDataArray));
  }

  // フォームの値をセッションストレージから復元
  function restoreFormData() {
    const formData = getFormData();
    formData.forEach(item => {
      mainForm[item[0]].value = item[1];
    });
    sessionStorage.removeItem('mainForm'); // 一度復元したらセッションストレージから削除
  }

  if (mainForm) {
    // 新規タブ開いて親ページがリロードされた際のフォームの値の復元
    restoreFormData();

    searchButton.addEventListener('click', function() {
      // メインのフォームのデータを取得
      const formData = new FormData(mainForm);

      // フォームの値を保存
      setFormData();

      // 外部サイトへのURLを生成
      const url = new URL('https://www.driveplaza.com/dp/SearchQuick');
      const date = formData.get('date').split('-');
      url.searchParams.append('startPlaceKana', formData.get('start_place'));
      url.searchParams.append('arrivePlaceKana', formData.get('arrive_place'));
      url.searchParams.append('searchHour', formData.get('hour'));
      url.searchParams.append('searchMinute', formData.get('minute'));
      url.searchParams.append('kind', formData.get('kind'));
      url.searchParams.append('carType', formData.get('car_type'));
      url.searchParams.append('searchYear', date[0]);
      url.searchParams.append('searchMonth', parseInt(date[1], 10)); // 月を整数に変換
      url.searchParams.append('searchDay', parseInt(date[2], 10)); // 日を整数に変換

      // 新しいタブを開く処理
      window.open(url.toString(), '_blank');

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
      }).catch(function(error) {
        console.error('There has been a problem with your fetch operation:', error);
      });
    });
  }
});
