require 'rails_helper'

RSpec.describe BarcodeGenerator do
  it "needs a format and content to initialize" do
    expect { BarcodeGenerator.new }.to raise_error(ArgumentError)
  end

  it "raises data no valid error if wrong data" do
    expect{ BarcodeGenerator.new("ean_8", "sdfsdf") }.to raise_error(ArgumentError)
  end

  describe "#generate" do
    it "returns html png string for the barcode" do
      qr_code = BarcodeGenerator.new("qr_code", "https://codeship.com")
      bookland = BarcodeGenerator.new("bookland","978-82-92526-14-9")

      expect(qr_code.generate).to be_a String
      expect(qr_code.generate).to match(/png/)
      expect(bookland.generate).to be_a String
      expect(bookland.generate).to match(/png/)
    end
  end
end
