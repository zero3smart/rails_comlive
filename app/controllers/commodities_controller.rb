class CommoditiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :autocomplete, :prefetch]

  def index
    add_breadcrumb "Commodities", :commodities_path

    if params[:q]
      generic = params[:generic] == "true"
      @commodities = Commodity.search params[:q], where: { generic: generic }, page: params[:page], per_page: 10
      render json: response_for(@commodities)
    elsif params[:query]
      @commodities = Commodity.search(params[:query], operator: "or", match: :word_start,
                                      fields: ["name^10", "short_description", "long_description"]).records.recent.page(params[:page]).per_page(10)
    else
      @recent_commodities = Commodity.recent.limit(5)
    end
  end

  def show
    if user_signed_in?
      @commodity = Commodity.find_by(id: params[:id])
    else
      authenticate_user! if params[:id]
      @commodity = Commodity.find_by(uuid: params[:uuid])
    end

    add_breadcrumb "Commodities", :commodities_path
    add_breadcrumb @commodity.name, @commodity
  end

  def new
    @commodity = Commodity.new

    add_breadcrumb "Commodities", :commodities_path
    add_breadcrumb "New", new_commodity_path
  end

  def create
    @commodity = Commodity.create(commodity_params)
    if @commodity.save
      commodity_ref = @commodity.create_reference(current_user)
      redirect_to [commodity_ref.app,commodity_ref], notice: "commodity successfully created"
    else
      render :new
    end
  end

  def edit
    @commodity = Commodity.find(params[:id])
  end

  def update
    @commodity = Commodity.find(params[:id])
    if @commodity.update(commodity_params)
      redirect_to [@app,@commodity], notice: "commodity successfully updated"
    else
      render :edit
    end
  end

  def autocomplete
    @commodities =  Commodity.search(params[:query], limit: 10)
    response = @commodities.each_with_object([]) do |commodity,arr|
      arr << { id: commodity.id, name: commodity.name, href: slugged_commodity_path(commodity.uuid,commodity.name.parameterize)}
    end
    render json: response
  end

  def prefetch
    @commodities =  Commodity.page(params[:page])
    response = @commodities.each_with_object([]) do |commodity,arr|
      arr << { id: commodity.id, name: commodity.name, href: slugged_commodity_path(commodity.uuid,commodity.name.parameterize)}
    end
    render json: response
  end

  private

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