require 'rails_helper'

feature 'Updating commodities' do
  given!(:user){ create(:user, email: 'user@example.com', password: 'secretpass') }
  given!(:app){ create(:app, user_id: user.id) }
  given!(:commodity){ create(:commodity, app_id: app.id) }

  background do
    log_in(user)
    visit edit_app_commodity_path(app, commodity)
  end

  scenario "It should show the current commodity's details", js: true do
    expect(page).to have_text("Edit Commodity")
    expect(find_field('commodity[name]').value).to eq commodity.name
    expect(page).to have_select('commodity[measured_in]', selected: commodity.measured_in)
  end

  scenario "With valid details" do
    fill_in "commodity[name]", with: "Passport"
    select "time", from: "commodity[measured_in]"
    check('commodity[generic]')

    click_button "Update Commodity"

    expect(page).to have_text("Passport")
  end

  scenario "With invalid details" do
    fill_in "commodity[name]", with: ""

    click_button "Update Commodity"

    expect(page).to have_text("Edit Commodity")
    expect(page).to have_text("Name can't be blank")
  end
end
