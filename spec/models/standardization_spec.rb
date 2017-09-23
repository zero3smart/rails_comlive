require 'rails_helper'

RSpec.describe Standardization, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      standardization = build(:standardization)
      expect(standardization).to be_valid
    end

    it "is invalid without a user" do
      standardization = build(:standardization, user: nil)
      standardization.valid?
      expect(standardization.errors[:user]).to include("can't be blank")
    end

    it "is invalid without a standard" do
      standardization = build(:standardization, standard: nil)
      standardization.valid?
      expect(standardization.errors[:standard]).to include("can't be blank")
    end

    it "is invalid without a referable" do
      standardization = build(:standardization, referable: nil)
      standardization.valid?
      expect(standardization.errors[:referable]).to include("can't be blank")
    end

    it "is invalid with a duplicate standard of a particular referable" do
      standard = create(:standard)
      referable = create(:commodity)
      create(:standardization, standard: standard, referable: referable)
      standardization = build(:standardization, standard: standard, referable: referable)
      standardization.valid?
      expect(standardization.errors[:standard_id]).to include("has already been taken")
    end
  end

  describe "Associations" do
    it "belongs to a user" do
      assoc = Standardization.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to a standard" do
      assoc = Standardization.reflect_on_association(:standard)
      expect(assoc.macro).to eq :belongs_to
    end
    it "belongs to a referable" do
      assoc = Standardization.reflect_on_association(:referable)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
