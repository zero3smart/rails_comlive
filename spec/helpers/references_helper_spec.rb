require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReferencesHelper. For example:
#
# describe ReferencesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReferencesHelper, :type => :helper do
  describe ".options_for_kind" do
    it "returns an array of allowed kinds" do
      kinds = [["Alternative To", "alternative_to"], ["Specific Of", "specific_of"], ["Variation Of", "variation_of"]]
      expect(helper.options_for_kind).to match_array(kinds)
    end
  end

  describe ".options_for_references(reference)" do
    context "When reference is a new record" do
      it "returns an empty array" do
        reference = Reference.new
        expect(helper.options_for_references(reference)).to be_an Array
        expect(helper.options_for_references(reference)).to be_empty
      end
    end

    context "When reference is an existing record" do
      it "returns an array with source commodity name and id" do
        reference = FactoryGirl.create(:reference)
        expected_array = [[reference.source_commodity.name, reference.source_commodity.id]]
        expect(helper.options_for_references(reference)).to match_array(expected_array)
      end
    end
  end
end
