class SpecificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_parent

  after_action :verify_authorized

  def index
    authorize @app, :show?
    @specifications = @parent.specifications
  end

  def new
    authorize @app, :show?
    @specification = Specification.new
  end

  def create
    authorize @app, :show?
    @specification = @parent.specifications.create(specification_params)
    if @specification.save
      redirect_to parent_url, notice: "Specification successfully created"
    else
      render :new
    end
  end

  def show
    authorize @app
    @specification = @parent.specifications.find(params[:id])
  end


  def edit
    authorize @app
    @specification = @parent.specifications.find(params[:id])
  end

  def update
    authorize @app
    @specification = @parent.specifications.find(params[:id])
    if @specification.update(specification_params)
      redirect_to parent_url, notice: "Specification updated successfully"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def set_parent
    filtered = params.select{|p| p =~ /.+_id/ }
    key      = filtered.keys.last
    name,id  = key.match(/(.+)_id$/)[1] ,filtered[key]
    @parent  = name.classify.constantize.find(id)
  end

  def parent_url
    model = @parent
    case model
      when CommodityReference
        [model.app, model]
      when Packaging
        [model.commodity_reference.app, model.commodity_reference, model]
    end
  end

  def specification_params
    params.require(:specification).permit(:property,:value, :uom, :min, :max, :visibility)
  end
end