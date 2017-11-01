class StatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_commodity_reference

  after_action :verify_authorized

  def new
    authorize @app, :show?
    @state = State.new
    render layout: !request.xhr?
  end

  def create
    authorize @app, :show?
    @state = @commodity_reference.create_state(state_params)
    if @state.save
      redirect_to [@app,@commodity_reference], notice: "State successfully created"
    else
      render :new
    end
  end

  def edit
    authorize @app
    @state = @commodity_reference.state
  end

  def update
    authorize @app
    @state = @commodity_reference.state
    if @state.update(state_params)
      redirect_to [@app,@commodity_reference], notice: "State successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def set_commodity_reference
    @commodity_reference = @app.commodity_references.find(params[:commodity_reference_id])
  end

  def state_params
    params.require(:state).permit(:status,:info,:url)
  end
end