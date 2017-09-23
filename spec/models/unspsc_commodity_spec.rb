require 'rails_helper'

RSpec.describe UnspscCommodity, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      unspsc_commodity = build(:unspsc_commodity)
      expect(unspsc_commodity).to be_valid
    end
    it "is invalid without a code" do
      unspsc_commodity = build(:unspsc_commodity, code: nil)
      unspsc_commodity.valid?
      expect(unspsc_commodity.errors[:code]).to include("can't be blank")
    end
    it "is invalid without a long code" do
      unspsc_commodity = build(:unspsc_commodity, long_code: nil)
      unspsc_commodity.valid?
      expect(unspsc_commodity.errors[:long_code]).to include("can't be blank")
    end
    it "is invalid without a description" do
      unspsc_commodity = build(:unspsc_commodity, description: nil)
      unspsc_commodity.valid?
      expect(unspsc_commodity.errors[:description]).to include("can't be blank")
    end
    it "is invalid without a unspsc class" do
      unspsc_commodity = build(:unspsc_commodity, unspsc_class: nil)
      unspsc_commodity.valid?
      expect(unspsc_commodity.errors[:unspsc_class]).to include("can't be blank")
    end
    it "is invalid if long code is less than 8 chars" do
      unspsc_commodity = build(:unspsc_commodity, long_code: "a"*6)
      unspsc_commodity.valid?
      expect(unspsc_commodity.errors[:long_code]).to include("is the wrong length (should be 8 characters)")
    end
    it "is invalid if long code is more than 8 chars" do
      unspsc_commodity = build(:unspsc_commodity, long_code: "a"*10)
      unspsc_commodity.valid?
      expect(unspsc_commodity.errors[:long_code]).to include("is the wrong length (should be 8 characters)")
    end
  end

  describe "Associations" do
    it "belongs to unspsc class" do
      assoc = UnspscCommodity.reflect_on_association(:unspsc_class)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
