class StandardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @standards = Standard.all
  end

  def new
    @standard = Standard.new
  end

  def show
    @standard = Standard.find(params[:id])
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