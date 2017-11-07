require 'rails_helper'

feature 'Custom units View' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }

  background do
    log_in(user)
  end

  feature "Visiting #index page" do
    scenario "With units present, it should list available units" do
      unit_1 = create(:custom_unit, app_id: app.id)
      unit_2 = create(:custom_unit, app_id: app.id)

      visit app_custom_units_path(app)

      expect(page).to have_text("Property: #{unit_1.property} Uom: #{unit_1.uom}")
      expect(page).to have_text("Property: #{unit_2.property} Uom: #{unit_2.uom}")
    end

    scenario "With no units present, it should display no custom units found" do
      visit app_custom_units_path(app)

      expect(page).to have_text("No custom units found")
    end
  end

  feature "Visiting #new page" do
    background do
      visit new_app_custom_unit_path(app)
    end

    scenario "With correct details, user should successfully create a custom unit" do

      fill_in "Property", with: "weight scale"
      fill_in "Uom", with: "wallets"

      click_button "Create Custom unit"

      expect(page).to have_text("Custom unit successfully created")
      expect(page).to have_text("Property: weight scale Uom: wallets")
    end

    scenario "With incorrect details, the custom unit should not be created" do

      fill_in "Property", with: ""
      fill_in "Uom", with: ""

      click_button "Create Custom unit"

      expect(page).to have_text("New Custom Unit")
      expect(page).to have_content("Property can't be blank")
      expect(page).to have_content("Uom can't be blank")
    end
  end

  feature "Visiting #show page" do
    scenario "It should show the custom unit's details" do
      custom_unit = create(:custom_unit, app_id: app.id)
      visit app_custom_unit_path(app, custom_unit)

      expect(page).to have_text("Custom Unit Details")
      expect(page).to have_text("Property: #{custom_unit.property} Uom: #{custom_unit.uom}")
    end
  end

  feature "Visiting #edit page" do
    background do
      @custom_unit = create(:custom_unit, app_id: app.id)
      visit edit_app_custom_unit_path(app, @custom_unit)
    end

    scenario "should show the current unit's details" do

      expect(page).to have_text("Edit Custom Unit")
      expect(find_field('Property').value).to eq @custom_unit.property.to_s
      expect(find_field('Uom').value).to eq @custom_unit.uom.to_s
    end

    feature "with valid details" do
      scenario "user should be able to update the custom unit" do

        fill_in "Property", with: "Molarity"
        fill_in "Uom", with: "Moles"

        click_button "Update Custom unit"

        expect(page).to have_text("Unit successfully updated")
        expect(page).to have_text("Property: Molarity Uom: Moles")
      end
    end

    feature "with invalid details" do
      scenario "user should not be able to update the measurement" do
        fill_in "Property", with: ""
        click_button "Update Custom unit"

        expect(page).to have_text("Edit Custom Unit")
        expect(page).to have_text("Property can't be blank")
      end
    end
  end
end