require 'rails_helper'

feature 'Updating a Reference' do
  given!(:user) { create(:user, email: 'user@example.com', password: 'secretpass') }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity_reference) { create(:non_generic_commodity_reference, app_id: app.id) }
  given!(:reference){ create(:reference, app_id: app.id, target_commodity_reference_id: commodity_reference.id) }

  background do
    log_in(user)
    visit edit_app_reference_path(app, reference)
  end

  feature "Visiting #edit page" do
    scenario "Should show the current reference's details" do
      expect(page).to have_text("Edit Reference")
      expect(page).to have_select('reference[kind]', selected: reference.kind)
      # expect(page).to have_select('reference_source_commodity_id', selected: @reference.source_commodity.short_description)
      # expect(page).to have_select('reference_target_commodity_id', selected: @reference.target_commodity.short_description)
      expect(find_field('reference[description]').value).to eq reference.description
    end
  end

  context "With valid details" do
    scenario "should successfully update the reference" do
      fill_in "reference[description]", with: "description of reference updated"
      select "alternative_to", :from => "reference[kind]"

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

      expect(page).to have_text("Description can't be blank")
    end
  end




end