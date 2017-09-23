require 'rails_helper'

RSpec.describe CustomUnit, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      custom_unit = build(:custom_unit)
      expect(custom_unit).to be_valid
    end
    it "is invalid without a property" do
      custom_unit = build(:custom_unit, property: nil)
      custom_unit.valid?
      expect(custom_unit.errors[:property]).to include("can't be blank")
    end
    it "is invalid without a uom" do
      custom_unit = build(:custom_unit, uom: nil)
      custom_unit.valid?
      expect(custom_unit.errors[:uom]).to include("can't be blank")
    end
    it "is invalid without an app_id" do
      custom_unit = build(:custom_unit, app: nil)
      custom_unit.valid?
      expect(custom_unit.errors[:app]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to an app" do
      assoc = CustomUnit.reflect_on_association(:app)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
