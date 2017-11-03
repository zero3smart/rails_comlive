class Link < ApplicationRecord
  include Visibility

  belongs_to :app
  belongs_to :commodity_reference

  validates_presence_of :url, :description, :app, :commodity_reference
  validates :url, url: true
end