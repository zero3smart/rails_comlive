require 'rails_helper'

feature 'Adding specification to a packaging' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:packaging) { create(:packaging, commodity_reference_id: commodity_reference.id) }
  given(:specification) { build(:spec_with_min_max, value: 34.90) }

  background do
    log_in(user)
    visit app_commodity_reference_packaging_path(app, commodity_reference, packaging)
    click_link "Add Specification"
  end

  feature 'User can add a specification to a packaging', js: true do
    scenario "Providing only value" do
      page.execute_script("$('input[value=\"custom\"]').click()") # switch tab

      fill_in "specification[property]", with: specification.property
      fill_in "specification[value]", with: specification.value
      select specification.property, from: "type_of_measure"
      select "Joule (J)", from: "specification[uom]"

      click_button "Create Specification"

      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.value)
      expect(page).to have_text(specification.uom)
    end

    scenario "Providing either a min or a max" do
      page.execute_script("$('input[value=\"custom\"]').click()") # switch tab

      fill_in "specification[property]", with: specification.property
      find(:css, 'label[for="value-opts_min-max"]').click
      fill_in 'specification[min]', with: specification.min
      fill_in 'specification[max]', with: specification.max
      select specification.property, from: "type_of_measure"
      select "Joule (J)", from: "specification[uom]"

      click_button "Create Specification"

      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.min)
      expect(page).to have_text(specification.max)
      expect(page).to have_text(specification.uom)
    end
  end
end
