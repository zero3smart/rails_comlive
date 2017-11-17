class ClassificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app

  def index
    @classifications = @app.classifications
  end

  def new
    @classification = Classification.new
  end

  def create
    @classification = @app.classifications.new(classification_params)
    @classification.moderator = current_user
    if @classification.save
      redirect_to [@app, @classification], notice: "Classification successfully created"
    else
      render :new
    end
  end

  def show
    @classification = @app.classifications.find(params[:id])
  end

  def edit
    @classification = @app.classifications.find(params[:id])
  end

  def update
    @classification = @app.classifications.find(params[:id])
    if @classification.update(classification_params)
      redirect_to [@app, @classification], notice: "Classification successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def classification_params
    params.require(:classification).permit(:name, :description, :visibility)
  end
end