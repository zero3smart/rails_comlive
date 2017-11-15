require 'rails_helper'

feature 'Adding a reference to commodity reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity) { create(:commodity) }
  given!(:commodity_reference) { create(:commodity_reference, commodity: commodity, app_id: app.id) }
  given(:reference) { build(:reference, app: app, commodity_reference: commodity_reference) }

  given(:generic_commodities) { create_list(:generic_commodity, 3) }
  given(:non_generic_commodities) { create_list(:non_generic_commodity, 3) }

  given(:generic_commodity) { generic_commodities.first }
  given(:non_generic_commodity) { non_generic_commodities.first }
  given(:generic_search_term) { generic_commodity.name.split(" ").first }
  given(:non_generic_search_term) { non_generic_commodity.name.split(" ").first }

  background do
    log_in(user)
    visit commodity_path(commodity)
  end

  scenario 'User can add reference to a commodity', js: true do
    find(".btn-add.icon.icon-circle.icon-md").click
    within("#modalAdd") do
      click_link "Reference"
    end

    select reference.kind, from: 'reference[kind]'
    select2("reference_source_commodity_id",generic_search_term, generic_commodity.id,generic_commodity.name)
    select2("reference_target_commodity_id",non_generic_search_term, non_generic_commodity.id,non_generic_commodity.name)
    select 'Private', from: 'reference[visibility]'
    fill_in 'reference[description]', with: reference.description

    click_button 'Create Reference'

    page.execute_script("$('a[href=\"#tab-4\"]').tab('show')")

    expect(page).to have_content(generic_commodity.name)
    expect(page).to have_content(reference.kind)
    expect(page).to have_content(/Private/i)
    expect(page).to have_content(non_generic_commodity.name)
  end

end