require 'rails_helper'

feature 'Adding link to a commodity reference' do
  given(:user) { create(:user) }
  given(:apps) { user.apps << create(:app) } # creates a membership record
  given(:app) { apps.first }
  given!(:commodity_reference) { create(:generic_commodity_reference, app_id: app.id) }
  given(:link) { build(:link) }

  background do
    log_in(user)
    visit app_commodity_reference_path(app, commodity_reference)
  end

  scenario 'User can add a link to a commodity_reference', js: true do
    click_link "Add Link"

    within("div#sharedModal") do
      fill_in 'link[url]', with: link.url
      fill_in 'link[description]',with: link.description
      select commodity_reference.name, from: 'link[commodity_reference_id]'

      click_button 'Submit'
    end

    expect(page).to have_link('Open Link', href: link.url)
    expect(page).to have_content(link.description)
    expect(page).to have_content("link successfully created")
  end

end