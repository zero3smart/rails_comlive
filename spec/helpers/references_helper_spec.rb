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
      kinds = %w(specific_of variation_of alternative_to)
      expect(helper.options_for_kind).to match_array(kinds)
    end
  end
end
