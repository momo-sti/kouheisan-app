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

  def search_favorite_location
    @favorite_locations = if params[:q].present?
                            FavoriteLocation.where('name LIKE ?', "%#{params[:q]}%")
                          else
                            FavoriteLocation.all
                          end
    render partial: 'autocomplete_results', locals: { favorite_locations: @favorite_locations }
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
