class FavoriteLocationsController < ApplicationController
  before_action :set_favorite_location, only: [:edit, :update, :destroy]
  before_action :redirect_index, only: %i[ new show edit ]

  def index
    @favorite_locations = current_user.favorite_locations.order(id: :asc)
  end

  def new
    @favorite_location = current_user.favorite_locations.build
    @favorite_location.valid?
  end

  def create
    @favorite_location = current_user.favorite_locations.build(favorite_location_params)
    if @favorite_location.save
      render :create
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @favorite_location.update(favorite_location_params)
      render :show
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite_location.destroy
    render turbo_stream: turbo_stream.remove(@favorite_location)
  end

  private

  def set_favorite_location
    @favorite_location = current_user.favorite_locations.find(params[:id])
  end

  def favorite_location_params
    params.require(:favorite_location).permit(:name, :address)
  end

  def redirect_index
    redirect_to favorite_locations_url unless turbo_frame_request?
  end
end
