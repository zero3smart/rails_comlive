require 'rails_helper'

feature 'Creating a Standard' do
  given!(:user){ create(:user) }
  given(:standard) { build(:standard) }

  background do
    log_in(user)
    visit new_standard_path
  end

  feature "Visiting #new page" do

    scenario "With correct details, user should successfully create a standard" do

      fill_in 'standard[name]', with: standard.name
      fill_in 'standard[description]', with: standard.description

      click_button "Create Standard"

      expect(page).to have_text("Standard successfully created")
      expect(page).to have_text(standard.name)
      expect(page).to have_text(standard.description)
    end

    scenario "With incorrect details, the custom unit should not be created" do

      fill_in "standard[name]", with: ""
      fill_in "standard[description]", with: standard.description

      click_button "Create Standard"

      expect(page).to have_text("New Standard")
      expect(page).to have_content("Name can't be blank")
    end
  end
end