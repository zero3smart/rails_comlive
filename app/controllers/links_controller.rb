class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  after_action :verify_authorized

  add_breadcrumb "Apps", :apps_path

  def new
    authorize @app, :show?
    @link = Link.new

    add_breadcrumb @app.name, @app
    add_breadcrumb "Links", app_links_path(@app)
    add_breadcrumb "New", new_app_link_path(@app)
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

    add_breadcrumb @app.name, @app
    add_breadcrumb "Links", app_links_path(@app)
    add_breadcrumb "Edit", edit_app_link_path(@app, @link)
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
    params.require(:link).permit(:url,:description, :commodity_reference_id, :visibility)
  end
end