class Api::V1::UsersController < Api::V1::BaseController

  #before_action :authenticate
  before_action :setuser

  def index
    render json: { errors: "cannot list all users" }, status: :forbidden
  end

  def show
    render json: current_user
  end

end