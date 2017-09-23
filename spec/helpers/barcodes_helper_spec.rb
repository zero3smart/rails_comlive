require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BarcodesHelper. For example:
#
# describe BarcodesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BarcodesHelper, :type => :helper do
  describe ".options_for_barcode" do
    it "returns barcode types" do
      expect(helper.options_for_barcodes).to be_an(Array)
      expect(helper.options_for_barcodes.size).to eq BARCODE_FORMATS.size
    end
  end
end
