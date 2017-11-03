module Visibility
  extend ActiveSupport::Concern

  included do
    enum visibility: [:publicized, :privatized]
  end

  def visibility_status
    visibility == "publicized" ? "Public" : "Private"
  end
end