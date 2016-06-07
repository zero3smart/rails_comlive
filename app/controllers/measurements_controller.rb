class MeasurementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def index
    @measurements = @app.measurements
  end

  def new
    @measurement = Measurement.new
  end

  def create
    @measurement = @app.measurements.create(measurement_params)
    if @measurement.save
      redirect_to [@app,@measurement], notice: "Measurement successfully created"
    else
      render :new
    end
  end

  def show
    @measurement = @app.measurements.find(params[:id])
  end


  def edit
    @measurement = @app.measurements.find(params[:id])
  end

  def update
    @measurement = @app.measurements.find(params[:id])
    if @measurement.update(measurement_params)
      redirect_to [@app, @measurement], notice: "Measurement updated successfully"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end

  def measurement_params
    params.require(:measurement).permit(:property,:value, :uom)
  end

end
