module Api::V1
  class CommoditiesController < ApiController

    def index
      render_error("can not list all commodities", 400)
    end

    def show

    end
  end
end