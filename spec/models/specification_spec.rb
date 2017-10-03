require 'rails_helper'

RSpec.describe Specification, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      specification = build(:specification)
      expect(specification).to be_valid
    end

    it "it invalid without a property" do
      specification = build(:specification, property: nil)
      specification.valid?
      expect(specification.errors[:property]).to include("can't be blank")
    end

    it "it invalid without a unit of measure (uom)" do
      specification = build(:specification, uom: nil)
      specification.valid?
      expect(specification.errors[:uom]).to include("can't be blank")
    end

    it "it invalid without a parent" do
      specification = build(:specification, parent: nil)
      specification.valid?
      expect(specification.errors[:parent]).to include("can't be blank")
    end

    it "validates value if min and max not set" do
      specification = build(:specification, value: nil)
      specification.valid?
      expect(specification.errors[:value]).to include("can't be blank")
    end

    it "validates min or max if value is not set" do
      specification = build(:spec_with_min_max, min: nil, max: nil)
      specification.valid?
      expect(specification.errors[:base]).to include("You must set either a minimum or a maximum value")
    end

    describe "With value absent" do
      context "with min absent and max set" do
        it "has a valid factory" do
          specification = build(:spec_with_min_max, min: nil)
          expect(specification).to be_valid
        end
      end

      context "with max absent and min set" do
        it "has a valid factory" do
          specification = build(:spec_with_min_max, max: nil)
          expect(specification).to be_valid
        end
      end
    end
  end

  describe "Associations" do
    it "belongs to a parent" do
      assoc = Specification.reflect_on_association(:parent)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end