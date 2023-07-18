require 'open-uri'
require 'uri'

class OmniauthCallbacksController < ApplicationController
  before_action :store_location, only: [:basic_action]

  def line
    basic_action
  end

  private

  def basic_action
    store_location
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth['provider'], uid: @omniauth['uid'])
      if @profile.email.blank?
        email = @omniauth['info']['email'] || "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
        @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email: email,
                                                name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
      end
      @profile.set_values(@omniauth)
      # LINEのプロフィール画像をActive Storageに保存
      avatar_url = @omniauth['info']['image']
      @profile.avatar.attach(io: URI.open(avatar_url), filename: 'avatar.jpg', content_type: 'image/jpg')
      sign_in(:user, @profile)
    end
    # ログイン後のflash messageとリダイレクト先を設定
    flash[:notice] = 'ログインしました'
    redirect_to after_sign_in_path_for(:user)
  end

  def fake_email(_uid, _provider)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
