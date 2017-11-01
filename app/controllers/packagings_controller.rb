class PackagingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_commodity_reference

  after_action :verify_authorized

  def new
    authorize @app, :show?
    @packaging = Packaging.new
    render layout: !request.xhr?
  end

  def create
    authorize @app, :show?
    @packaging = @commodity_reference.packagings.create(packaging_params)
    if @packaging.save
      redirect_to [@app, @commodity_reference], notice: "Packaging successfully saved"
    else
      render :new
    end
  end

  def show
    authorize @app
    @packaging = @commodity_reference.packagings.find(params[:id])
  end

  def edit
    authorize @app
    @packaging = @commodity_reference.packagings.find(params[:id])
  end

  def update
    authorize @app
    @packaging = @commodity_reference.packagings.find(params[:id])
    if @packaging.update(packaging_params)
      redirect_to  [@app, @commodity_reference], notice: "Packaging successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def set_commodity_reference
    @commodity_reference = @app.commodity_references.find(params[:commodity_reference_id])
  end

  def packaging_params
    params.require(:packaging).permit(:name, :description, :uom, :quantity)
  end
end