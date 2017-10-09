require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a duplicate email" do
      create(:user, email: "user@example.com")
      user = build(:user, email: "user@example.com")
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid if password confirmation does not match password" do
      user = build(:user, password_confirmation: "notmatching")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "should have a token" do
      user = create(:user)
      expect(user.token).not_to be_nil
    end
  end

  describe "Associations" do
    it "has many invited apps" do
      assoc = User.reflect_on_association(:invited_apps)
      expect(assoc.macro).to eq :has_many
    end

    it "has many brands" do
      assoc = User.reflect_on_association(:brands)
      expect(assoc.macro).to eq :has_many
    end

    it "has many standards" do
      assoc = User.reflect_on_association(:standards)
      expect(assoc.macro).to eq :has_many
    end

    it "has many apps" do
      assoc = User.reflect_on_association(:apps)
      expect(assoc.macro).to eq :has_many
    end
  end
end