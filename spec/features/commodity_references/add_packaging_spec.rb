require 'rails_helper'

feature 'Adding packaging to a commodity' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity) { create(:commodity) }
  given!(:commodity_reference) { create(:commodity_reference, commodity: commodity, app_id: app.id) }
  given(:packaging) { build(:packaging) }

  background do
    log_in(user)
    visit commodity_path(commodity)
  end

  scenario 'User can add packaging to a commodity reference', js: true do
    find(".btn-add.icon.icon-circle.icon-md").click
    within("#modalAdd") do
      click_link "Packaging"
    end

    fill_in 'packaging[name]', with: packaging.name
    fill_in 'packaging[description]',with: packaging.description
    fill_in 'packaging[quantity]', with: packaging.quantity
    fill_in 'packaging[uom]', with: packaging.uom
    select 'Private', from: 'packaging[visibility]'

    click_button 'Create Packaging'

    page.execute_script("$('a[href=\"#tab-2\"]').tab('show')")

    expect(page).to have_text(packaging.name)
    expect(page).to have_content(packaging.quantity)
    expect(page).to have_content(packaging.uom)
    expect(page).to have_content(/Private/i)
    expect(page).to have_content("Packaging successfully saved")
  end

end