class GasolinesController < ApplicationController
  def new
    if URI(request.referer).path == root_path
      session[:gasoline] = {}
      session[:result] = ""
    end
    @gasoline = Gasoline.new
    @result = session[:result]
  end

  def create
    @gasoline = Gasoline.new(gasoline_params)
    if @gasoline.valid?
      @result = @gasoline.calculate
      session[:gasoline] = gasoline_params
      session[:result] = @result
      redirect_to new_gasoline_path
    else
      render :new
    end
  end

  private

  def gasoline_params
    params.require(:gasoline).permit(:total_distance, :fuel_efficiency, :price_per_liter)
  end
end
