class Api::V1::AppsController < Api::V1::BaseController

  #before_action :authenticate
  before_action :setuser

  def index
    render json: @current_user.apps
  end

  def show
    render json: App.find(params[:id])
  end

end