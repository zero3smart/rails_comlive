require 'rails_helper'

RSpec.describe CommodityReference, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      commodity_ref = build(:commodity_reference)
      expect(commodity_ref).to be_valid
    end

    it "is invalid without a name" do
      commodity_ref = build(:commodity_reference, name: nil)
      commodity_ref.valid?
      expect(commodity_ref.errors[:name]).to include("can't be blank")
    end

    it "is generic field is false by default" do
      commodity_ref = build(:commodity_reference)
      expect(commodity_ref.generic).to eq false
    end

    it "is valid with if generic and without brand" do
      commodity_ref = build(:commodity_reference, generic: true, brand: nil)
      expect(commodity_ref).to be_valid
    end

    it "is invalid without measured_in" do
      commodity_ref = build(:commodity_reference, measured_in: nil)
      commodity_ref.valid?
      expect(commodity_ref.errors[:measured_in]).to include("can't be blank")
    end

    it "validates presence of brand if commodity_ref is not generic" do
      commodity_ref = build(:commodity_reference, generic: false, brand: nil)
      commodity_ref.valid?
      expect(commodity_ref.errors[:brand_id]).to include("can't be blank")
    end

    it "assigns a uuid after create" do
      commodity_ref = create(:commodity_reference)
      expect(commodity_ref.uuid).not_to be_nil
    end
  end

  describe "Associations" do
    it "belongs to a brand" do
      assoc = CommodityReference.reflect_on_association(:brand)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to a commodity" do
      assoc = CommodityReference.reflect_on_association(:commodity)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to an app" do
      assoc = CommodityReference.reflect_on_association(:app)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to hscode section" do
      assoc = CommodityReference.reflect_on_association(:hscode_section)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to hscode chapter" do
      assoc = CommodityReference.reflect_on_association(:hscode_chapter)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to hscode heading" do
      assoc = CommodityReference.reflect_on_association(:hscode_heading)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to hscode sub-heading" do
      assoc = CommodityReference.reflect_on_association(:hscode_subheading)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to unspsc family" do
      assoc = CommodityReference.reflect_on_association(:unspsc_family)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to unspsc segment" do
      assoc = CommodityReference.reflect_on_association(:unspsc_segment)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to unspsc class" do
      assoc = CommodityReference.reflect_on_association(:unspsc_class)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to unspsc commodity" do
      assoc = CommodityReference.reflect_on_association(:unspsc_commodity)
      expect(assoc.macro).to eq :belongs_to
    end
    it "has many links" do
      assoc = CommodityReference.reflect_on_association(:links)
      expect(assoc.macro).to eq :has_many
    end
    it "has many references" do
      assoc = CommodityReference.reflect_on_association(:references)
      expect(assoc.macro).to eq :has_many
    end
    it "has one state" do
      assoc = CommodityReference.reflect_on_association(:state)
      expect(assoc.macro).to eq :has_one
    end

    it "has many packagings" do
      assoc = CommodityReference.reflect_on_association(:packagings)
      expect(assoc.macro).to eq :has_many
    end

    it "has many standards" do
      assoc = CommodityReference.reflect_on_association(:standards)
      expect(assoc.macro).to eq :has_many
    end

    it "has many specifications" do
      assoc = CommodityReference.reflect_on_association(:specifications)
      expect(assoc.macro).to eq :has_many
    end
  end
end