require 'rails_helper'

feature "Visiting reference#show page" do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:reference) { create(:reference, app: app) }

  background do
    log_in(user)
    visit app_reference_path(app, reference)
  end

  scenario "Should show the reference's details" do

    expect(page).to have_text(reference.kind)
    expect(page).to have_text(reference.description)
    expect(page).to have_text(reference.source_commodity_reference.name)
    expect(page).to have_text(reference.target_commodity_reference.name)
  end
end