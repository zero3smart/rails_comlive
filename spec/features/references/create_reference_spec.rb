require 'rails_helper'

feature 'Creating a Reference' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:generic_commodity_reference) { create(:generic_commodity_reference) }
  given!(:non_generic_commodity_reference) { create(:non_generic_commodity_reference) }
  given!(:reference){ build(:reference) }

  background do
    log_in(user)
    visit new_app_reference_path(app)
  end

  context 'With valid details' do
    scenario 'user should successfully create a reference', js: true do
      generic_search_term = generic_commodity_reference.name.split(" ").sample
      non_generic_search_term = non_generic_commodity_reference.name.split(" ").sample

      select reference.kind, :from => "reference[kind]"
      select2("reference_source_commodity_reference_id", generic_search_term, generic_commodity_reference.id,generic_commodity_reference.name)
      select2("reference_target_commodity_reference_id", non_generic_search_term, non_generic_commodity_reference.id, non_generic_commodity_reference.name)

      fill_in "reference[description]", with: reference.description

      click_button "Create Reference"

      expect(page).to have_text("reference successfully created")
      expect(page).to have_text(reference.description)
      expect(page).to have_text(reference.kind)
    end
  end

  context "With invalid details" do
    scenario 'reference should not be created' do
      fill_in "reference[description]", with: ""
      select reference.kind, :from => "reference[kind]"

      click_button "Create Reference"

      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Target commodity reference can't be blank")
      expect(page).to have_content("Source commodity reference can't be blank")
    end
  end
end