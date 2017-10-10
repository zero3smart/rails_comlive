class BrandsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_app

  def index
    @brands = @app.brands
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = @app.brands.create(brand_params)
    if @brand.save
      redirect_to [@app, @brand], notice: "Brand Successfully created"
    else
      render :new
    end
  end

  def show
    @brand = @app.brands.find(params[:id])
    @standardization = Standardization.new
  end

  def edit
    @brand = @app.brands.find(params[:id])
  end

  def update
    @brand = @app.brands.find(params[:id])
    if @brand.update(brand_params)
      redirect_to [@app,@brand], notice: "brand successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def brand_params
    params.require(:brand).permit(:name, :logo, :description)
  end
end