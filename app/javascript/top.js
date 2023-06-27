var map, begin, end;
var directionsDisplay;
var directionsService;
var avoidHighways = true; // 高速道路使用有無（デフォルトは使用しない）

// initMapをグローバルスコープに公開
window.initMap = function() {
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
    directionsDisplay = new google.maps.DirectionsRenderer();
    directionsDisplay.setMap(map);
    directionsDisplay.setPanel(document.getElementById('directionsPanel'));     // 経路詳細
}

window.onload = function() {
    // searchButtonがクリックされたら関数発火
    $('#searchButton').click(function(e) {
        e.preventDefault();
        begin = $('#inputBegin').val(); // 開始地点
        end   = $('#inputEnd').val(); // 終了地点
        avoidHighways = $('input[name="highways"]:checked').val() === 'no'; // トグルで判断
        $('#directionsPanel').text(' ');
        window.initMap();
        calcRoute(begin, end); // ルート計算
    });
}

// ルート取得
function calcRoute(begin, end) {
    var request = {
        origin: begin,         // 開始地点
        destination: end,      // 終了地点
        travelMode: google.maps.TravelMode.DRIVING,     // [自動車]でのルート
        avoidHighways: avoidHighways,       // 高速道路有無
    };

    // インスタンス作成
    directionsService = new google.maps.DirectionsService();

    directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
            var route = response.routes[0];
            var leg = route.legs[0];
        } else {
            alert('ルートが見つかりませんでした…');
        }
    });
}

// 決定ボタンがクリックされたらデータをセッションストレージに保存してから画面遷移
$('#confirmButton').click(function(e) {
    e.preventDefault();

    // 距離と時間を取得
    var km = $('.adp-summary span[jstcache="25"]').text();
    var time = $('.adp-summary span[jstcache="51"]').text();

    // セッションストレージに保存
    sessionStorage.setItem('km', km);
    sessionStorage.setItem('time', time);
    // extraのセッションをリセット
    $.ajax({
        type: 'POST',
        url: '/tops/reset_session',
        data: { authenticity_token: $('meta[name="csrf-token"]').attr('content') },
        success: function() {
            // km,timeの保存とextraのリセットが完了したら、画面遷移を行う
            window.location.href = "/gasolines/new";
        }
    });
});
