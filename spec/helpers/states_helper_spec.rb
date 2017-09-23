require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StatesHelper. For example:
#
# describe StatesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StatesHelper, :type => :helper do
  describe ".options_for_states" do
    it "returns an array of allowed statuses" do
      allowed_states = State::ALLOWED_STATUSES.map{|s| [s.titleize, s]}

      expect(helper.options_for_states).to match_array(allowed_states)
    end
  end
end
