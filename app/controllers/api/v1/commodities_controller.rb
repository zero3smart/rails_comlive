class Api::V1::CommoditiesController < Api::V1::BaseController

  #before_action :authenticate
  before_action :setuser

  def index
    render_error("can not list all commodities", 400)
  end

  def show

  end

end