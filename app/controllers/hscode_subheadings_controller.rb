class HscodeSubheadingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hscode_heading

  def index
    @hscode_subheadings = @hscode_heading.hscode_subheadings
    render json: @hscode_subheadings, only: [:id,:description]
  end

  private

  def set_hscode_heading
    @hscode_heading= HscodeHeading.find(params[:hscode_heading_id])
  end
end