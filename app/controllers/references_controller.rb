class ReferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_commodity_reference

  after_action :verify_authorized

  add_breadcrumb "Apps", :apps_path

  def index
    authorize @app, :show?
    @references = @app.references
  end

  def new
    authorize @app, :show?
    @reference = Reference.new

    add_breadcrumb @app.name, @app
    add_breadcrumb "References", app_commodity_reference_references_path(@app, @commodity_reference)
    add_breadcrumb "New", new_app_commodity_reference_reference_path(@app,  @commodity_reference)
  end

  def show
    authorize @app
    @reference = @commodity_reference.references.find(params[:id])

    add_breadcrumb @app.name, @app
    add_breadcrumb "References", app_commodity_reference_references_path(@app, @commodity_reference)
    add_breadcrumb "##{@reference.id}", new_app_commodity_reference_reference_path(@app,  @commodity_reference)
  end

  def create
    authorize @app, :show?
    @reference = @commodity_reference.references.new(reference_params)
    @reference.app_id = @app.id
    if @reference.save
      redirect_to @commodity_reference.commodity, notice: "reference successfully created"
    else
      render :new
    end
  end

  def edit
    authorize @app
    @reference = @commodity_reference.references.find(params[:id])
  end

  def update
    authorize @app
    @reference = @commodity_reference.references.find(params[:id])
    if @reference.update(reference_params)
      redirect_to @commodity_reference.commodity, notice: "reference successfully updated"
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

  def reference_params
    params.require(:reference).permit(:kind, :source_commodity_id, :target_commodity_id, :description, :visibility)
  end
end