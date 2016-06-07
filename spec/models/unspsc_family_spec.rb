require 'rails_helper'

RSpec.describe UnspscFamily, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      unspsc_family = build(:unspsc_family)
      expect(unspsc_family).to be_valid
    end
    it "is invalid without a code" do
      unspsc_family = build(:unspsc_family, code: nil)
      unspsc_family.valid?
      expect(unspsc_family.errors[:code]).to include("can't be blank")
    end
    it "is invalid without a long code" do
      unspsc_family = build(:unspsc_family, long_code: nil)
      unspsc_family.valid?
      expect(unspsc_family.errors[:long_code]).to include("can't be blank")
    end
    it "is invalid without a description" do
      unspsc_family = build(:unspsc_family, description: nil)
      unspsc_family.valid?
      expect(unspsc_family.errors[:description]).to include("can't be blank")
    end
    it "is invalid without a unspsc segment" do
      unspsc_family = build(:unspsc_family, unspsc_segment: nil)
      unspsc_family.valid?
      expect(unspsc_family.errors[:unspsc_segment]).to match_array(["must exist", "can't be blank"])
    end
    it "is invalid if long code is less than 8 chars" do
      unspsc_family = build(:unspsc_family, long_code: "a"*6)
      unspsc_family.valid?
      expect(unspsc_family.errors[:long_code]).to include("is the wrong length (should be 8 characters)")
    end

    it "is invalid if long code is more than 8 chars" do
      unspsc_family = build(:unspsc_family, long_code: "a"*10)
      unspsc_family.valid?
      expect(unspsc_family.errors[:long_code]).to include("is the wrong length (should be 8 characters)")
    end
  end

  describe "Associations" do
    it "belongs to unspsc segment" do
      assoc = UnspscFamily.reflect_on_association(:unspsc_segment)
      expect(assoc.macro).to eq :belongs_to
    end
    it "has many unspsc classes" do
      assoc = UnspscFamily.reflect_on_association(:unspsc_classes)
      expect(assoc.macro).to eq :has_many
    end
  end
end
