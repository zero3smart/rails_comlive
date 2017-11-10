class BrandsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  add_breadcrumb "Brands", :brands_path

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new

    add_breadcrumb "New", :new_brand_path
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
    if user_signed_in?
      @brand = Brand.find_by(id: params[:id])
      @standardization = Standardization.new
    else
      authenticate_user! if params[:id]
      @brand = Brand.find_by(uuid: params[:uuid])
    end

    add_breadcrumb @brand.name, @brand
  end

  def edit
    @brand = Brand.find(params[:id])

    add_breadcrumb @brand.name, @brand
    add_breadcrumb "Edit", edit_brand_path(@brand)
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