require 'rails_helper'

feature 'Adding packaging to a commodity' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity_reference) { create(:generic_commodity_reference, app_id: app.id) }
  given(:packaging) { build(:packaging) }

  background do
    log_in(user)
    visit app_commodity_reference_path(app, commodity_reference)
  end

  scenario 'User can add packaging to a commodity reference', js: true do
    click_link "Add Packaging"

    within("div#sharedModal") do
      fill_in 'packaging[name]', with: packaging.name
      fill_in 'packaging[description]',with: packaging.description
      fill_in 'packaging[quantity]', with: packaging.quantity
      fill_in 'packaging[uom]', with: packaging.uom
      select 'Private', from: 'packaging[visibility]'

      click_button 'Submit'
    end

    expect(page).to have_link(packaging.name)
    expect(page).to have_content(packaging.quantity)
    expect(page).to have_content(packaging.uom)
    expect(page).to have_content("Private")
    expect(page).to have_content("Packaging successfully saved")
  end

end