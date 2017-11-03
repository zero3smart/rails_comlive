class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def new
    @link = Link.new
    render layout: !request.xhr?
  end

  def create
    @link = @app.links.create(link_params)
    if @link.save
      redirect_to [@app,@link.commodity_reference], notice: "link successfully created"
    else
      render :new
    end
  end

  def edit
    @link = @app.links.find(params[:id])
  end

  def update
    @link = @app.links.find(params[:id])
    if @link.update(link_params)
      redirect_to [@app, @link.commodity_reference], notice: "link successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end

  def link_params
    params.require(:link).permit(:url,:description, :commodity_reference_id, :visibility)
  end
end