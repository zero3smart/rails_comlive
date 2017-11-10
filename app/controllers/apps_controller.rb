class AppsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index

  add_breadcrumb "Apps", :apps_path

  def index
    @apps = current_user.apps
  end

  def new
    @app = App.new
    authorize App

    add_breadcrumb "New", :new_app_path
  end

  def create
    authorize App
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
    authorize @app

    add_breadcrumb @app.name, @app
  end

  def edit
    @app = App.find(params[:id])
    authorize @app

    add_breadcrumb @app.name, @app
    add_breadcrumb "Edit", edit_app_path(@app)
  end

  def update
    @app = App.find(params[:id])
    authorize @app
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