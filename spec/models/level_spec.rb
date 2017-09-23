require 'rails_helper'

RSpec.describe Level, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      level = build(:level)
      level_with_parent = build(:level, :with_parent)
      expect(level).to be_valid
      expect(level_with_parent).to be_valid
    end

    it "is invalid without a name" do
      level = build(:level, name: nil)
      level.valid?
      expect(level.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a position" do
      level = build(:level, position: nil)
      level.valid?
      expect(level.errors[:position]).to include("can't be blank")
    end

    it "is invalid without a classification" do
      level = build(:level, classification: nil)
      level.valid?
      expect(level.errors[:classification]).to include("can't be blank")
    end

    it "is invalid without added_by" do
      level = build(:level, added_by: nil)
      level.valid?
      expect(level.errors[:added_by]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to classification" do
      assoc = described_class.reflect_on_association(:classification)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to added by" do
      assoc = described_class.reflect_on_association(:added_by)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to parent" do
      assoc = described_class.reflect_on_association(:parent)
      expect(assoc.macro).to eq :belongs_to
    end
    it "has many children" do
      assoc = described_class.reflect_on_association(:children)
      expect(assoc.macro).to eq :has_many
    end
    it "has many classification units" do
      assoc = described_class.reflect_on_association(:units)
      expect(assoc.macro).to eq :has_many
    end
    it "has many commodities" do
      assoc = described_class.reflect_on_association(:classification_commodities)
      expect(assoc.macro).to eq :has_many
    end
    it "has many classification standards" do
      assoc = described_class.reflect_on_association(:classification_standards)
      expect(assoc.macro).to eq :has_many
    end
  end
end
