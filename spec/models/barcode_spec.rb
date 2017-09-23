require 'rails_helper'

RSpec.describe Barcode, :type => :model do
  describe "Validation" do
    it "has a valid factory" do
      barcode = build(:barcode)
      expect(barcode).to be_valid
    end

    it "is invalid without a name" do
      barcode = build(:barcode, name: nil)
      barcode.valid?
      expect(barcode.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a format" do
      barcode = build(:barcode, format: nil)
      barcode.valid?
      expect(barcode.errors[:format]).to include("can't be blank")
    end

    it "is invalid without content" do
      barcode = build(:barcode, content: nil)
      barcode.valid?
      expect(barcode.errors[:content]).to include("can't be blank")
    end

    it "is invalid without a barcodeable" do
      barcode = build(:barcode, barcodeable: nil)
      barcode.valid?
      expect(barcode.errors[:barcodeable]).to include("can't be blank")
    end

    it "is invalid without a valid format" do
      barcode = build(:barcode, format: "invalid")
      barcode.valid?
      expect(barcode.errors[:format]).to include(" is not a valid barcode")
    end
  end

  describe "Associations" do
    it "belongs to barcodeable" do
      assoc = Barcode.reflect_on_association(:barcodeable)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
