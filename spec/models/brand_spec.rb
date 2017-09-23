require 'rails_helper'

RSpec.describe Brand, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      brand = build(:brand)
      expect(brand).to be_valid
    end

    it "is invalid without a name" do
      brand = build(:brand, name: nil)
      brand.valid?
      expect(brand.errors[:name]).to include("can't be blank")
    end

    context "With optional fields present" do
      it "is invalid with an invalid url" do
        brand = build(:brand, url: "fake//url")
        brand.valid?
        expect(brand.errors[:url]).to include("is invalid")
      end
      it "is invalid with an invalid facebook address" do
        brand = build(:brand, facebook_address: "fake//url")
        brand.valid?
        expect(brand.errors[:facebook_address]).to include("is invalid")
      end
      it "is invalid with an invalid open corporate url" do
        brand = build(:brand, open_corporate_url: "fake//url")
        brand.valid?
        expect(brand.errors[:open_corporate_url]).to include("is invalid")
      end
      it "is invalid with an invalid wipo" do
        brand = build(:brand, wipo_url: "fake//url")
        brand.valid?
        expect(brand.errors[:wipo_url]).to include("is invalid")
      end
      it "is invalid with an invalid url" do
        brand = build(:brand, email: "invalid.email")
        brand.valid?
        expect(brand.errors[:email]).to include("is invalid")
      end
    end
  end

  describe "Associations" do
    it "has many users" do
      assoc = Brand.reflect_on_association(:users)
      expect(assoc.macro).to eq :has_many
    end

    it "has many children" do
      assoc = Brand.reflect_on_association(:children)
      expect(assoc.macro).to eq :has_many
    end

    it "has many commodities" do
      assoc = Brand.reflect_on_association(:commodities)
      expect(assoc.macro).to eq :has_many
    end

    it "has many standards" do
      assoc = Brand.reflect_on_association(:standards)
      expect(assoc.macro).to eq :has_many
    end
  end
end
