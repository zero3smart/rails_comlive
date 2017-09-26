class MeasurementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_commodity

  def index
    @measurements = @commodity.measurements
  end

  def new
    @measurement = Measurement.new
    render layout: !request.xhr?
  end

  def create
    @measurement = @commodity.measurements.create(measurement_params)
    if @measurement.save
      redirect_to [@app,@commodity], notice: "Measurement successfully created"
    else
      render :new
    end
  end

  def show
    @measurement = @commodity.measurements.find(params[:id])
  end


  def edit
    @measurement = @commodity.measurements.find(params[:id])
  end

  def update
    @measurement = @commodity.measurements.find(params[:id])
    if @measurement.update(measurement_params)
      redirect_to [@app, @commodity], notice: "Measurement updated successfully"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end

  def set_commodity
    @commodity = @app.commodities.find(params[:commodity_id])
  end

  def measurement_params
    params.require(:measurement).permit(:property,:value, :uom)
  end
end