class ExtrasController < ApplicationController
  before_action :set_extra, only: [:edit, :update, :destroy]

  def index
    @result = (session[:result] || 0).to_f
    @total_distance = (session[:gasoline]['total_distance'] || 0).to_f
    @fuel_efficiency = (session[:gasoline]['fuel_efficiency'] || 0).to_f
    @price_per_liter = (session[:gasoline]['price_per_liter'] || 0).to_f
    @start_place = session[:start_place]
    @arrive_place = session[:arrive_place]
    @highway_cost = (session[:highway_cost] || 0).to_f
    @extras = session[:extras]&.map { |extra| Extra.new(extra) } || []

    #extra.amountを数値に変換
    extras_sum = @extras.sum { |extra| extra.amount.to_f }
    #金額を合算
    @total_amount = @result + @highway_cost + extras_sum

    @extra = Extra.new
  end

  def new
    @extra = Extra.new
  end

  def create
    @extra = Extra.new(extra_params)
    if @extra.valid?
      session[:extras] ||= []
      session[:extras] << extra_params
      puts "session[:extras] after create: #{session[:extras].inspect}"
      redirect_to extras_path, success: "登録しました"
    else
      render :new
    end
  end

  def edit
    @extras = session[:extras].map.with_index { |extra, i| Extra.new(extra.merge(id: i)) }
  @extra = @extras.find { |extra| extra.id == params[:id].to_i }
  end

  def update
    @extra.category = extra_params[:category]
    @extra.amount = extra_params[:amount]
  
    if @extra.valid?
      session[:extras][params[:id].to_i] = extra_params
      redirect_to extras_path, success: "更新しました"
    else
      render :edit
    end
  end
  

  def destroy
    session[:extras].delete_at(params[:id].to_i)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to extras_path, success: "削除しました" }
    end
  end

  private

  def set_extra
    @extra = Extra.new(session[:extras][params[:id].to_i].merge(id: params[:id].to_i))
  end

  def extra_params
    params.require(:extra).permit(:category, :amount)
  end
end
