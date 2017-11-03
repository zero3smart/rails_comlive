require 'rails_helper'

feature 'Adding specification to a commodity_reference' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity_reference) { create(:generic_commodity_reference, app_id: app.id) }
  given(:specification) { build(:spec_with_min_max, value: 34.90) }


  background do
    log_in(user)
    visit app_commodity_reference_path(app, commodity_reference)
  end

  feature 'User can add a specification to a commodity reference', js: true do
    background do
      click_link "Add Specification"
    end

    scenario "Providing only value" do
      within("div#sharedModal") do
        fill_in "specification[property]", with: specification.property
        fill_in "specification[value]", with: specification.value
        select specification.property, from: "type_of_measure"
        select "Joule (J)", from: "specification[uom]"
        select 'Private', from: 'specification[visibility]'

        click_button "Submit"
      end
      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.value)
      expect(page).to have_text("Private")
      expect(page).to have_text(specification.uom)
    end

    scenario "Providing either a min or a max" do
      within("div#sharedModal") do
        fill_in "specification[property]", with: specification.property
        choose('Define Min / Max')
        fill_in 'specification[min]', with: specification.min
        fill_in 'specification[max]', with: specification.max
        select specification.property, from: "type_of_measure"
        select "Joule (J)", from: "specification[uom]"
        select 'Public', from: 'specification[visibility]'

        click_button "Submit"
      end
      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.min)
      expect(page).to have_text(specification.max)
      expect(page).to have_text(specification.uom)
      expect(page).to have_text("Public")
    end
  end
end