class CostsController < ApplicationController
  def create_before
    @cost = create_cost(false)
    if @cost.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to callback_path }
      end
    else
      puts @cost.errors.full_messages
      flash[:alert] = @cost.errors.full_messages.join(', ')
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('error_message', partial: 'error_message', locals: { message: flash[:alert] })
        end
        format.html { redirect_to callback_path }
      end
    end
  end

  def create_after
    @cost = create_cost(true)
    if @cost.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to callback_path }
      end
    else
      puts @cost.errors.full_messages
      flash[:alert] = @cost.errors.full_messages.join(', ')
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('error_message', partial: 'error_message', locals: { message: flash[:alert] })
        end
        format.html { redirect_to callback_path }
      end
    end
  end

  def save_per_person_cost
    session[:per_person_cost] = params[:per_person_cost].to_f
    head :ok
  end

  private

  def create_cost(is_paid)
    cost = Cost.new(
      user_id: current_user.id,
      total_amount: session[:total_amount],
      per_person_cost: session[:per_person_cost],
      gasoline_cost: session[:result],
      distance: session['gasoline']['total_distance'],
      fuel_efficiency: session['gasoline']['fuel_efficiency'],
      price_per_liter: session['gasoline']['price_per_liter'],
      highway_cost: session[:highway_cost],
      start_place: session[:start_place],
      arrive_place: session[:arrive_place],
      is_paid:
    )
    # costが保存されてからextra_costを保存
    if cost.save && session[:extras]
      session[:extras].each do |extra|
        cost.extra_costs.create(
          category: extra['category'],
          amount: extra['amount']
        )
      end
    end
    # costとcostに紐づいたextra_costを戻り値として返す
    # (Costインスタンスのみの状態からCostとそれに紐づいたExtraCostになる)
    cost
  end

  def error
  end
end
