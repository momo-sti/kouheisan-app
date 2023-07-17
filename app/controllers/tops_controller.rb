class TopsController < ApplicationController
  #cron-job
  def wakeup
    render json: { message: 'Server is awake' }
  end

  def new
  end

  #TOPページにアクセスするとセッションリセット
  def reset_session
    session.delete(:extras)
    head :ok
  end
end
