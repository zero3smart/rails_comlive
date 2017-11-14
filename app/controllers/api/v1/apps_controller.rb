module Api::V1
  class AppsController < ApiController

    def index
      render json: @current_user.apps
    end

    def show
      @app = @current_user.apps.find(params[:id])
      render json: @app
    end
  end
end