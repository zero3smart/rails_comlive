require 'rails_helper'

RSpec.describe ClassificationStandard, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      cls = build(:classification_standard)
      expect(cls).to be_valid
    end

    it "is invalid without a level" do
      cls = build(:classification_standard, level: nil)
      cls.valid?
      expect(cls.errors[:level]).to include("can't be blank")
    end

    it "is invalid without a standard" do
      cls = build(:classification_standard, standard: nil)
      cls.valid?
      expect(cls.errors[:standard]).to include("can't be blank")
    end

    it "is invalid without added_by" do
      cls = build(:classification_standard, added_by: nil)
      cls.valid?
      expect(cls.errors[:added_by]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to a level" do
      assoc = subject.reflect_on_association(:level)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to a standard" do
      assoc = subject.reflect_on_association(:standard)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to added_by" do
      assoc = subject.reflect_on_association(:added_by)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
