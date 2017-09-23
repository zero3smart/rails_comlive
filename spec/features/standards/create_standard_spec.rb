require 'rails_helper'

feature 'Creating a Standard' do
  given!(:user){ create(:user) }
  given!(:brand) { create(:brand) }
  given(:standard) { build(:standard) }

  background do
    log_in(user)
    visit new_brand_standard_path(brand)
  end

  feature "Visiting #new page" do

    scenario "With correct details, user should successfully create a standard" do

      fill_in 'standard[name]', with: standard.name
      fill_in 'standard[code]', with: standard.code
      fill_in 'standard[version]', with: standard.version
      fill_in 'standard[description]', with: standard.description
      fill_in 'standard[certifier]', with: standard.certifier
      fill_in 'standard[certifier_url]', with: standard.certifier_url

      click_button "Create Standard"

      expect(page).to have_text("Standard successfully created")
      expect(page).to have_text(standard.name)
      expect(page).to have_text(standard.code)
      expect(page).to have_text(standard.description)
      expect(page).to have_link("Official Website", href: standard.certifier_url)
    end

    scenario "With incorrect details, the custom unit should not be created" do

      fill_in "standard[name]", with: ""
      fill_in "standard[description]", with: ""

      click_button "Create Standard"

      expect(page).to have_text("New Standard")
      expect(page).to have_content("can't be blank", count: 4)
    end
  end
end
