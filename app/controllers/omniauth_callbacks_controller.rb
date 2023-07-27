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
        @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email:,
                                                name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
      end
      @profile.update_values(@omniauth)
      sign_in(:user, @profile)

      # ログイン後のflash messageとリダイレクト先を設定
      session[:toast] = 'ログインしました'
    else
      session[:toast] = 'ログインできませんでした'
    end
    redirect_to after_sign_in_path_for(:user)
  end
end
