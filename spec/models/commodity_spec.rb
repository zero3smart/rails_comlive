require 'rails_helper'

RSpec.describe Commodity, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      commodity = build(:commodity)
      expect(commodity).to be_valid
    end

    it "is invalid without a name" do
      commodity = build(:commodity, name: nil)
      commodity.valid?
      expect(commodity.errors[:name]).to include("can't be blank")
    end

    it "is generic field is true by default" do
      commodity = Commodity.new
      expect(commodity.generic).to eq true
    end

    it "is invalid without measured_in" do
      commodity = build(:commodity, measured_in: nil)
      commodity.valid?
      expect(commodity.errors[:measured_in]).to include("can't be blank")
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
    it "belongs to a brand" do
      assoc = subject.reflect_on_association(:brand)
      expect(assoc.macro).to eq :belongs_to
    end

    it "has many commodity references" do
      assoc = subject.reflect_on_association(:commodity_references)
      expect(assoc.macro).to eq :has_many
    end

    it "has many specifications" do
      assoc = subject.reflect_on_association(:specifications)
      expect(assoc.macro).to eq :has_many
      expect(assoc.options[:through]).to eq :commodity_references
    end

    it "has many packagings" do
      assoc = subject.reflect_on_association(:packagings)
      expect(assoc.macro).to eq :has_many
      expect(assoc.options[:through]).to eq :commodity_references
    end

    it "has many standards" do
      assoc = subject.reflect_on_association(:standards)
      expect(assoc.macro).to eq :has_many
      expect(assoc.options[:through]).to eq :commodity_references
    end

    it "has many references" do
      assoc = subject.reflect_on_association(:references)
      expect(assoc.macro).to eq :has_many
      expect(assoc.options[:through]).to eq :commodity_references
    end

    it "has many links" do
      assoc = subject.reflect_on_association(:links)
      expect(assoc.macro).to eq :has_many
      expect(assoc.options[:through]).to eq :commodity_references
    end

    it "has many images" do
      assoc = subject.reflect_on_association(:images)
      expect(assoc.macro).to eq :has_many
      expect(assoc.options[:through]).to eq :commodity_references
    end

    it "has many barcodes" do
      assoc = subject.reflect_on_association(:barcodes)
      expect(assoc.macro).to eq :has_many
    end

    it "has many classification commodities" do
      assoc = subject.reflect_on_association(:classification_commodities)
      expect(assoc.macro).to eq :has_many
    end
  end

  describe "Instance Methods" do
    describe "#avatar_url" do
      context "With images present" do
        it "returns the name of the first image" do
          images = create_list(:image,2)
          commodity = images.first.commodity_reference.commodity

          expect(commodity.avatar_url).to eq images.first.url
        end
      end

      context "With no images present" do
        it "returns the name of the default commodity image" do
          commodity = create(:commodity)

          expect(commodity.avatar_url).to eq "commodity-default.gif"
        end
      end
    end
  end

  describe "Class Methods" do
    describe ".search" do
      it "returns commodities matching the query" do
        generic_commodity = create(:generic_commodity, name: "Western Digital")
        non_generic_commodity = create(:non_generic_commodity, name: "Dell Inc")

        subject.reindex

        generic_search = subject.search("western").records
        non_generic_search = subject.search("inc").records
        no_results_search = subject.search("remote").records

        expect(generic_search).to match_array([generic_commodity])
        expect(generic_search).not_to match_array([non_generic_commodity])

        expect(non_generic_search).to match_array([non_generic_commodity])
        expect(non_generic_search).not_to match_array([generic_commodity])

        expect(no_results_search).to be_empty
      end
    end
  end

  describe "Callbacks" do
    it "removes commodity_id from any lists present with its id" do
      create_list(:user, 3)
      commodities = create_list(:commodity, 3)
      commodity = commodities.sample
      commodity_id = commodity.id
      ids = commodities.map(&:id)
      List.update_all(commodities: ids)

      commodity.destroy

      lists = List.where("'#{commodity_id}' = ANY (commodities)")
      expect(lists).to be_empty
    end
  end
end
