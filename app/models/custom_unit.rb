class CustomUnit < ApplicationRecord
  belongs_to :app

  validates_presence_of :app, :property, :uom
end
