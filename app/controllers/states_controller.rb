class StatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app
  before_action :set_commodity

  def new
    @state = State.new
  end

  def create
    @state = @commodity.create_state(state_params)
    if @state.save
      redirect_to [@app,@commodity], notice: "State successfully created"
    else
      render :new
    end
  end

  def edit
    @state = @commodity.state
  end

  def update
    @state = @commodity.state
    if @state.update(state_params)
      redirect_to [@app,@commodity], notice: "State successfully updated"
    else
      render :edit
    end
  end

  private

  def set_app
    @app = App.find(params[:app_id])
  end

  def set_commodity
    @commodity = @app.commodities.find(params[:commodity_id])
  end

  def state_params
    params.require(:state).permit(:status,:info,:url)
  end
end