module ApplicationHelper
  def display_number(number)
    (number % 1).zero? ? number.to_i : number
  end

  def default_meta_tags
    {
      site: '交平さん',
      title: '車移動でかかる交通費の計算サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'ガソリン代金・高速道路料金を計算できます。LINEで交平さんを友達追加することで計算した交通費をLINEで共有できます。',
      keywords: '車,交通費,ガソリン代,高速料金,車代計算',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('OGP.PNG'),
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@',
        image: image_url('OGP.PNG')
      }
    }
  end
end
