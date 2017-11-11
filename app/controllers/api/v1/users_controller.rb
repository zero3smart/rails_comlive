module Api::V1
  class UsersController < ApiController

    def index
      render json: { errors: "cannot list all users" }, status: :forbidden
    end

    def show
      render json: @current_user
    end

  end
end