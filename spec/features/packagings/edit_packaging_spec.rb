require 'rails_helper'

feature 'Updating packaging details' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity) { create(:commodity) }
  given(:commodity_reference) { create(:commodity_reference, commodity: commodity, app_id: app.id) }
  given(:packaging) { create(:packaging, commodity_reference_id: commodity_reference.id) }

  background do
    log_in(user)
    visit edit_app_commodity_reference_packaging_path(app, commodity_reference, packaging)
  end

  scenario "It should show the current packaging details" do
    expect(page).to have_text(I18n.t("packagings.edit.title"))
    expect(find_field('packaging[name]').value).to eq packaging.name
    expect(find_field('packaging[description]').value).to eq packaging.description
    expect(find_field('packaging[quantity]').value).to eq packaging.quantity.to_s
    expect(find_field('packaging[uom]').value).to eq packaging.uom
  end


  scenario 'User can update packaging details', js: true do
    fill_in 'packaging[name]', with: "Packets of Milk"
    fill_in 'packaging[description]',with: "A short description"
    fill_in 'packaging[quantity]', with: "40"
    fill_in 'packaging[uom]', with: "packets"

    page.execute_script("$('.selectpicker').selectpicker('val','privatized');")
    # select 'Private', from: 'packaging[visibility]'

    click_button 'Update Packaging'

    page.execute_script("$('a[href=\"#tab-2\"]').tab('show')")

    expect(page).to have_text("Packets of Milk")
    expect(page).to have_text("A short description")
    expect(page).to have_content("40")
    expect(page).to have_content("packets")
    expect(page).to have_content(/Private/i)
    expect(page).to have_content("Packaging successfully updated")
  end

end
