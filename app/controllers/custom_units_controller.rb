class CustomUnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def index
    @units = @app.custom_units
  end

  def new
    @unit = CustomUnit.new
  end

  def create
    @unit = @app.custom_units.create(custom_unit_params)
    if @unit.save
      redirect_to [@app, @unit], notice: "Custom unit successfully created"
    else
      render :new
    end
  end

  def show
    @unit = @app.custom_units.find(params[:id])
  end

  def edit
    @unit = @app.custom_units.find(params[:id])
  end

  def update
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
    @app = current_user.apps.find(params[:app_id])
  end
end
