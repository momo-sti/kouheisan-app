var map, begin, end;
var directionsDisplay;
var directionsService;
var avoidHighways = true; // 高速道路使用有無（デフォルトは使用しない）

// initMapをグローバルスコープに公開
window.initMap = function() {
    return new Promise((resolve, reject) => {
        var latlng = new google.maps.LatLng(35.6895, 139.6917);  // マップの中心点（東京）

        // オプション
        var myOptions = {
            zoom: 14,
            center: latlng,
            scrollwheel: false,     // ホイールでの拡大・縮小
            mapTypeId: google.maps.MapTypeId.ROADMAP,
        };

        // #map_canvasを取得し、[mapOptions]の内容の、地図のインスタンス([map])を作成する
        map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);

        // 経路を取得
        if (!directionsDisplay) {
            directionsDisplay = new google.maps.DirectionsRenderer({
                suppressMarkers: true //デフォルトのマーカーを消す
            });
        }
        directionsDisplay.setMap(map);
        directionsDisplay.setPanel(document.getElementById('directionsPanel'));     // 経路詳細

        resolve();
    });
}

document.addEventListener('DOMContentLoaded', function() {
    // 'map_canvas'の要素が存在する場合のみ実行
    if (document.getElementById('map_canvas')) {
        // searchButtonがクリックされたら関数発火
        document.getElementById('searchButton').addEventListener('click', function(e) {
            e.preventDefault();
            begin = document.getElementById('inputBegin').value; // 開始地点
            end = document.getElementById('inputEnd').value; // 終了地点
            avoidHighways = !document.querySelector('input[type="checkbox"]').checked; // トグルで高速道路の使用有無判断
        
            // 出発地と目的地が両方とも入力されているかチェック
            if (begin === '' || end === '') {
                // 入力が足りない場合はエラーメッセージを表示
                var errorMessageDiv = document.getElementById('error-message');
                errorMessageDiv.classList.remove('hidden');  // divを表示
                document.getElementById('error-text').textContent = '出発地と目的地を入力してください';
                return;  // ルート計算の処理は行わない
            } else {
                // 入力が足りている場合はエラーメッセージを非表示にする
                document.getElementById('error-message').classList.add('hidden');
            }
        
            document.getElementById('directionsPanel').textContent = ' ';
            window.initMap().then(() => {
                calcRoute(begin, end); // ルート計算
            });
        });
        

// 決定ボタンがクリックされたらデータをセッションストレージに保存してから画面遷移
document.getElementById('confirmButton').addEventListener('click', function(e) {
    e.preventDefault();

    // 距離と時間を取得
    var km = document.querySelector('.adp-summary span[jstcache="25"]').textContent;
    var time = document.querySelector('.adp-summary span[jstcache="51"]').textContent;

    // セッションストレージに保存
    sessionStorage.setItem('km', km);
    sessionStorage.setItem('time', time);

    // CSRFトークンの取得
    var token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch('/tops/reset_session', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-CSRF-Token': token
        },
        body: new URLSearchParams({
            'authenticity_token': token
        })
    })
    .then(function(response) {
        if (response.ok) {
            // km,timeの保存とextraのリセットが完了したら、画面遷移を行う
            window.location.href = "/gasolines/new";
        } else {
            throw new Error('Request failed.');
        }
    })
    .catch(function(error) {
        console.error(error);
            });
        });
    }
});

// ルート取得
function calcRoute(begin, end) {
    var request = {
        origin: begin,         // 開始地点
        destination: end,      // 終了地点
        travelMode: google.maps.TravelMode.DRIVING,     // [自動車]でのルート
        avoidHighways: avoidHighways,       // 高速道路有無
    };

    // インスタンス作成
    if (!directionsService) {
        directionsService = new google.maps.DirectionsService();
    }

    directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);

            // 新しいマーカーの作成
            var EndIcon = {
                path: "M215.7 499.2C267 435 384 279.4 384 192C384 86 298 0 192 0S0 86 0 192c0 87.4 117 243 168.3 307.2c12.3 15.3 35.1 15.3 47.4 0zM192 128a64 64 0 1 1 0 128 64 64 0 1 1 0-128z",
                fillColor: '#d75050',
                fillOpacity: 1,
                strokeWeight: 0,
                scale: 0.06,
                anchor: new google.maps.Point(192, 512),
            };

            var startIcon = {
                path: "M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512z",
                fillColor: '#0084ff',
                fillOpacity: 1,
                strokeWeight: 0,
                scale: 0.06,
                anchor: new google.maps.Point(256, 256)
            };
            
            
            var startMarker = new google.maps.Marker({
                position: response.routes[0].legs[0].start_location,
                map: map,
                icon: startIcon
            });
            
            
        
            var endMarker = new google.maps.Marker({
                position: response.routes[0].legs[0].end_location,
                map: map,
                icon: EndIcon
            });
        
            var route = response.routes[0];
            var leg = route.legs[0];

            var km = leg.distance.text;   //距離
            var time = leg.duration.text; //時間

            document.getElementById('routeDetails').textContent = km + '(所要時間：' + time + ')';

        } else {
            alert('ルートが見つかりませんでした…');
        }
    });
}


document.addEventListener('DOMContentLoaded', function() {
    const searchButton = document.getElementById('searchButton');
    const confirmButton = document.getElementById('confirmButton');
    const errorMessage = document.getElementById('error-message');
    const errorText = document.getElementById('error-text');
  
    function showAlertIfInputEmpty(e) {
      const start = document.getElementById('inputBegin').value;
      const end = document.getElementById('inputEnd').value;
      if (start === '' || end === '') {
        e.preventDefault();
        errorMessage.classList.remove('hidden');
        errorText.textContent = '出発地と目的地を入力してください。';
      }
    }
  
    searchButton.addEventListener('click', showAlertIfInputEmpty);
    confirmButton.addEventListener('click', showAlertIfInputEmpty);
  });
  
