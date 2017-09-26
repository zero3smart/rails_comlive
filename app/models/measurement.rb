class Measurement < ApplicationRecord
  belongs_to :commodity

  validates_presence_of :property, :value, :uom
end