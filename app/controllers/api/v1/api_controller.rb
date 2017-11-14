module Api::V1
  class ApiController < ApplicationController
    include Knock::Authenticable

    before_action :authenticate

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
      render json: { error: "Record not found" }, status: :not_found
    end

    def render_error(error, status)
      render json: error, status: status, adapter: :json_api,
             serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end
end