module Api::V1
  class CommoditiesController < ApiController

    # skeleton for commodities. should be revised
    def index
      @commodities = Commodity.all
      render json: @commodities
    end

    def show
      @commodity = Commodity.find(params[:id])
      render json: @commodity
    end
  end
end