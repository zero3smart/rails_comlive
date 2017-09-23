require 'rails_helper'

feature 'Creating a Reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity) { create(:commodity) }
  given(:commodity_reference) { create(:commodity_reference, app: app, commodity: commodity) }
  given(:generic_commodity) { create(:generic_commodity) }
  given(:reference){ build(:reference) }

  background do
    log_in(user)
    visit new_app_commodity_reference_reference_path(app,commodity_reference)
  end

  context 'With valid details' do
    scenario 'user should successfully create a reference', js: true do
      search_term = generic_commodity.name.split(" ").sample

      select reference.kind.titleize, :from => "reference[kind]"
      select2("reference_source_commodity_id", search_term, generic_commodity.id,generic_commodity.name)

      fill_in "reference[description]", with: "A description for reference"

      click_button "Create Reference"

      page.execute_script("$('a[href=\"#tab-5\"]').tab('show')")
      expect(page).to have_text("reference successfully created")
      within("#tab-5") do
        expect(page).to have_text(/A description/)
        expect(page).to have_text(reference.kind)
        expect(page).to have_text(generic_commodity.name)
        expect(page).to have_text(commodity.name)
      end
    end
  end

  context "With invalid details" do
    scenario 'reference should not be created' do
      fill_in "reference[description]", with: ""
      select reference.kind.titleize, :from => "reference[kind]"

      click_button "Create Reference"

      expect(page).to have_content("can't be blank", count: 2)
    end
  end
end
