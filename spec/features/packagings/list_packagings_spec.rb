require 'rails_helper'

feature "Listing Packagings" do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:packaging) { create(:packaging, commodity_reference_id: commodity_reference.id) }

  context "When user logged in" do
    background do
      log_in(user)
    end

    scenario "it should list available packagings"
  end

  context "When not logged in" do
    scenario "it should list available packagings"
  end
end