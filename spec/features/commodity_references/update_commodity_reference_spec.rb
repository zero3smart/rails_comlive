require 'rails_helper'

feature 'Updating a commodity Reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference){ create(:commodity_reference, app_id: app.id) }

  background do
    log_in(user)
    visit edit_app_commodity_reference_path(app, commodity_reference)
  end

  scenario "It should show the current commodity reference's details" do
    expect(page).to have_text("Edit Commodity")
    expect(find_field('commodity_reference[name]').value).to eq commodity_reference.name
    expect(find_field('commodity_reference[short_description]').value).to eq commodity_reference.short_description
    expect(find_field('commodity_reference[long_description]').value).to eq commodity_reference.long_description
    expect(page).to have_select('commodity_reference[measured_in]', selected: commodity_reference.measured_in)
  end

  scenario "With valid details" do
    fill_in "commodity_reference[name]", with: "Passport"
    select "time", from: "commodity_reference[measured_in]"
    check('commodity_reference[generic]')

    click_button "Update Commodity reference"

    expect(page).to have_text("Passport")
  end

  scenario "With invalid details" do
    fill_in "commodity_reference[name]", with: ""

    click_button "Update Commodity reference"

    expect(page).to have_text("Edit Commodity")
    expect(page).to have_text("Name can't be blank")
  end
end
