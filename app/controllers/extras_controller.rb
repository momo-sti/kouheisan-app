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
    #一意のIDを追加
    @extras = session[:extras]&.map&.with_index { |extra, i| Extra.new(extra.merge(id: i)) } || []
  end

  def new
    @extra = Extra.new
  end

  def create
    @extra = Extra.new(extra_params)
    respond_to do |format|
      if @extra.valid?
        session[:extras] ||= []
        session[:extras] << extra_params
        format.html { redirect_to extras_path, success: "登録しました" }
        format.turbo_stream { redirect_to extras_path, success: "登録しました" }
      else
        format.html { render :new }
        format.turbo_stream do
          render :new
        end
      end
    end
  end

  

  def edit
    @extras = session[:extras].map.with_index { |extra, i| Extra.new(extra.merge(id: i)) }
    @extra = @extras.find { |extra| extra.id == params[:id].to_i }
  end

  def update
    @extra.category = extra_params[:category]
    @extra.amount = extra_params[:amount]
  
    respond_to do |format|
      if @extra.valid?
        session[:extras][params[:id].to_i] = extra_params
        format.html { redirect_to extras_path, success: "更新しました" }
        format.turbo_stream
      else
        @extras = session[:extras].map.with_index { |extra, i| Extra.new(extra.merge(id: i)) }
        format.html { render :edit }
        format.turbo_stream do
          render :edit
        end
      end
    end
  end
  
  

  def destroy
    session[:extras].delete_at(params[:id].to_i)
    
    redirect_to extras_path, success: "削除しました"
  end
  

  private

  def set_extra
    @extra = Extra.new(session[:extras][params[:id].to_i].merge(id: params[:id].to_i))
  end

  def extra_params
    params.require(:extra).permit(:category, :amount)
  end
end
