class FavoriteLocationsController < ApplicationController
  before_action :set_favorite_location, only: [:edit, :update, :destroy]

  def index
    @favorite_locations = current_user.favorite_locations
  end

  def new
    @favorite_location = current_user.favorite_locations.build
  end

  def create
    @favorite_location = current_user.favorite_locations.build(favorite_location_params)
    if @favorite_location.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to favorite_locations_path, notice: "お気に入り地点を追加しました。" }
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @favorite_location.update(favorite_location_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to favorite_locations_path, notice: "お気に入り地点を更新しました。" }
      end
    else
      render :edit
    end
  end

  def destroy
    @favorite_location.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to favorite_locations_path, notice: "お気に入り地点を削除しました。" }
    end
  end

  private

  def set_favorite_location
    @favorite_location = current_user.favorite_locations.find(params[:id])
  end

  def favorite_location_params
    params.require(:favorite_location).permit(:name, :address)
  end
end
