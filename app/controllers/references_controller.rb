class ReferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

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
    add_breadcrumb "References", app_references_path(@app)
    add_breadcrumb "New", new_app_reference_path(@app)
  end

  def show
    authorize @app
    @reference = @app.references.find(params[:id])

    add_breadcrumb @app.name, @app
    add_breadcrumb "References", app_references_path(@app)
    add_breadcrumb "##{@reference.id}", new_app_reference_path(@app)
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
    params.require(:reference).permit(:kind, :source_commodity_reference_id, :target_commodity_reference_id,
                                      :description, :visibility)
  end
end