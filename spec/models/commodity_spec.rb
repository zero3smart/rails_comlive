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

    it "is invalid without an app" do
      commodity = build(:commodity, app_id: nil)
      commodity.valid?
      expect(commodity.errors[:app]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to an app" do
      assoc = Commodity.reflect_on_association(:app)
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
    # it "belongs to unspsc segment" do
    #   assoc = Commodity.reflect_on_association(:unspsc_segment)
    #   expect(assoc.macro).to eq :belongs_to
    # end
    # it "belongs to unspsc family" do
    #   assoc = Commodity.reflect_on_association(:unspsc_family)
    #   expect(assoc.macro).to eq :belongs_to
    # end
    # it "belongs to unspsc class" do
    #   assoc = Commodity.reflect_on_association(:unspsc_class)
    #   expect(assoc.macro).to eq :belongs_to
    # end
    # it "belongs to unspsc commodity" do
    #   assoc = Commodity.reflect_on_association(:unspsc_commodity)
    #   expect(assoc.macro).to eq :belongs_to
    # end
  end
end
