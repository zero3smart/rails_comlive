require 'rails_helper'

RSpec.describe UnspscSegment, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      unspsc_segment = build(:unspsc_segment)
      expect(unspsc_segment).to be_valid
    end
    it "is invalid without a code" do
      unspsc_segment = build(:unspsc_segment, code: nil)
      unspsc_segment.valid?
      expect(unspsc_segment.errors[:code]).to include("can't be blank")
    end
    it "is invalid without a long code" do
      unspsc_segment = build(:unspsc_segment, long_code: nil)
      unspsc_segment.valid?
      expect(unspsc_segment.errors[:long_code]).to include("can't be blank")
    end
    it "is invalid without a description" do
      unspsc_segment = build(:unspsc_segment, description: nil)
      unspsc_segment.valid?
      expect(unspsc_segment.errors[:description]).to include("can't be blank")
    end
    it "is invalid if long code is less than 8 chars" do
      unspsc_segment = build(:unspsc_segment, long_code: "a"*6)
      unspsc_segment.valid?
      expect(unspsc_segment.errors[:long_code]).to include("is the wrong length (should be 8 characters)")
    end

    it "is invalid if long code is more than 8 chars" do
      unspsc_segment = build(:unspsc_segment, long_code: "a"*10)
      unspsc_segment.valid?
      expect(unspsc_segment.errors[:long_code]).to include("is the wrong length (should be 8 characters)")
    end
  end

  describe "Associations" do
    it "has many unspsc families" do
      assoc = UnspscSegment.reflect_on_association(:unspsc_families)
      expect(assoc.macro).to eq :has_many
    end
  end

end
