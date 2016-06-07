class Measurement < ApplicationRecord
  belongs_to :app

  validates_presence_of :app, :property, :value, :uom
end
