class StandardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  add_breadcrumb "Standards", :standards_path

  def index
    @standards = Standard.all
  end

  def new
    @standard = Standard.new

    add_breadcrumb "New", new_standard_path
  end

  def show
    if user_signed_in?
      @standard = Standard.where("id = ? or uuid =? ", params[:id], params[:uuid]).first
    else
      authenticate_user! if params[:id]
      @standard = Standard.find_by(uuid: params[:uuid])
    end
    add_breadcrumb @standard.name, @standard
  end

  def create
    @standard = Standard.create(standard_params)
    if @standard.save
      redirect_to [@app,@standard], notice: "Standard successfully created"
    else
      render :new
    end
  end

  def edit
    @standard = Standard.find(params[:id])

    add_breadcrumb @standard.name, @standard
    add_breadcrumb "Edit", edit_standard_path(@standard)
  end

  def update
    @standard = Standard.find(params[:id])
    if @standard.update(standard_params)
      redirect_to [@app,@standard], notice: "Standard successfully updated"
    else
      render :edit
    end
  end

  private

  def standard_params
    params.require(:standard).permit(:name, :description, :logo)
  end
end