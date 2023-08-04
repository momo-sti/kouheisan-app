require 'line/bot'

class LinebotController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    linebot_service = LinebotService.new(client)

    events.each do |event|
      linebot_service.process_event(event)
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end
end
