require 'rails_helper'

RSpec.describe Link, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      link = build(:link)
      expect(link).to be_valid
    end
    it "is invalid without a url" do
      link = build(:link, url: nil)
      link.valid?
      expect(link.errors[:url]).to include("can't be blank")
    end
    it "is invalid without a description" do
      link = build(:link, description: nil)
      link.valid?
      expect(link.errors[:description]).to include("can't be blank")
    end
    it "is invalid without an app" do
      link = build(:link, app_id: nil)
      link.valid?
      expect(link.errors[:app]).to include("can't be blank")
    end
    it "is invalid without a commodity" do
      link = build(:link, commodity_id: nil)
      link.valid?
      expect(link.errors[:commodity]).to include("can't be blank")
    end
    it "validates format of url" do
      link = build(:link, url: "http://fake")
      link.valid?
      expect(link.errors[:url]).to include("is invalid")
    end
  end

  describe "Associations" do
    it "belongs to a commodity" do
      assoc = Link.reflect_on_association(:commodity)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to an app" do
      assoc = Link.reflect_on_association(:app)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
