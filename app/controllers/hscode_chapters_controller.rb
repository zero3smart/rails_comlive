class HscodeChaptersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hscode_section

  def index
    @hscode_chapters = @hscode_section.hscode_chapters
    render json: @hscode_chapters, only: [:id,:description]
  end

  private

  def set_hscode_section
    @hscode_section = HscodeSection.find(params[:hscode_section_id])
  end
end