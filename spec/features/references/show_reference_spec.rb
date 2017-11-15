require 'rails_helper'

feature "Visiting reference#show page" do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app: app) }
  given(:reference) { create(:reference, commodity_reference: commodity_reference, app: app) }

  background do
    log_in(user)
    visit app_commodity_reference_reference_path(app,commodity_reference, reference)
  end

  scenario "Should show the reference's details" do

    expect(page).to have_text(reference.kind)
    expect(page).to have_text(reference.description)
    expect(page).to have_text(reference.source_commodity.name)
    expect(page).to have_text(reference.target_commodity.name)
  end
end