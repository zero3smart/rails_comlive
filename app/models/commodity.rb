class Commodity < ApplicationRecord
  belongs_to :app
  has_many :links
  has_many :references

  validates_presence_of :app, :short_description, :long_description

  scope :generic, -> { where(generic: true )}
  scope :not_generic, -> { where(generic: false )}
end
