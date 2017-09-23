require 'rails_helper'

RSpec.describe Unit, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      unit = build(:unit)
      expect(unit).to be_valid
    end

    it "is invalid without a level" do
      unit = build(:unit, level: nil)
      unit.valid?
      expect(unit.errors[:level]).to include("can't be blank")
    end

    it "is invalid without a uom" do
      unit = build(:unit, uom: nil)
      unit.valid?
      expect(unit.errors[:uom]).to include("can't be blank")
    end

    it "is invalid without added by" do
      unit = build(:unit, added_by: nil)
      unit.valid?
      expect(unit.errors[:added_by]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to a level" do
      assoc = described_class.reflect_on_association(:level)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to added by" do
      assoc = described_class.reflect_on_association(:added_by)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
