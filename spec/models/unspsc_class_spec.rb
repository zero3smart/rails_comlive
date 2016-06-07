require 'rails_helper'

RSpec.describe UnspscClass, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      unspsc_class = build(:unspsc_class)
      expect(unspsc_class).to be_valid
    end
    it "is invalid without a code" do
      unspsc_class = build(:unspsc_class, code: nil)
      unspsc_class.valid?
      expect(unspsc_class.errors[:code]).to include("can't be blank")
    end
    it "is invalid without a long code" do
      unspsc_class = build(:unspsc_class, long_code: nil)
      unspsc_class.valid?
      expect(unspsc_class.errors[:long_code]).to include("can't be blank")
    end
    it "is invalid without a description" do
      unspsc_class = build(:unspsc_class, description: nil)
      unspsc_class.valid?
      expect(unspsc_class.errors[:description]).to include("can't be blank")
    end
    it "is invalid without a unspsc family" do
      unspsc_class = build(:unspsc_class, unspsc_family: nil)
      unspsc_class.valid?
      expect(unspsc_class.errors[:unspsc_family]).to match_array(["must exist", "can't be blank"])
    end
    it "is invalid if long code is less than 8 chars" do
      unspsc_class = build(:unspsc_class, long_code: "a"*6)
      unspsc_class.valid?
      expect(unspsc_class.errors[:long_code]).to include("is the wrong length (should be 8 characters)")
    end
    it "is invalid if long code is more than 8 chars" do
      unspsc_class = build(:unspsc_class, long_code: "a"*10)
      unspsc_class.valid?
      expect(unspsc_class.errors[:long_code]).to include("is the wrong length (should be 8 characters)")
    end
  end

  describe "Associations" do
    it "belongs to unspsc family" do
      assoc = UnspscClass.reflect_on_association(:unspsc_family)
      expect(assoc.macro).to eq :belongs_to
    end
    it "has many unspsc commodities" do
      assoc = UnspscClass.reflect_on_association(:unspsc_commodities)
      expect(assoc.macro).to eq :has_many
    end
  end
end
