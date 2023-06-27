class TopsController < ApplicationController
  def new
  end

  def reset_session
    session.delete(:extras)
    head :ok  # HTTPステータスコード200を返す
  end
end
