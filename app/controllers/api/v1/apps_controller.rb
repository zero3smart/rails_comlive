module Api::V1
  class AppsController < ApiController

    def index
      render json: @current_user.apps
    end

    def show
      app = App.find(params[:id])
      begin
        render json: App.find(params[:id])
        catch()
        render_error("can not find app", 404)
      end
    end

  end
end