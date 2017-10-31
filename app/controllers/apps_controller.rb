class AppsController < ApplicationController
  before_action :authenticate_user!

  def index
    @apps = current_user.apps
  end

  def new
    @app = App.new
  end

  def create
    @app = current_user.apps.create(app_params)
    if @app.save
      @app.memberships.find_by(user_id: current_user.id).update(owner: true)
      redirect_to @app, notice: "app created successfully"
    else
      render :new
    end
  end

  def show
    @app = App.find(params[:id])
  end

  def edit
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])
    if @app.update(app_params)
      redirect_to @app, notice: "app updated successfully"
    else
      render :edit
    end
  end

  private

  def app_params
    params.require(:app).permit(:name, :description)
  end
end