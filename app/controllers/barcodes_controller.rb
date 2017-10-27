class BarcodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_commodity_reference
  before_action :set_parent

  def index
    @barcodes = @parent.barcodes
  end

  def new
    @barcode = Barcode.new
    render layout: !request.xhr?
  end

  def create
    @barcode = @parent.barcodes.create(barcode_params)
    if @barcode.save
      redirect_to parent_url, notice: "Barcode successfully created "
    else
      render :new
    end
  end

  def edit
    @barcode = @parent.barcodes.find(params[:id])
  end

  def update
    @barcode = @parent.barcodes.find(params[:id])
    if @barcode.update(barcode_params)
      redirect_to parent_url, notice: "Barcode successfully updated"
    else
      render :edit
    end
  end

  private

  def set_parent
    filtered = params.select{|p| p =~ /.+_id/ }
    key      = filtered.keys.last
    name,id  = key.match(/(.+)_id$/)[1] ,filtered[key]
    @parent  = name.classify.constantize.find(id)
  end

  def set_app
    return unless params[:app_id]
    @app = App.find(params[:app_id])
  end

  def set_commodity_reference
    return unless params[:app_id]
    @commodity_reference = @app.commodity_references.find(params[:commodity_reference_id])
  end

  def parent_url
    case @parent
      when Packaging
        [@app,@commodity_reference,@parent]
      when Commodity
        @parent
    end
  end

  def barcode_params
    params.require(:barcode).permit(:format, :content)
  end
end