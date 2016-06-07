require 'rails_helper'

RSpec.describe HscodeChapter, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      hscode_chapter = build(:hscode_chapter)
      expect(hscode_chapter).to be_valid
    end
    it "is invalid without a category" do
      hscode_chapter = build(:hscode_chapter, category: nil)
      hscode_chapter.valid?
      expect(hscode_chapter.errors[:category]).to include("can't be blank")
    end
    it "is invalid without a description" do
      hscode_chapter = build(:hscode_chapter, description: nil)
      hscode_chapter.valid?
      expect(hscode_chapter.errors[:description]).to include("can't be blank")
    end
    it "is invalid with a duplicate category" do
      create(:hscode_chapter, category: "01")
      hscode_chapter = build(:hscode_chapter, category: "01")
      hscode_chapter.valid?
      expect(hscode_chapter.errors[:category]).to include("has already been taken")
    end
    it "is invalid without a hscode section" do
      hscode_chapter = build(:hscode_chapter, hscode_section: nil)
      hscode_chapter.valid?
      expect(hscode_chapter.errors[:hscode_section]).to include("must exist")
    end

    it "is invalid if length of category is less than two letters long" do
      hscode_chapter = build(:hscode_chapter, category: "1")
      hscode_chapter.valid?
      expect(hscode_chapter.errors[:category]).to include("is the wrong length (should be 2 characters)")
    end

    it "is invalid if length of category is greater than two letters long" do
      hscode_chapter = build(:hscode_chapter, category: "101")
      hscode_chapter.valid?
      expect(hscode_chapter.errors[:category]).to include("is the wrong length (should be 2 characters)")
    end
  end

  describe "Associations" do
    it "belongs to hscode section" do
      assoc = HscodeChapter.reflect_on_association(:hscode_section)
      expect(assoc.macro).to eq :belongs_to
    end
    it "has many hscode headings" do
      assoc = HscodeChapter.reflect_on_association(:hscode_headings)
      expect(assoc.macro).to eq :has_many
    end
  end
end
