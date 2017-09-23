require 'rails_helper'

RSpec.describe List, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      list = build(:list)
      expect(list).to be_valid
    end

    it "is invalid without a user" do
      list = build(:list, user: nil)
      list.valid?
      expect(list.errors[:user]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to a user" do
      assoc = subject.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
