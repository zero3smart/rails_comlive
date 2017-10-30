class Api::V1::BaseController < ApplicationController
  include Knock::Authenticable

  private

  def setuser
    @current_user = User.find(1)
  end

  def setapp
    current_app = current
  end

  #def allapps
  #  current_user.apps
  #end

  def render_error(error, status)
    render json: error, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end

end