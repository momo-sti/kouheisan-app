# Kouheisan
![OGP](images/OGP.PNG)

### ■ サービスURL
https://kouheisan.com

### ■ サービス概要
友人との旅行で交通費の負担を公平にしたいけど直接お金を請求しづらい車持ちの人に交通費を計算し、間接的に請求をしてくれるアプリ。

### ■ ユーザーが抱える課題
①旅行で車出しをするときに交通費の請求をしづらい
②交通費を請求できずにドライバーの金銭的な負担が大きくなってしまう
③交通費の計算が面倒
④友人が交通費のことを考えてくれない

### ■ 課題に対する仮説
①→友人に交通費を請求するのは気が引けてしまう、当日請求の場合タイミングを逃しやすい
②→交通費は旅行後でなければ明確な金額がわからないので前もって請求することが難しい
③→複数のアプリを使わないと交通費が分からない
④→車を持っていない人は車での移動にどれだけお金かかるか知らないため、ドライバーの負担を理解できていない

### ■ 解決方法

①→旅行の計画段階でグループLINEにLINEBotを入れ、Bot経由で交通費の請求をするのでドライバーは気兼ねなく請求ができる
②③→ガソリン代・高速料金・割り勘をまとめて計算できる
④→Botが旅行前は目安の交通費を共有、旅行後は実際にかかった費用を請求することで友人もおおよその交通費を知らせることができる

### ■ メインのターゲットユーザー
- 車を持っている人

### ■ 実装予定の機能
**一般ユーザー**
- 交通費の計算ができる
- 割り勘機能が使える
- ユーザー登録・ログイン(LINEログイン)ができる

**ログインユーザー**
- 交通費の計算ができる
- 割り勘機能が使える
- お気に入り地点を登録できる
- LINEBotを使ってグループLINEに交通費を知らせる

**LINEBotの機能**
- Botに「交平さん」という男性キャラクターを設定
- アプリで作成した交通費をLINEグループに発信
    - 「 交平さん！」とLINEでメッセージを送るとアプリで作った交通費を交平さんがグループに送信する
- 交通費の共有後、支払いが完了したか確認する
    - 「支払いができたら★を送ってくれ！」というメッセージを交平さんがグループに発信

### ■ なぜこのサービスを作りたいのか？
友達と旅行に行く際ガソリン代や高速代を出してくれない人、割といませんか？
私は車だしをする機会が結構ありましたが、直接お金の請求がしづらくて一番お金を負担することが多かったので車出しをしたくなくなってしまいました。
なのでアプリを使って間接的に交通費の請求をすることで、自分のようにお金の問題でモヤモヤしているドライバーを無くしたいと思いました

### ■ スケジュール
企画〜技術調査：5/25 〆切
README〜ER図作成：6/2 〆切
メイン機能実装：6/2 - 7/7
β版をRUNTEQ内リリース（MVP）：7/7 〆切
本番リリース：7/21

### ■ 技術選定
- Rails7
- postgresql
- JavaScript
- TailWind CSS
- daisyUI
- fly.io
- LINE Messaging API
- Google Maps API
- LINE Login
- Hotwireを使用して一部SPA化予定

### ■ ER図
![ER図](images/ER.png)