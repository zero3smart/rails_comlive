module Api::V1
  class ApiController < ApplicationController
    include Knock::Authenticable

    before_action :authenticate

    private

    def render_error(error, status)
      render json: error, status: status, adapter: :json_api,
             serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end
end