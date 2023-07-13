class CostsController < ApplicationController
  def create
    #costインスタンスに値を保存
    @cost = Cost.new(
      user_id: current_user.id,
      total_amount: session[:total_amount],
      gasoline_cost: session[:result],
      distance: session[:total_distance],
      fuel_efficiency: session[:fuel_efficiency],
      price_per_liter: session[:price_per_liter],
      highway_cost: session[:highway_cost],
      start_place: session[:start_place],
      arrive_place: session[:arrive_place],
      # save_afterが存在すればis_paidはtrue、そうでなければfalse
      is_paid: params[:save_after].present?
    )


    if @cost.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @cost }
      end
    else
      render :new
    end
  end
end
