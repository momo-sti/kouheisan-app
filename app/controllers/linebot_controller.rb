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
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)

    events.each do |event|
      user_id = event['source']['userId']
      user = User.where(uid: user_id).first

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message['text'].include?('交平さん！')
            if user
              cost = Cost.where(user_id: user.id).last
              messages = if cost
                           if cost.is_paid
                             # 旅行後の交通費の場合
                             [
                               {
                                 type: 'text',
                                 text: "呼んだか？
                            \n俺がこの旅行でかかった交通費を教えてやるよ。
                            \nほらよ！"
                               },
                               FlexMessageBuilder.new(cost).build,
                               send_payment_completed_message
                             ]
                           else
                             # 旅行前の交通費の場合
                             [
                               {
                                 type: 'text',
                                 text: "呼んだか？
                            \n俺がどのぐらい交通費がかかるか教えてやるよ。
                            \nほらよ！"
                               },
                               FlexMessageBuilder.new(cost).build
                             ]
                           end
                         else
                           # ユーザー登録してるけど交通費を計算していない場合
                           [
                             {
                               type: 'text',
                               text: '交通費を計算してから呼んでくれ〜'
                             }
                           ]
                         end
            else
              # 新規ユーザーの場合
              messages = [
                {
                  type: 'text',
                  text: 'まずアプリを使ってくれ〜'
                }
              ]
            end
            client.reply_message(event['replyToken'], messages)
          end
        end
      end
    end

    head :ok
  end

  private

  def send_payment_completed_message
    {
      type: 'text',
      text: "メンバーはドライバーに交通費を払ってくれよな！\n支払いが完了したら⭐️を送ってくれ！"
    }
  end
end
