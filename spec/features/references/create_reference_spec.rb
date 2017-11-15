require 'rails_helper'

feature 'Creating a Reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity) { create(:commodity) }
  given(:commodity_reference) { create(:commodity_reference, app: app, commodity: commodity) }
  given(:generic_commodity) { create(:generic_commodity) }
  given(:non_generic_commodity) { create(:non_generic_commodity) }
  given(:reference){ build(:reference) }

  background do
    log_in(user)
    visit new_app_commodity_reference_reference_path(app,commodity_reference)
  end

  context 'With valid details' do
    scenario 'user should successfully create a reference', js: true do
      generic_search_term = generic_commodity.name.split(" ").sample
      non_generic_search_term = non_generic_commodity.name.split(" ").sample

      select reference.kind, :from => "reference[kind]"
      select2("reference_source_commodity_id", generic_search_term, generic_commodity.id,generic_commodity.name)
      select2("reference_target_commodity_id", non_generic_search_term, non_generic_commodity.id, non_generic_commodity.name)

      fill_in "reference[description]", with: "A description for reference"

      click_button "Create Reference"

      page.execute_script("$('a[href=\"#tab-4\"]').tab('show')")
      expect(page).to have_text("reference successfully created")
      expect(page).to have_text(/A description/)
      expect(page).to have_text(reference.kind)
      expect(page).to have_text(generic_commodity.name)
      expect(page).to have_text(non_generic_commodity.name)
    end
  end

  context "With invalid details" do
    scenario 'reference should not be created' do
      fill_in "reference[description]", with: ""
      select reference.kind, :from => "reference[kind]"

      click_button "Create Reference"

      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Target commodity can't be blank")
      expect(page).to have_content("Source commodity can't be blank")
    end
  end
end