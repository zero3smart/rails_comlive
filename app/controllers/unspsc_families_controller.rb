class UnspscFamiliesController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.json { render json: UnspscFamilyDatatable.new(view_context) }
    end
  end
end