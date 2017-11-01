class ReferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  after_action :verify_authorized

  def index
    authorize @app, :show?
    @references = @app.references
  end

  def new
    authorize @app, :show?
    @reference = Reference.new
    render layout: !request.xhr?
  end

  def show
    authorize @app
    @reference = @app.references.find(params[:id])
  end

  def create
    authorize @app, :show?
    @reference = @app.references.create(reference_params)
    if @reference.save
      redirect_to [@app, @reference], notice: "reference successfully created"
    else
      render :new
    end
  end

  def edit
    authorize @app
    @reference = @app.references.find(params[:id])
  end

  def update
    authorize @app
    @reference = @app.references.find(params[:id])
    if @reference.update(reference_params)
      redirect_to [@app, @reference], notice: "reference successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def reference_params
    params.require(:reference).permit(:kind, :source_commodity_reference_id, :target_commodity_reference_id, :description)
  end
end