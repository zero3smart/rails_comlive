require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BrandsHelper. For example:
#
# describe BrandsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BrandsHelper, :type => :helper do
  describe ".options_for_brands" do
    it "returns official brands" do
      official_brand   = FactoryGirl.create(:official_brand)
      other_brands = FactoryGirl.create_list(:brand,2)
      options = helper.options_for_brands

      expect(options).to match_array([[official_brand.name, "Brand-#{official_brand.id}"]])
      expect(options).not_to match_array(other_brands.map{|b| [ b.name, "Brand-#{b.id}"]})
    end
  end
end