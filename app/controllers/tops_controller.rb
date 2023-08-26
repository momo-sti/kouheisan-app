class TopsController < ApplicationController
  # cron-job
  def wakeup
    render json: { message: 'Server is awake' }
  end

  def top
    set_favorite_locations
  end

  def new
  end

  def search
    query = params[:q]
    @locations = if user_signed_in?
                   current_user.favorite_locations.where('name LIKE ?', "%#{query}%")
                 else
                   []
                 end
    render json: { results: @locations.as_json }
  end

  def favorites
    set_favorite_locations
    respond_to do |format|
      format.json { render json: @favorite_locations }
    end
  end

  # TOPページにアクセスするとセッションリセット
  def reset_session
    session.delete(:extras)
    head :ok
  end

  private

  def set_favorite_locations
    @favorite_locations = user_signed_in? ? current_user.favorite_locations : []
  end
end
