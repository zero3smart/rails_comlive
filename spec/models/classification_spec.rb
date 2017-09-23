require 'rails_helper'

RSpec.describe Classification, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      classification = build(:classification)
      expect(classification).to be_valid
    end

    it "is invalid without a name" do
      classification = build(:classification, name: nil)
      classification.valid?
      expect(classification.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a description" do
      classification = build(:classification, description: nil)
      classification.valid?
      expect(classification.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a moderator" do
      classification = build(:classification, moderator: nil)
      classification.valid?
      expect(classification.errors[:moderator]).to include("can't be blank")
    end

    it "is invalid without an app" do
      classification = build(:classification, app: nil)
      classification.valid?
      expect(classification.errors[:app]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to a moderator" do
      assoc = described_class.reflect_on_association(:moderator)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to an app" do
      assoc = described_class.reflect_on_association(:app)
      expect(assoc.macro).to eq :belongs_to
    end

    it "has many app accesses" do
      assoc = described_class.reflect_on_association(:app_accesses)
      expect(assoc.macro).to eq :has_many
    end

    it "has many levels" do
      assoc = described_class.reflect_on_association(:levels)
      expect(assoc.macro).to eq :has_many
    end
  end
end
