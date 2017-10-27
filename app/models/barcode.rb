class Barcode < ApplicationRecord
  belongs_to :barcodeable, polymorphic: true

  validates_presence_of :format, :content, :barcodeable
  validates_inclusion_of :format, in: BARCODE_FORMATS, message: " is not a valid barcode"

  def html_output
    begin
      generator = BarcodeGenerator.new(self)
      generator.generate.html_safe
    rescue Exception => e
      e.message
    end
  end
end