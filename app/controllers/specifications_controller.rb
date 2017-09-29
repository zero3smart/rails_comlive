class SpecificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_commodity

  def index
    @specifications = @commodity.specifications
  end

  def new
    @specification = Specification.new
    render layout: !request.xhr?
  end

  def create
    @specification = @commodity.specifications.create(specification_params)
    if @specification.save
      redirect_to [@app,@commodity], notice: "Specification successfully created"
    else
      render :new
    end
  end

  def show
    @specification = @commodity.specifications.find(params[:id])
  end


  def edit
    @specification = @commodity.specifications.find(params[:id])
  end

  def update
    @specification = @commodity.specifications.find(params[:id])
    if @specification.update(specification_params)
      redirect_to [@app, @commodity], notice: "Specification updated successfully"
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

  def specification_params
    params.require(:specification).permit(:property,:value, :uom)
  end
end