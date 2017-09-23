require 'rails_helper'

feature 'Updating a Reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:reference){ create(:reference, commodity_reference: commodity_reference) }

  background do
    log_in(user)
    visit edit_app_commodity_reference_reference_path(app, commodity_reference, reference)
  end

  feature "Visiting #edit page" do
    scenario "Should show the current reference's details" do
      expect(page).to have_text(I18n.t("references.edit.title"))
      expect(page).to have_text(reference.source_commodity.name)
      expect(page).to have_select('reference[kind]', selected: reference.kind.titleize)
      expect(page).to have_select('reference_source_commodity_id', selected: reference.source_commodity.name)
      expect(find_field('reference[description]').value).to eq reference.description
    end
  end

  context "With valid details" do
    scenario "should successfully update the reference" do
      fill_in "reference[description]", with: "description of reference updated"
      select "alternative_to".titleize, :from => "reference[kind]"

      click_button "Update Reference"

      expect(page).to have_text("reference successfully updated")
      expect(page).to have_text("description of reference updated")
      expect(page).to have_text("alternative_to")
    end
  end

  context "With invalid details" do
    scenario "should not update the reference" do
      fill_in "reference[description]", with: ""

      click_button "Update Reference"

      expect(page).to have_text("can't be blank")
    end
  end
end
