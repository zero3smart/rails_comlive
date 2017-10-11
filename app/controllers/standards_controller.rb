class StandardsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_app

  def index
    @standards = @app.standards
  end

  def new
    @standard = Standard.new
  end

  def show
    @standard = @app.standards.find(params[:id])
  end

  def create
    @standard = @app.standards.create(standard_params)
    if @standard.save
      redirect_to [@app,@standard], notice: "Standard successfully created"
    else
      render :new
    end
  end

  def edit
    @standard = @app.standards.find(params[:id])
  end

  def update
    @standard = @app.standards.find(params[:id])
    if @standard.update(standard_params)
      redirect_to [@app,@standard], notice: "Standard successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def standard_params
    params.require(:standard).permit(:name, :description, :logo)
  end
end