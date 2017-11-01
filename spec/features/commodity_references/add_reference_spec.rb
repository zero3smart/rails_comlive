require 'rails_helper'

feature 'Adding a reference to commodity reference' do
  given(:user) { create(:user) }
  given(:apps) { user.apps << create(:app) } # creates a membership record
  given(:app) { apps.first }
  given(:reference) { build(:reference, app: app) }

  given(:generic_commodity_references) { create_list(:generic_commodity_reference, 3, app_id: app.id) }
  given(:non_generic_commodity_references) { create_list(:non_generic_commodity_reference, 3, app_id: app.id) }

  given(:generic_commodity_reference) { generic_commodity_references.first }
  given(:non_generic_commodity_reference) { non_generic_commodity_references.first }
  given(:generic_search_term) { generic_commodity_reference.name.split(" ").first }
  given(:non_generic_search_term) { non_generic_commodity_reference.name.split(" ").first }

  background do
    log_in(user)
    visit app_commodity_reference_path(app, generic_commodity_reference)
  end

  scenario 'User can add reference to a commodity', js: true do
    click_link "Add Reference"

    within("div#sharedModal") do
      select reference.kind, from: 'reference[kind]'
      select2("reference_source_commodity_reference_id",generic_search_term, generic_commodity_reference.id,generic_commodity_reference.name)
      select2("reference_target_commodity_reference_id",non_generic_search_term, non_generic_commodity_reference.id,non_generic_commodity_reference.name)
      fill_in 'reference[description]', with: reference.description

      click_button 'Submit'
    end

    expect(page).to have_content(generic_commodity_reference.name)
    expect(page).to have_content(reference.kind)
    expect(page).to have_content(non_generic_commodity_reference.name)
  end

end