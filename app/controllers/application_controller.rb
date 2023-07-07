class ApplicationController < ActionController::Base
  
  private

  def load_session_data
    @result = (session[:result] || 0).to_f
    @total_distance = (session[:gasoline]['total_distance'] || 0).to_f
    @fuel_efficiency = (session[:gasoline]['fuel_efficiency'] || 0).to_f
    @price_per_liter = (session[:gasoline]['price_per_liter'] || 0).to_f
    @start_place = session[:start_place]
    @arrive_place = session[:arrive_place]
    @highway_cost = (session[:highway_cost] || 0).to_f
    @extras = session[:extras]&.map { |extra| Extra.new(extra) } || []
  end

  def calculate_total_amount
    load_session_data
    extras_sum = @extras.sum { |extra| extra.amount.to_f }
    @total_amount = @result + @highway_cost + extras_sum
  end
end
