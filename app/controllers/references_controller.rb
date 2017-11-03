class ReferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def index
    @references = @app.references
  end

  def new
    @reference = Reference.new
    render layout: !request.xhr?
  end

  def show
    @reference = @app.references.find(params[:id])
  end

  def create
    @reference = @app.references.create(reference_params)
    if @reference.save
      redirect_to [@app, @reference], notice: "reference successfully created"
    else
      render :new
    end
  end

  def edit
    @reference = @app.references.find(params[:id])
  end

  def update
    @reference = @app.references.find(params[:id])
    if @reference.update(reference_params)
      redirect_to [@app, @reference], notice: "reference successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end

  def reference_params
    params.require(:reference).permit(:kind, :source_commodity_reference_id, :target_commodity_reference_id,
                                      :description, :visibility)
  end
end