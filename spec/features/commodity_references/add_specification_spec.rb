require 'rails_helper'

feature 'Adding specification to a commodity_reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity) { create(:commodity) }
  given!(:commodity_reference) { create(:commodity_reference, commodity: commodity, app_id: app.id) }
  given(:specification) { build(:spec_with_min_max, value: 34.90) }


  background do
    log_in(user)
    visit commodity_path(commodity)
  end

  feature 'User can add a specification to a commodity reference', js: true do
    background do
      find(".btn-add.icon.icon-circle.icon-md").click
      within("#modalAdd") do
        click_link "Specification"
      end
    end

    scenario "Providing only value" do
      fill_in "specification[property]", with: specification.property
      fill_in "specification[value]", with: specification.value
      select specification.property, from: "type_of_measure"
      select "Joule (J)", from: "specification[uom]"
      select 'Private', from: 'specification[visibility]'

      click_button "Create Specification"

      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.value)
      expect(page).to have_text(/Private/i)
      expect(page).to have_text(specification.uom)
    end

    scenario "Providing either a min or a max" do

      fill_in "specification[property]", with: specification.property
      find(:css, 'label[for="value-opts_min-max"]').click
      fill_in 'specification[min]', with: specification.min
      fill_in 'specification[max]', with: specification.max
      select specification.property, from: "type_of_measure"
      select "Joule (J)", from: "specification[uom]"
      select 'Public', from: 'specification[visibility]'

      click_button "Create Specification"

      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.min)
      expect(page).to have_text(specification.max)
      expect(page).to have_text(specification.uom)
      expect(page).to have_text(/Public/i)
    end
  end
end