class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :last_accessed_app, :record_recent_commodity


  helper_method :current_user, :current_app, :user_signed_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    session[:user_id].present?
  end

  def current_app
    App.find_by(id: params[:app_id] || params[:id])
  end

  def last_accessed_app
    return unless request.get?
    return unless request.path.match(/\/apps\/(\d+)/)
    cookies.permanent[:last_app_id] = request.path.match(/\/apps\/(\d+)/)[1]
  end

  def record_recent_commodity
    return unless request.get?
    return unless request.path.match(/\/apps\/\d+\/commodities\/(\d+)/)
    commodities = cookies.permanent[:recent_commodities] || []
    commodity_id = request.path.match(/\/apps\/\d+\/commodities\/(\d+)/)[1]
    if commodities.empty?
      commodities << commodity_id
    else
      commodities = cookies.permanent[:recent_commodities].split(",")
      commodities.delete(commodity_id) if commodities.include?(commodity_id)
      commodities.unshift(commodity_id)
      commodities.pop if commodities.size > 5
    end
    cookies.permanent[:recent_commodities] = commodities.join(",")
  end

  def authenticate_user!
    redirect_to login_path, alert: "You need to sign in or sign up before continuing." unless session[:user_id].present?
    redirect_to login_path, alert: "You need to sign in or sign up before continuing." unless current_user.present?
  end
end