require 'rails_helper'

RSpec.describe Commodity, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      commodity = build(:commodity)
      expect(commodity).to be_valid
    end

    it "is invalid without short description" do
      commodity = build(:commodity, short_description: nil)
      commodity.valid?
      expect(commodity.errors[:short_description]).to include("can't be blank")
    end

    it "is invalid without long description" do
      commodity = build(:commodity, long_description: nil)
      commodity.valid?
      expect(commodity.errors[:long_description]).to include("can't be blank")
    end

    it "is generic field is false by default" do
      commodity = Commodity.new
      expect(commodity.generic).to eq false
    end

    it "is invalid without measured_in" do
      commodity = build(:commodity, measured_in: nil)
      commodity.valid?
      expect(commodity.errors[:measured_in]).to include("can't be blank")
    end

    it "is invalid without an app" do
      commodity = build(:commodity, app_id: nil)
      commodity.valid?
      expect(commodity.errors[:app]).to include("can't be blank")
    end

    it "validates presence of brand if commodity is not generic" do
      commodity = build(:commodity, generic: false, brand: nil)
      commodity.valid?
      expect(commodity.errors[:brand_id]).to include("can't be blank")
    end

    it "assigns a uuid after create" do
      commodity = create(:commodity)
      expect(commodity.uuid).not_to be_nil
    end
  end

  describe "Associations" do
    it "belongs to an app" do
      assoc = Commodity.reflect_on_association(:app)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to a brand" do
      assoc = Commodity.reflect_on_association(:brand)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to hscode section" do
      assoc = Commodity.reflect_on_association(:hscode_section)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to hscode chapter" do
      assoc = Commodity.reflect_on_association(:hscode_chapter)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to hscode heading" do
      assoc = Commodity.reflect_on_association(:hscode_heading)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to hscode sub-heading" do
      assoc = Commodity.reflect_on_association(:hscode_subheading)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to unspsc family" do
      assoc = Commodity.reflect_on_association(:unspsc_family)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to unspsc segment" do
      assoc = Commodity.reflect_on_association(:unspsc_segment)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to unspsc class" do
      assoc = Commodity.reflect_on_association(:unspsc_class)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to unspsc commodity" do
      assoc = Commodity.reflect_on_association(:unspsc_commodity)
      expect(assoc.macro).to eq :belongs_to
    end
    it "has many links" do
      assoc = Commodity.reflect_on_association(:links)
      expect(assoc.macro).to eq :has_many
    end
    it "has many references" do
      assoc = Commodity.reflect_on_association(:references)
      expect(assoc.macro).to eq :has_many
    end
    it "has one state" do
      assoc = Commodity.reflect_on_association(:state)
      expect(assoc.macro).to eq :has_one
    end

    it "has many packagings" do
      assoc = Commodity.reflect_on_association(:packagings)
      expect(assoc.macro).to eq :has_many
    end

    it "has many standards" do
      assoc = Commodity.reflect_on_association(:standards)
      expect(assoc.macro).to eq :has_many
    end
  end
end