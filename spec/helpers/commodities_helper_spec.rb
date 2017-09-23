require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CommoditiesHelper. For example:
#
# describe CommoditiesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CommoditiesHelper, :type => :helper do
  describe ".barcode_for(model)" do
    it "returns a qr code image" do
      commodity = create(:commodity)
      packaging = create(:packaging)

      expect(helper.barcode_for(commodity)).to match(/<img class="qr_code" src="data:image\/png;base64/)
      expect(helper.barcode_for(packaging)).to match(/<img class="qr_code" src="data:image\/png;base64/)
    end
  end
end
