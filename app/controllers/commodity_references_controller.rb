class CommodityReferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def index
    if params[:q]
      generic = params[:generic] == "true"
      @commodity_references = CommodityReference.search params[:q], where: { generic: generic }, page: params[:page], per_page: 10
      render json: response_for(@commodity_references)
    elsif params[:query]
      @commodity_references = CommodityReference.search(params[:query], operator: "or", match: :word_start,
                                      fields: ["name^10", "short_description", "long_description"]).records.recent.page(params[:page]).per_page(10)
    else
      @recent_commodity_references = @app.commodity_references.recent.limit(5)
    end
  end

  def show
    @commodity_reference = @app.commodity_references.find(params[:id])
    @packaging = Packaging.new
    @state = @commodity_reference.state ? @commodity_reference.state : State.new
    @standardization = Standardization.new
  end

  def new
    @commodity_reference = CommodityReference.new
  end

  def create
    @commodity_reference = @app.commodity_references.create(commodity_reference_params)
    if @commodity_reference.save
      redirect_to [@app,@commodity_reference], notice: "commodity successfully created"
    else
      render :new
    end
  end

  def edit
    @commodity_reference = @app.commodity_references.find(params[:id])
  end

  def update
    @commodity_reference = @app.commodity_references.find(params[:id])
    if @commodity_reference.update(commodity_reference_params)
      redirect_to [@app,@commodity_reference], notice: "commodity successfully updated"
    else
      render :edit
    end
  end

  def autocomplete
    render json: CommodityReference.search(params[:query], limit: 10)
  end

  def prefetch
    render json: CommodityReference.page(params[:page])
  end

  private

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end

  def response_for(commodities)
    response = {}
    response[:total_count]  = @commodity_references.total_entries
    response[:current_page] = @commodity_references.current_page.to_i
    response[:last_page]    = @commodity_references.total_pages == @commodity_references.current_page
    response[:items]        = []
    commodities.each {|c| response[:items] << c }
    return response
  end

  def commodity_reference_params
    params.require(:commodity_reference).permit(:name, :short_description, :long_description, :generic, :brand_id, :measured_in,
                                      :hscode_section_id, :hscode_chapter_id, :hscode_heading_id, :hscode_subheading_id,
                                      :unspsc_commodity_id)
  end
end