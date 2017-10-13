class BrandsController < ApplicationController
  before_action :authenticate_user!

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.create(brand_params)
    if @brand.save
      redirect_to @brand, notice: "Brand Successfully created"
    else
      render :new
    end
  end

  def show
    @brand = Brand.find(params[:id])
    @standardization = Standardization.new
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      redirect_to @brand, notice: "brand successfully updated"
    else
      render :edit
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :logo, :description)
  end
end