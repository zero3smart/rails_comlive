class Packaging < ApplicationRecord
  include Visibility
  include Uuideable

  belongs_to :commodity_reference
  has_many :specifications, as: :parent
  has_many :barcodes, as: :barcodeable

  validates_presence_of :uom, :quantity, :name, :description, :commodity_reference

  def app
    @app ||= commodity_reference.app
  end
end
