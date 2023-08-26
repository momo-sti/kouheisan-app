class ApplicationController < ActionController::Base
  after_action :store_location
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from Exception, with: :render_internal_server_error

  def render_not_found(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render template: 'errors/error_404', status: 404, layout: 'application'
  end

  def render_internal_server_error(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render template: 'errors/error_500', status: 500, layout: 'application'
  end

  def store_location
    if request.fullpath != new_user_registration_path &&
       request.fullpath != new_user_session_path &&
       request.fullpath !~ Regexp.new('\\A/users/password.*\\z') &&
       !request.xhr?

      session[:third_last_url] = session[:second_last_url]
      session[:second_last_url] = session[:previous_url]
      session[:previous_url] = request.fullpath
    end
  end

  # ログイン後に直前のページに戻る
  def after_sign_in_path_for(resource)
    case session[:second_last_url]
    when '/costs/save_per_person_cost'
      '/extras'
    when '/'
      root_path
    when '/gasolines/new'
      '/gasolines/new'
    when '/highways/highway'
      '/highways/highway'
    else
      session[:second_last_url] || super
    end
  end

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
