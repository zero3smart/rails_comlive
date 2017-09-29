class Specification < ApplicationRecord
  belongs_to :commodity

  validates_presence_of :property, :value, :uom, :commodity
end