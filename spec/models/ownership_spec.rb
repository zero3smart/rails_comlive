require 'rails_helper'

RSpec.describe Ownership, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      ownership = build(:ownership)
      expect(ownership).to be_valid
    end
    it "is invalid without a parent" do
      ownership = build(:ownership, parent: nil)
      ownership.valid?
      expect(ownership.errors[:parent]).to include("can't be blank")
    end

    it "is invalid without a child" do
      ownership = build(:ownership, child: nil)
      ownership.valid?
      expect(ownership.errors[:child]).to include("can't be blank")
    end

    it "is invalid with a duplicate child" do
      child_brand = create(:brand)
      create(:ownership, child: child_brand)
      ownership = build(:ownership, child: child_brand)
      ownership.valid?
      expect(ownership.errors[:child_id]).to include("has already been taken")
    end

    # it "restricts ownership to official brands only" do
    #   parent_brand = create(:brand)
    #   child_brand = create(:brand)
    #   ownership = build(:ownership, parent: parent_brand, child: child_brand)
    #   ownership.valid?
    #   expect(ownership.errors[:parent]).to include(" brand must be the official brand")
    # end
    #
    # it "restricts ownership of official brands" do
    #   nike = create(:official_brand)
    #   addidas = create(:official_brand)
    #   ownership = build(:ownership, parent: nike, child: addidas)
    #   ownership.valid?
    #   expect(ownership.errors[:child]).to include(" brand is official and cannot be owned")
    # end
  end

  describe "Associations" do
    it "belongs to parent" do
      assoc = Ownership.reflect_on_association(:parent)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to child" do
      assoc = Ownership.reflect_on_association(:child)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
