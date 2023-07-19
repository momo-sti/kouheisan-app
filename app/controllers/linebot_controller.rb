require 'line/bot'

class LinebotController < ApplicationController
  protect_from_forgery except: [:callback]

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    #署名の検証
    return head :bad_request unless client.validate_signature(body, signature)
    #リクエストボディからイベントを解析
    events = client.parse_events_from(body)

    events.each do |event|
      process_event(event)
    end

    head :ok
  end

  private

  def process_event(event)
    #イベントを送信したユーザーのIDを取得し、そのIDに対応するユーザーをデータベースから検索
    user_id = event['source']['userId']
    user = User.where(uid: user_id).first

    case event
    when Line::Bot::Event::Join
      send_join_message(event)
    when Line::Bot::Event::Message
      process_message_event(event, user) if event.type == Line::Bot::Event::MessageType::Text
    end
  end

  def send_join_message(event)
    message = {
      type: 'text',
      text: "グループに追加してくれてありがとうな〜！\n交通費を共有したい時は俺を呼んでくれよな😉"
    }
    client.reply_message(event['replyToken'], message)
  end

  def process_message_event(event, user)
    return unless event.message['text'].include?('交平さん！')

    #ユーザーが存在していればそのユーザーのCost情報を取得
    cost = user&.costs&.last
    messages = no_user_messages(user, cost)
    #リプライトークン使用
    client.reply_message(event['replyToken'], messages)
  end

  # 新規ユーザーの場合
  def no_user_messages(user, cost)
    if user
      no_cost_messages(user, cost)
    else
      [
        {
          type: 'text',
          text: 'まずアプリを使ってくれ〜'
        }
      ]
    end
  end

  # ユーザー登録してるけど交通費を計算していない場合
  def no_cost_messages(user, cost)
    if cost
      share_cost_messages(user, cost)
    else
      [
        {
          type: 'text',
          text: '交通費を計算してから呼んでくれ〜'
        }
      ]
    end
  end

  def share_cost_messages(_user, cost)
    if cost.is_paid
      # 旅行後の交通費の場合
      [
        {
          type: 'text',
          text: "呼んだか？\n俺がこの旅行でかかった交通費を教えてやるよ。\nほらよ！"
        },
        FlexMessageBuilder.new(cost).build,
        send_payment_completed_message
      ]
    else
      # 旅行前の交通費の場合
      [
        {
          type: 'text',
          text: "呼んだか？\n俺がどのぐらい交通費がかかるか教えてやるよ。\nほらよ！"
        },
        FlexMessageBuilder.new(cost).build
      ]
    end
  end

  def send_payment_completed_message
    {
      type: 'text',
      text: "メンバーはドライバーに交通費を払ってくれよな！\n支払いが完了したら⭐️を送ってくれ！"
    }
  end
end
