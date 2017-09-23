require 'rails_helper'

RSpec.describe HscodeHeading, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      hscode_heading = build(:hscode_heading)
      expect(hscode_heading).to be_valid
    end
    it "is invalid without a category" do
      hscode_heading = build(:hscode_heading, category: nil)
      hscode_heading.valid?
      expect(hscode_heading.errors[:category]).to include("can't be blank")
    end
    it "is invalid without a description" do
      hscode_heading = build(:hscode_heading, description: nil)
      hscode_heading.valid?
      expect(hscode_heading.errors[:description]).to include("can't be blank")
    end
    it "is invalid with a duplicate category" do
      create(:hscode_heading, category: "010%")
      hscode_heading = build(:hscode_heading, category: "010%")
      hscode_heading.valid?
      expect(hscode_heading.errors[:category]).to include("has already been taken")
    end
    it "is invalid if length of category is less than four letters long" do
      hscode_heading = build(:hscode_heading, category: "101")
      hscode_heading.valid?
      expect(hscode_heading.errors[:category]).to include("is the wrong length (should be 4 characters)")
    end
    it "is invalid if length of category is greater than four letters long" do
      hscode_heading = build(:hscode_heading, category: "10103")
      hscode_heading.valid?
      expect(hscode_heading.errors[:category]).to include("is the wrong length (should be 4 characters)")
    end
  end


  describe "Associations" do
    it "belongs to hscode chapter" do
      assoc = HscodeHeading.reflect_on_association(:hscode_chapter)
      expect(assoc.macro).to eq :belongs_to
    end
    it "has many hscode subheadings" do
      assoc = HscodeHeading.reflect_on_association(:hscode_subheadings)
      expect(assoc.macro).to eq :has_many
    end
  end
end
