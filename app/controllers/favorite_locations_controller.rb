class FavoriteLocationsController < ApplicationController
  before_action :set_favorite_location, only: %i[ show edit update destroy ]

  # GET /favorite_locations or /favorite_locations.json
  def index
    @favorite_locations = FavoriteLocation.all
  end

  # GET /favorite_locations/1 or /favorite_locations/1.json
  def show
  end

  # GET /favorite_locations/new
  def new
    @favorite_location = FavoriteLocation.new
  end

  # GET /favorite_locations/1/edit
  def edit
  end

  # POST /favorite_locations or /favorite_locations.json
  def create
    @favorite_location = FavoriteLocation.new(favorite_location_params)

    respond_to do |format|
      if @favorite_location.save
        format.html { redirect_to favorite_location_url(@favorite_location), notice: "Favorite location was successfully created." }
        format.json { render :show, status: :created, location: @favorite_location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @favorite_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorite_locations/1 or /favorite_locations/1.json
  def update
    respond_to do |format|
      if @favorite_location.update(favorite_location_params)
        format.html { redirect_to favorite_location_url(@favorite_location), notice: "Favorite location was successfully updated." }
        format.json { render :show, status: :ok, location: @favorite_location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favorite_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorite_locations/1 or /favorite_locations/1.json
  def destroy
    @favorite_location.destroy

    respond_to do |format|
      format.html { redirect_to favorite_locations_url, notice: "Favorite location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite_location
      @favorite_location = FavoriteLocation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_location_params
      params.require(:favorite_location).permit(:user_id, :latitude, :longitude, :name)
    end
end
