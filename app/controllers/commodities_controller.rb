class CommoditiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def index
    if params[:q]
      generic = params[:generic] == "true"
      @commodities = Commodity.search params[:q], where: { generic: generic }, page: params[:page], per_page: 10
      render json: response_for(@commodities)
    elsif params[:query]
      @commodities = Commodity.search(params[:query], operator: "or", match: :word_start,
                                      fields: ["name^10", "short_description", "long_description"]).records.recent.page(params[:page]).per_page(10)
    else
      @recent_commodities = @app.commodities.recent.limit(5)
    end
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

  def autocomplete
    render json: Commodity.search(params[:query], limit: 10)
  end

  def prefetch
    render json: Commodity.page(params[:page])
  end

  private

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end

  def response_for(commodities)
    response = {}
    response[:total_count]  = @commodities.total_entries
    response[:current_page] = @commodities.current_page.to_i
    response[:last_page]    = @commodities.total_pages == @commodities.current_page
    response[:items]        = []
    commodities.each {|c| response[:items] << c }
    return response
  end

  def commodity_params
    params.require(:commodity).permit(:name, :short_description, :long_description, :generic, :brand_id, :measured_in,
                                      :hscode_section_id, :hscode_chapter_id, :hscode_heading_id, :hscode_subheading_id,
                                      :unspsc_commodity_id)
  end
end