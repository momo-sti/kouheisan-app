class ExtrasController < ApplicationController
  before_action :set_extra, only: [:edit, :update, :destroy]
  before_action :calculate_total_amount, only: [:index]
  before_action :add_id_to_extras, only: [:index]

  def index
    # extra.amountを数値に変換
    extras_sum = @extras.sum { |extra| extra.amount.to_f }
    # 金額を合算
    @total_amount = @result + @highway_cost + extras_sum
    session[:total_amount] = @total_amount

    @extra = Extra.new
  end

  def create
    @extra = Extra.new(extra_params)
    if @extra.valid?
      session[:extras] ||= []
      session[:extras] << extra_params.merge(uuid: SecureRandom.uuid)
      redirect_to extras_path
    else
      render :new
    end
  end

  def update
    @extra.category = extra_params[:category]
    @extra.amount = extra_params[:amount].to_i

    respond_to do |format|
      if @extra.valid?
        session[:extras][params[:id].to_i] = extra_params.merge(uuid: @extra.uuid, amount: @extra.amount)
        @extras = session[:extras].map.with_index { |extra, i| Extra.new(extra.merge(id: i)) }

        calculate_total_amount

        format.html { redirect_to extras_path }
        format.turbo_stream
      else
        @extras = session[:extras].map.with_index { |extra, i| Extra.new(extra.merge(id: i)) }
        format.turbo_stream do
          render :edit
        end
      end
    end
  end

  def destroy
    session[:extras].delete_at(params[:id].to_i)

    redirect_to extras_path
  end

  private

  def set_extra
    @extra = Extra.new(session[:extras][params[:id].to_i].merge(id: params[:id].to_i))
  end

  def extra_params
    params.require(:extra).permit(:category, :amount)
  end

  def add_id_to_extras
    @extras = session[:extras]&.map&.with_index do |extra, i|
      # 既存の UUID が存在しなければ新たに生成
      extra['uuid'] ||= SecureRandom.uuid
      Extra.new(extra.merge(id: i))
    end || []
  end
end
