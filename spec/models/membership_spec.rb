require 'rails_helper'

RSpec.describe Member, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      member = build(:member)
      expect(member).to be_valid
    end

    it "is invalid without a user" do
      member = build(:member, user: nil)
      member.valid?
      expect(member.errors[:user]).to include("can't be blank")
    end

    it "is invalid without an app" do
      member = build(:member, app: nil)
      member.valid?
      expect(member.errors[:app]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to an app" do
      assoc = Member.reflect_on_association(:app)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to a user" do
      assoc = Member.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end