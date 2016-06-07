require 'rails_helper'

RSpec.describe HscodeSubheading, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      hscode_subheading = build(:hscode_subheading)
      expect(hscode_subheading).to be_valid
    end
    it "is invalid without a category" do
      hscode_subheading = build(:hscode_subheading, category: nil)
      hscode_subheading.valid?
      expect(hscode_subheading.errors[:category]).to include("can't be blank")
    end
    it "is invalid without a description" do
      hscode_subheading = build(:hscode_subheading, description: nil)
      hscode_subheading.valid?
      expect(hscode_subheading.errors[:description]).to include("can't be blank")
    end
    it "is invalid with a duplicate category" do
      create(:hscode_subheading, category: "050100")
      hscode_subheading = build(:hscode_subheading, category: "050100")
      hscode_subheading.valid?
      expect(hscode_subheading.errors[:category]).to include("has already been taken")
    end
    it "is invalid if category length is less than 6 characters" do
      hscode_subheading = build(:hscode_subheading, category: "10176")
      hscode_subheading.valid?
      expect(hscode_subheading.errors[:category]).to include("is the wrong length (should be 6 characters)")
    end
    it "is invalid if category length is greater than 6 characters" do
      hscode_subheading = build(:hscode_subheading, category: "1017684")
      hscode_subheading.valid?
      expect(hscode_subheading.errors[:category]).to include("is the wrong length (should be 6 characters)")
    end
  end

  describe "Associations" do
    it "belongs to hscode heading" do
      assoc = HscodeSubheading.reflect_on_association(:hscode_heading)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
