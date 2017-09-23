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
      page.execute_script("$('#commodity_measured_in').selectpicker('val','number')")

      # find('label[for="commodity_generic"]').click
      # check('commodity[generic]')

      click_button "Create Commodity"

      expect(page).to have_text(I18n.t("commodities.messages.created"))
      expect(page).to have_text(commodity.name)
    end

    scenario "With all possible details", js: true do
      fill_in "commodity[name]", with: commodity.name
      # select "Mass", from: "commodity[measured_in]"
      page.execute_script("$('#commodity_measured_in').selectpicker('val','mass')")
      fill_in "commodity[short_description]", with: commodity.short_description
      # fill_in "commodity[long_description]", with: commodity.long_description

      # check('commodity[generic]')
      # find('label[for="commodity_generic"]').click

      click_button "Create Commodity"

      expect(page).to have_text(I18n.t("commodities.messages.created"))
      expect(page).to have_text(commodity.name)
      expect(page).to have_text(commodity.short_description)
    end
  end

  context "Creating a non generic commodity" do
    scenario "it should successfully create the commodity", js: true do
      page.execute_script("$('input#product').click()")

      fill_in "commodity[name]", with: commodity.name
      fill_in "commodity[short_description]", with: commodity.short_description
      select brand.name, from: "commodity[brand_id]"

      page.execute_script("$('#commodity_measured_in').selectpicker('val','length')")

      click_button "Create Commodity"

      expect(page).to have_text(commodity.name)
      expect(page).to have_text(commodity.short_description)
      expect(page).to have_text(I18n.t("commodities.messages.created"))
    end
  end

  context "With invalid details" do
    scenario "Commodity should not be created", js: true do
      page.execute_script("$('input#product').click()")

      fill_in 'commodity[name]', with: ''

      click_button "Create Commodity"

      expect(page).to have_text(I18n.t("commodities.new.title"))
      expect(page).to have_content("can't be blank", count: 3)
    end
  end
end
