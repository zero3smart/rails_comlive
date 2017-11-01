class CustomUnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def index
    authorize @app, :show?
    @units = @app.custom_units
  end

  def new
    authorize @app, :show?
    @unit = CustomUnit.new
  end

  def create
    authorize @app, :show?
    @unit = @app.custom_units.create(custom_unit_params)
    if @unit.save
      redirect_to [@app, @unit], notice: "Custom unit successfully created"
    else
      render :new
    end
  end

  def show
    authorize @app
    @unit = @app.custom_units.find(params[:id])
  end

  def edit
    authorize @app
    @unit = @app.custom_units.find(params[:id])
  end

  def update
    authorize @app
    @unit = @app.custom_units.find(params[:id])
    if @unit.update(custom_unit_params)
      redirect_to [@app, @unit], notice: "Unit successfully updated"
    else
      render :edit
    end
  end

  private

  def custom_unit_params
    params.require(:custom_unit).permit(:property, :uom)
  end

  def set_app
    @app = App.find(params[:app_id])
  end
end