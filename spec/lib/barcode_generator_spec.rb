require 'rails_helper'

RSpec.describe BarcodeGenerator do
  it "needs a format and content to initialize" do
    expect { BarcodeGenerator.new }.to raise_error(ArgumentError)
  end

  it "raises data no valid error if wrong data" do
    expect{ BarcodeGenerator.new("ean_8", "sdfsdf") }.to raise_error(ArgumentError)
  end

  describe "#generate" do
    context "If format is of qr type" do
      it "returns html png string for the barcode" do
        generator = BarcodeGenerator.new("qr_code", "https://codeship.com")
        expect(generator.generate).to be_a String
        expect(generator.generate).to match(/png/)
      end
    end

    context "If format is not of qr type" do
      it "returns html table string for the barcode" do
        generator = BarcodeGenerator.new("ean_8", "1234567")
        expect(generator.generate).to be_a String
        expect(generator.generate).to match(/table/)
      end
    end
  end
end