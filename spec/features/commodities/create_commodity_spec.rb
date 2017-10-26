require 'rails_helper'

feature 'Commodity creation' do
  given!(:user) { create(:user) }
  given!(:brand) { create(:brand) }

  given(:commodity) { build(:commodity, short_description: "short description", long_description: "very long description") }

  background do
    log_in(user)
    visit new_commodity_path
  end

  context "Creating a generic commodity" do
    scenario "With the minimum required details", js: true do
      fill_in "commodity[name]", with: commodity.name
      select "area", from: "commodity[measured_in]"

      find('label[for="commodity_generic"]').click
      # check('commodity[generic]')

      click_button "Create Commodity"

      expect(page).to have_text("commodity successfully created")
      expect(page).to have_text(commodity.name)
      expect(page).to have_text("THIS IS A GENERIC COMMODITY")
    end

    scenario "With all possible details", js: true do
      fill_in "commodity[name]", with: commodity.name
      select "mass", from: "commodity[measured_in]"
      fill_in "commodity[short_description]", with: commodity.short_description
      fill_in "commodity[long_description]", with: commodity.long_description

      # check('commodity[generic]')
      find('label[for="commodity_generic"]').click

      click_button "Create Commodity"

      expect(page).to have_text("commodity successfully created")
      expect(page).to have_text("THIS IS A GENERIC COMMODITY")
      expect(page).to have_text(commodity.name)
      expect(page).to have_text(commodity.short_description)
      expect(page).to have_text(commodity.long_description)
    end
  end

  context "Creating a non generic commodity" do
    scenario "it should successfully create the commodity" do
      fill_in "commodity[name]", with: commodity.name
      select "time", from: "commodity[measured_in]"
      select brand.name, from: "commodity[brand_id]"


      click_button "Create Commodity"

      expect(page).to have_text(commodity.name)
      expect(page).to have_text("commodity successfully created")
      expect(page).not_to have_text("THIS IS A GENERIC COMMODITY")
    end
  end

  context "With invalid details" do
    scenario "Commodity should not be created" do
      fill_in 'commodity[name]', with: ''

      click_button "Create Commodity"

      expect(page).to have_text("New Commodity")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Brand can't be blank")
      expect(page).to have_content("Measured in can't be blank")
    end
  end
end