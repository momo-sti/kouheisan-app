require 'line/bot'

class LinebotController < ApplicationController
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]
  
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)

    events.each { |event|
      #メッセージを送ってきたユーザのuidを特定
      user_id = event['source']['userId']
      #特定したユーザをuserに格納
      user = User.where(uid: user_id)[0]
      #送信されたメッセージに「交平さん！」が入っているかを確認
      if event.message['text'].include?("交平さん！")
        message = flex_costs(send_consts(user))
      elsif event.message['text'].include?("自動購入機能テスト")
        message = test_selenium(user)
      end

      case event
      # メッセージが送信された場合
      when Line::Bot::Event::Message
        case event.type
        # メッセージが送られて来た場合
        when Line::Bot::Event::MessageType::Text
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end

  private

  def send_costs(user)
    response = "交通費"
  end

  def flex_costs(response) ##メッセージの形式を作成
    {
      type: 'flex',
      altText: 'お買い物リスト',
      contents: {
        type: 'bubble',
        header:{
          type: 'box',
          layout: 'horizontal',
          contents:[
            {
              type: 'text',
              text: 'お買い物リスト',
              wrap: true,
              size: 'md',
            }
          ]
        },
        body: {
          type: 'box',
          layout: 'horizontal',
          contents: [
            {
              type: 'text',
              text: response,
              wrap: true,
              size: 'sm',
            }
          ]
        }
      }
    }
  end


end
