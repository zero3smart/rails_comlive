require 'rails_helper'

RSpec.describe AppAccess, :type => :model do

  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      app_access = build(:app_access)
      expect(app_access).to be_valid
    end

    it "is invalid without an app" do
      app_access = build(:app_access, app: nil)
      app_access.valid?
      expect(app_access.errors[:app]).to include("can't be blank")
    end

    it "is invalid without a classification" do
      app_access = build(:app_access, classification: nil)
      app_access.valid?
      expect(app_access.errors[:classification]).to include("can't be blank")
    end

    it "is invalid without added by" do
      app_access = build(:app_access, added_by: nil)
      app_access.valid?
      expect(app_access.errors[:added_by]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to an app" do
      assoc = subject.reflect_on_association(:app)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to a classification" do
      assoc = subject.reflect_on_association(:classification)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to added by" do
      assoc = subject.reflect_on_association(:added_by)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
