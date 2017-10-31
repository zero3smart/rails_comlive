require 'rails_helper'

RSpec.describe Membership, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      membership = build(:membership)
      expect(membership).to be_valid
    end

    it "is invalid without a user_id" do
      membership = build(:membership, user: nil)
      membership.valid?
      expect(membership.errors[:user]).to include("can't be blank")
    end

    it "is invalid without a member" do
      membership = build(:membership, member: nil)
      membership.valid?
      expect(membership.errors[:member]).to include("can't be blank")
    end

    it "initializes owner to false by default" do
      membership = build(:membership)
      expect(membership.owner).to eq false
    end
  end

  describe "Associations" do
    it "belongs to user" do
      assoc = Membership.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to member" do
      assoc = Membership.reflect_on_association(:member)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end