class GasolinesController < ApplicationController
  def new
    if URI(request.referer).path == root_path
      session[:gasoline] = {}
      session[:result] = ''
    end
    @gasoline = Gasoline.new
    @result = session[:result].present? ? session[:result] : 0
  end

  def create
    @gasoline = Gasoline.new(gasoline_params)
    if @gasoline.valid?
      @result = @gasoline.calculate
      session[:gasoline] = gasoline_params
      session[:result] = @result

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('gasoline_cost', partial: 'gasolines/result', locals: { result: @result })
        end
        format.html { redirect_to new_gasoline_path }
      end
    else
      render :new
    end
  end

  private

  def gasoline_params
    params.require(:gasoline).permit(:total_distance, :fuel_efficiency, :price_per_liter).transform_values(&:to_f)
  end
end
