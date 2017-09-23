class CommoditiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def index
    @commodities = @app.commodities
  end

  def show
    @commodity = @app.commodities.find(params[:id])
    @packaging = Packaging.new
    @state = @commodity.state ? @commodity.state : State.new
    @standardization = Standardization.new
  end

  def new
    @commodity = Commodity.new
  end

  def create
    @commodity = @app.commodities.create(commodity_params)
    if @commodity.save
      redirect_to [@app,@commodity], notice: "commodity successfully created"
    else
      render :new
    end
  end

  def edit
    @commodity = @app.commodities.find(params[:id])
  end

  def update
    @commodity = @app.commodities.find(params[:id])
    if @commodity.update(commodity_params)
      redirect_to [@app,@commodity], notice: "commodity successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end

  def commodity_params
    params.require(:commodity).permit(:short_description, :long_description, :generic, :brand_id, :measured_in,
                                      :hscode_section_id, :hscode_chapter_id, :hscode_heading_id, :hscode_subheading_id,
                                      :unspsc_commodity_id)
  end
end