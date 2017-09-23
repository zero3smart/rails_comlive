require 'rails_helper'

RSpec.describe Standard, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      standard = build(:standard)
      expect(standard).to be_valid
    end

    it "is invalid without a name" do
      standard = build(:standard, name: nil)
      standard.valid?
      expect(standard.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a code" do
      standard = build(:standard, code: nil)
      standard.valid?
      expect(standard.errors[:code]).to include("can't be blank")
    end

    it "is invalid without a version" do
      standard = build(:standard, version: nil)
      standard.valid?
      expect(standard.errors[:version]).to include("can't be blank")
    end

    it "is invalid without a description" do
      standard = build(:standard, description: nil)
      standard.valid?
      expect(standard.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a brand" do
      standard = build(:standard, brand: nil)
      standard.valid?
      expect(standard.errors[:brand_id]).to include("can't be blank")
    end

    it "is invalid with invalid certifier url" do
      standard = build(:standard, certifier_url: "hgjhgh")
      standard.valid?
      expect(standard.errors[:certifier_url]).to include("is invalid")
    end

    it "is public by default" do
      standard = build(:standard)
      expect(standard.visibility).to eq "publicized"
    end
  end

  describe "Associations" do
    it "has many users" do
      assoc = Standard.reflect_on_association(:users)
      expect(assoc.macro).to eq :has_many
    end

    it "has many brands" do
      assoc = Standard.reflect_on_association(:brands)
      expect(assoc.macro).to eq :has_many
    end

    it "belongs to a brand" do
      assoc = Standard.reflect_on_association(:brand)
      expect(assoc.macro).to eq :belongs_to
    end

    it "has many commodity references" do
      assoc = Standard.reflect_on_association(:commodity_references)
      expect(assoc.macro).to eq :has_many
    end
  end
end
