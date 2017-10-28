require 'rails_helper'

RSpec.describe BarcodeGenerator do
  it "needs a barcode to initialize" do
    expect { BarcodeGenerator.new }.to raise_error(ArgumentError)
  end

  it "raises data no valid error if wrong data" do
    barcode = create(:barcode, format: "ean_8", content: "abcdefg")
    expect{ BarcodeGenerator.new( barcode ) }.to raise_error(ArgumentError)
  end

  describe "#generate" do
    it "returns html table string for the barcode" do
      barcode = create(:barcode, format: "ean_8", content: "1234567")
      generator = BarcodeGenerator.new( barcode )
      expect(generator.generate).to be_a String
      expect(generator.generate).to match(/table/)
    end
  end
end