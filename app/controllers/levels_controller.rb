class LevelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_classification

  def index
    if params[:node]
      @levels = @classification.levels.find(params[:node]).children
    else
      @levels = @classification.levels.root
    end
    respond_to do |format|
      format.json { render json: json_for(@levels) }
      format.html
    end
  end

  def new
    @level = Level.new
  end

  def create
    @level = @classification.levels.new(level_params)
    @level.added_by = @app
    if @level.save
      redirect_to [@app, @classification], notice: "Level successfully added"
    else
      render :new
    end
  end

  def show
    @level = @classification.levels.find(params[:id])
  end

  def edit
    @level = @classification.levels.find(params[:id])
  end

  def update
    @level = @classification.levels.find(params[:id])
    if @level.update(level_params)
      redirect_to  [@app, @classification], notice: "Level successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def set_classification
    @classification = @app.classifications.find(params[:classification_id])
  end

  def level_params
    params.require(:level).permit(:name,:position,:needs_moderation, :parent_id)
  end

  def json_for(levels)
    levels.map do |level|
      {
          label: level.name,
          id: level.id,
          load_on_demand: level.children.count > 0
      }
    end
  end
end