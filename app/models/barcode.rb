class Barcode < ApplicationRecord
  belongs_to :barcodeable, polymorphic: true

  validates_presence_of :format, :content, :barcodeable
  validates_inclusion_of :format, in: BARCODE_FORMATS, message: " is not a valid barcode"
  validates_with BarcodeValidator

  def output
    BarcodeGenerator.new(format, content).generate.html_safe
  end
end