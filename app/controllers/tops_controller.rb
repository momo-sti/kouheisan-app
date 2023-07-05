class TopsController < ApplicationController
  def wakeup
    render json: { message: 'Server is awake' }
  end

  def new
  end

  def reset_session
    session.delete(:extras)
    head :ok  # HTTPステータスコード200を返す
  end
end
