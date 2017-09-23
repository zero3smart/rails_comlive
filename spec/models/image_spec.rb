require 'rails_helper'

RSpec.describe Image, :type => :model do
  subject { described_class }

  describe "Validations" do
    it "has a valid factory" do
      image = build(:image)
      expect(image).to be_valid
    end

    it "is invalid without a url" do
      image = build(:image, url: nil)
      image.valid?
      expect(image.errors[:url]).to include("can't be blank")
    end

    it "is invalid without a commodity reference" do
      image = build(:image, commodity_reference: nil)
      image.valid?
      expect(image.errors[:commodity_reference_id]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "belongs to commodity reference" do
      assoc = subject.reflect_on_association(:commodity_reference)
      expect(assoc.macro).to eq :belongs_to
    end
  end

  describe "Instance methods" do
    describe "#handle" do
      it "returns the filepicker handle for the file" do
        image = create(:image, url: "https://cdn.filestackcontent.com/P4oUdJHQVe4G7Mx4Gw8d")
        expect(image.handle).to eq "P4oUdJHQVe4G7Mx4Gw8d"
      end
    end
  end
end
