class SplitsController < ApplicationController
  def create
    session[:number_of_people] = params[:number_of_people].to_i
    update_split

    redirect_to splits_path
  end

  def update_split
    total_amount = session[:total_amount].to_f
    number_of_people = session[:number_of_people]
    split_amount = total_amount / number_of_people
    session[:split_amount] = split_amount
  end
end
