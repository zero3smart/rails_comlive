require 'rails_helper'

RSpec.describe HscodeSection, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      hscode_section = build(:hscode_section)
      expect(hscode_section).to be_valid
    end
    it "is invalid without a category" do
      hscode_section = build(:hscode_section, category: nil)
      hscode_section.valid?
      expect(hscode_section.errors[:category]).to include("can't be blank")
    end
    it "is invalid without a description" do
      hscode_section = build(:hscode_section, description: nil)
      hscode_section.valid?
      expect(hscode_section.errors[:description]).to include("can't be blank")
    end
    it "is invalid with a duplicate category" do
      create(:hscode_section, category: "01-05")
      hscode_section = build(:hscode_section, category: "01-05")
      hscode_section.valid?
      expect(hscode_section.errors[:category]).to include("has already been taken")
    end
  end

  describe "Associations" do
    it "has many hscode chapters" do
      assoc = HscodeSection.reflect_on_association(:hscode_chapters)
      expect(assoc.macro).to eq :has_many
    end
  end
end
