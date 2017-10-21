require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StandardsHelper. For example:
#
# describe StandardsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StandardsHelper, :type => :helper do
  describe ".options_for_standards" do
    it "returns official standards" do
      official_standard   = FactoryGirl.create(:official_standard)
      other_standards  = FactoryGirl.create_list(:standard,2)

      options = helper.options_for_standards

      expect(options).to match_array([[official_standard.name, "Standard-#{official_standard.id}"]])
      expect(options).not_to match_array(other_standards.map{|b| [ b.name, "Standard-#{b.id}"]})
    end
  end
end