class Image < ApplicationRecord
  belongs_to :commodity_reference

  validates_presence_of :commodity_reference_id, :url

  def handle
    url.split("/").last
  end
end
