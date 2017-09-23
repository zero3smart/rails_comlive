require 'rails_helper'

RSpec.describe App, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      app = build(:app)
      expect(app).to be_valid
    end

    it "is invalid without a name" do
      app = build(:app, name: nil)
      app.valid?
      expect(app.errors[:name]).to include("can't be blank")
    end

    it "has a uuid" do
      app = create(:app)
      expect(app.uuid).not_to be_nil
    end
  end

  describe "Associations" do
    it "has many commodity references" do
      assoc = subject.reflect_on_association(:commodity_references)
      expect(assoc.macro).to eq :has_many
    end

    it "has many links" do
      assoc = subject.reflect_on_association(:links)
      expect(assoc.macro).to eq :has_many
    end

    it "has many references" do
      assoc = subject.reflect_on_association(:references)
      expect(assoc.macro).to eq :has_many
    end

    it "has many measurements" do
      assoc = subject.reflect_on_association(:measurements)
      expect(assoc.macro).to eq :has_many
    end

    it "has many custom units" do
      assoc = subject.reflect_on_association(:custom_units)
      expect(assoc.macro).to eq :has_many
    end

    it "has many brands" do
      assoc = subject.reflect_on_association(:brands)
      expect(assoc.macro).to eq :has_many
      expect(assoc.options[:through]).to eq :ownerships
    end

    it "has many standards" do
      assoc = subject.reflect_on_association(:standards)
      expect(assoc.macro).to eq :has_many
    end

    it "has many users" do
      assoc = subject.reflect_on_association(:users)
      expect(assoc.macro).to eq :has_many
      expect(assoc.options[:through]).to eq :memberships
    end

    it "has many invitations" do
      assoc = subject.reflect_on_association(:invitations)
      expect(assoc.macro).to eq :has_many
    end

    it "has many classifications" do
      assoc = subject.reflect_on_association(:classifications)
      expect(assoc.macro).to eq :has_many
    end
  end
end
