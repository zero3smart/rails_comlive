require 'rails_helper'

feature 'Adding a reference to commodity reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity) { create(:commodity) }
  given!(:commodity_reference) { create(:commodity_reference, commodity: commodity, app_id: app.id) }
  given(:reference) { build(:reference, app: app, commodity_reference: commodity_reference) }

  given(:commodities) { create_list(:commodity, 3) }

  given(:sample_commodity) { commodities.first }
  given(:search_term) { sample_commodity.name.split(" ").first }

  background do
    log_in(user)
    visit commodity_path(commodity)
  end

  scenario 'User can add reference to a commodity', js: true do
    find(".btn-add.icon.icon-circle.icon-md").click
    within("#modalAdd") do
      click_link "Reference"
    end

    select reference.kind.titleize, from: 'reference[kind]'
    select2("reference_source_commodity_id",search_term, sample_commodity.id,sample_commodity.name)
    select 'Private', from: 'reference[visibility]'
    # page.execute_script("$('#reference_visibility').selectpicker('val','privatized')")

    fill_in 'reference[description]', with: reference.description

    click_button 'Create Reference'

    page.execute_script("$('a[href=\"#tab-5\"]').tab('show')")

    within("#tab-5") do
      expect(page).to have_content(sample_commodity.name)
      expect(page).to have_content(reference.kind)
      expect(page).to have_content(/Private/i)
      expect(page).to have_content(commodity.name)
    end
  end

end
