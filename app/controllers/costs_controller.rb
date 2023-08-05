class CostsController < ApplicationController
  def create
    is_paid = params[:action_type] != 'before'
    params = build_cost_params(is_paid)
    @cost = Cost.create_with_extras(params)

    # @costががデータベースに保存されているかどうかを判定
    if @cost.persisted?
      # 処理が成功した場合
      handle_success
    else
      # 失敗した場合
      handle_failure
    end
  end

  def save_per_person_cost
    session[:per_person_cost] = params[:per_person_cost].to_f
    head :ok
  end

  private

  def build_cost_params(is_paid)
    {
      user_id: current_user.id,
      total_amount: session[:total_amount] || 0,
      per_person_cost: session[:per_person_cost] || 0,
      gasoline_cost: session[:result].presence || 0,
      distance: session['gasoline']['total_distance'] || 0,
      fuel_efficiency: session['gasoline']['fuel_efficiency'] || 0,
      price_per_liter: session['gasoline']['price_per_liter'] || 0,
      highway_cost: session[:highway_cost] || 0,
      start_place: session[:start_place].present? ? session[:start_place] : 'なし',
      arrive_place: session[:arrive_place].present? ? session[:arrive_place] : 'なし',
      is_paid:,
      extras: session[:extras]
    }
  end

  def handle_success
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to callback_path }
    end
  end

  def handle_failure
    puts @cost.errors.full_messages
    flash[:alert] = @cost.errors.full_messages.join(', ')
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('error_message', partial: 'error_message', locals: { message: flash[:alert] })
      end
      format.html { redirect_to callback_path }
    end
  end

  def error
  end
end
