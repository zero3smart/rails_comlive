require 'rails_helper'

RSpec.describe ClassificationCommodity, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      clc = build(:classification_commodity)
      expect(clc).to be_valid
    end

    it "is invalid without a level" do
      clc = build(:classification_commodity, level: nil)
      clc.valid?
      expect(clc.errors[:level]).to include("can't be blank")
    end

    it "is invalid without a commodity" do
      clc = build(:classification_commodity, commodity: nil)
      clc.valid?
      expect(clc.errors[:commodity]).to include("can't be blank")
    end

    it "is invalid without added_by" do
      clc = build(:classification_commodity, added_by: nil)
      clc.valid?
      expect(clc.errors[:added_by]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to a level" do
      assoc = described_class.reflect_on_association(:level)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to a commodity" do
      assoc = described_class.reflect_on_association(:commodity)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to added_by" do
      assoc = described_class.reflect_on_association(:added_by)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
