module Visibility
  extend ActiveSupport::Concern

  included do
    enum visibility: [:publicized, :privatized, :official]
  end

  def visibility_status
    case visibility
      when "publicized"
        "Public"
      when "privatized"
        "Private"
      else
        "Official"
    end
  end
end
