require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the OwnershipsHelper. For example:
#
# describe OwnershipsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe OwnershipsHelper, :type => :helper do
  describe ".options_for_apps" do
    it "returns a list of apps belonging to the user" do
      user = create(:user)
      app = user.default_app

      expect(helper.options_for_apps(user)).to eq [[app.name, "App-#{app.id}"]]
    end
  end
end
