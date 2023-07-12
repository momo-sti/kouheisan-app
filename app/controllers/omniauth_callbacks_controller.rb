require 'open-uri'
require 'uri'

class OmniauthCallbacksController < ApplicationController
  def line
    basic_action
  end

  private
  
  def basic_action
    @omniauth = request.env["omniauth.auth"]
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
      if @profile.email.blank?
        email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
        @profile = current_user || User.create!(provider: @omniauth["provider"], uid: @omniauth["uid"], email: email, name: @omniauth["info"]["name"], password: Devise.friendly_token[0, 20])
      end
      @profile.set_values(@omniauth)
      # LINEのプロフィール画像をActive Storageに保存
      avatar_url = @omniauth["info"]["image"]
      @profile.avatar.attach(io: URI.open(avatar_url), filename: 'avatar.jpg', content_type: 'image/jpg')
      sign_in(:user, @profile)
    end
    #ログイン後のflash messageとリダイレクト先を設定
    flash[:notice] = "ログインしました"
    redirect_to root_path
  end

  def fake_email(uid, provider)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
