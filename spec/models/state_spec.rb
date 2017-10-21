require 'rails_helper'

RSpec.describe State, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      state = build(:state)
      expect(state).to be_valid
    end

    it "is invalid without a status" do
      state = build(:state, status: nil)
      state.valid?
      expect(state.errors[:status]).to include("can't be blank")
    end

    it "is invalid without info" do
      state = build(:state, info: nil)
      state.valid?
      expect(state.errors[:info]).to include("can't be blank")
    end

    it "is invalid without a url" do
      state = build(:state, url: nil)
      state.valid?
      expect(state.errors[:url]).to include("can't be blank")
    end

    it "is invalid with an invalid url" do
      state = build(:state, url: "htps://invalidurl")
      state.valid?
      expect(state.errors[:url]).to include("is invalid")
    end

    it "is invalid without a commodity reference" do
      state = build(:state, commodity_reference: nil)
      state.valid?
      expect(state.errors[:commodity_reference]).to include("can't be blank")
    end

    it "is invalid if status is not one of allowed status" do
      state = build(:state, status: "passport")
      state.valid?
      expect(state.errors[:status]).to include("passport is not a valid status")
    end
  end

  describe "Associations" do
    it "belongs to a commodity reference" do
      assoc = State.reflect_on_association(:commodity_reference)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end