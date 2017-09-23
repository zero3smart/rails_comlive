class UnspscSegmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.json { render json: UnspscSegmentDatatable.new(view_context) }
    end
  end
end