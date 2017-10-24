class HscodeHeadingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hscode_chapter

  def index
    @hscode_headings = @hscode_chapter.hscode_headings
    render json: @hscode_headings, only: [:id,:description]
  end

  private

  def set_hscode_chapter
    @hscode_chapter = HscodeChapter.find(params[:hscode_chapter_id])
  end
end