class CostsController < ApplicationController
  def create_before
    @cost = create_cost(false)
    puts "Session: #{session.inspect}"
    if @cost.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to callback_path }
      end
    else
      puts @cost.errors.full_messages
      render :new
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
      render :new
    end
  end

  private

  def create_cost(is_paid)
    Cost.new(
      user_id: current_user.id,
      total_amount: session[:total_amount],
      gasoline_cost: session[:result],
      distance: session["gasoline"]["total_distance"],
      fuel_efficiency: session["gasoline"]["fuel_efficiency"],
      price_per_liter: session["gasoline"]["price_per_liter"],
      highway_cost: session[:highway_cost],
      start_place: session[:start_place],
      arrive_place: session[:arrive_place],
      is_paid: is_paid
    )
  end
  
end
