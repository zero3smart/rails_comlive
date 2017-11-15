class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :last_accessed_app, :record_recent_commodity

  helper_method :current_user, :current_app, :user_signed_in?, :commodity_url

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  add_breadcrumb "Home", :root_path

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end

  def current_app
    return current_user.default_app unless cookies[:last_app_id]
    App.find(cookies[:last_app_id])
    # return @current_app if defined?(@current_app)
    # @current_app ||= begin
    #   app = App.find(cookies[:last_app_id]) if cookies[:last_app_id]
    #   app = current_user.default_app if current_user
    # end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def last_accessed_app
    return unless request.get?
    return unless request.path.match(/\/apps\/(\d+)/)
    cookies.permanent[:last_app_id] = request.path.match(/\/apps\/(\d+)/)[1]
  end

  def record_recent_commodity
    return unless request.get?
    return unless request.path.match(/\/commodities\/(\d+)/)
    commodities = cookies.permanent[:recent_commodities] || []
    commodity_id = request.path.match(/\/commodities\/(\d+)/)[1]
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

  def commodity_url(commodity)
    return commodity_path(commodity) if user_signed_in?
    slugged_commodity_path(commodity.uuid, commodity.name.parameterize)
  end

  def authenticate_user!
    redirect_to login_path, alert: "You need to sign in or sign up before continuing." unless current_user.present?
  end
end