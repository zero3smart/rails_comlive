class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  after_action :verify_authorized

  def new
    authorize @app, :show?
    @link = Link.new
    render layout: !request.xhr?
  end

  def create
    authorize @app, :show?
    @link = @app.links.create(link_params)
    if @link.save
      redirect_to [@app,@link.commodity_reference], notice: "link successfully created"
    else
      render :new
    end
  end

  def edit
    authorize @app
    @link = @app.links.find(params[:id])
  end

  def update
    authorize @app
    @link = @app.links.find(params[:id])
    if @link.update(link_params)
      redirect_to [@app, @link.commodity_reference], notice: "link successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def link_params
    params.require(:link).permit(:url,:description, :commodity_reference_id)
  end
end