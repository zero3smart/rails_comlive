require 'rails_helper'

feature 'Adding a reference to commodity' do
  given!(:user) { create(:user, email: 'user@example.com', password: 'secretpass') }
  given!(:app) { create(:app, user_id: user.id) }
  given(:reference) { build(:reference, app: app) }

  given(:generic_commodities) { create_list(:generic_commodity, 3, app_id: app.id) }
  given(:non_generic_commodities) { create_list(:non_generic_commodity, 3, app_id: app.id) }

  given(:generic_commodity) { generic_commodities.first }
  given(:non_generic_commodity) { non_generic_commodities.first }
  given(:generic_search_term) { generic_commodity.name.split(" ").first }
  given(:non_generic_search_term) { non_generic_commodity.name.split(" ").first }

  background do
    log_in(user)
    visit app_commodity_path(app, generic_commodity)
  end

  scenario 'User can add reference to a commodity', js: true do
    click_link "Add Reference"

    within("div#sharedModal") do
      select reference.kind, from: 'reference[kind]'
      select2("reference_source_commodity_id",generic_search_term, generic_commodity.id,generic_commodity.name)
      select2("reference_target_commodity_id",non_generic_search_term, non_generic_commodity.id,non_generic_commodity.name)
      fill_in 'reference[description]', with: reference.description

      click_button 'Submit'
    end

    expect(page).to have_content(generic_commodity.name)
    expect(page).to have_content(reference.kind)
    expect(page).to have_content(non_generic_commodity.name)
  end

end