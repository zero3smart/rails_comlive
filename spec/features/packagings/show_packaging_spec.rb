require 'rails_helper'

feature 'Packaging#show' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:generic_commodity_reference, app_id: app.id) }
  given(:packaging) { create(:packaging, commodity_reference_id: commodity_reference.id) }

  background do
    log_in(user)
    visit app_commodity_reference_packaging_path(app, commodity_reference, packaging)
  end

  scenario "User should see packaging details" do
    expect(page).to have_content(packaging.name)
    expect(page).to have_content(packaging.quantity)
    expect(page).to have_content(packaging.description)
    expect(page).to have_content(packaging.uom)
  end
end