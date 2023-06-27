class HighwaysController < ApplicationController
  def index
    @start_place = session[:start_place]
    @arrive_place = session[:arrive_place]
    @car_type = session[:car_type]
    @year = session[:year]
    @month = session[:month]
    @day = session[:day]
    @hour = session[:hour]
    @min = session[:min]
    @kind = session[:kind]
    @highway_cost = session[:highway_cost]
  end

  def create
    #パラメータをセッションに保存
    session[:start_place] = params[:start_place]
    session[:arrive_place] = params[:arrive_place]
    session[:car_type] = params[:car_type]
    session[:year], session[:month], session[:day] = params[:date].split("-")
    session[:hour] = params["time(4i)"]
    session[:min] = params["time(5i)"]
    session[:kind] = params[:kind]
  
    respond_to do |format|
      format.html { redirect_to highway_highways_path }
      format.json { head :no_content }
    end
  end

  def save_highway_info

    session[:highway_cost] = params[:highway_cost].to_i.presence || 0
    @start_place = session[:start_place]
    @arrive_place = session[:arrive_place]
    @highway_cost = session[:highway_cost]
    redirect_to extras_path
  end

  def highway; end

  def reset_and_redirect
    session[:start_place] = nil
    session[:arrive_place] = nil
    session[:car_type] = nil
    session[:year] = nil
    session[:month] = nil
    session[:day] = nil
    session[:hour] = nil
    session[:min] = nil
    session[:kind] = nil

    redirect_to highway_highways_path
  end

  
end
