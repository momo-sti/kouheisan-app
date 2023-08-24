class TopsController < ApplicationController
  # cron-job
  def wakeup
    render json: { message: 'Server is awake' }
  end

  def top
    @favorite_locations = FavoriteLocation.all
  end

  def new
  end

  def search
    query = params[:q]
    @locations = FavoriteLocation.where('name LIKE ?', "%#{query}%")
    render json: { results: @locations.as_json }
  end

  def favorites
    @favorite_locations = FavoriteLocation.all
    respond_to do |format|
      format.json { render json: @favorite_locations }
    end
  end

  # TOPページにアクセスするとセッションリセット
  def reset_session
    session.delete(:extras)
    head :ok
  end
end
