require 'rails_helper'

feature 'Viewing a Brand' do
  given(:user) { create(:user) }
  given(:brand) { create(:brand) }

  context "When user is logged in" do
    background do
      log_in(user)
      visit brand_path(brand)
    end

    scenario "User should see the brands details" do
      expect(page).to have_content(brand.name)
      expect(page).to have_content(brand.description)
      expect(page).to have_link("Edit", href: edit_brand_path(brand))
      expect(page).to have_link("Claim This Brand")
      expect(page).to have_link("Assign Standard")
    end
  end

  context "When user is not logged in" do
    background do
      visit slugged_brand_path(uuid: brand.uuid, title: brand.name)
    end

    scenario "User should see only the public brands details" do
      expect(page).to have_content(brand.name)
      expect(page).to have_content(brand.description)
      expect(page).not_to have_link("Edit", href: edit_brand_path(brand))
      expect(page).not_to have_link("Claim This Brand")
      expect(page).not_to have_link("Assign Standard")
    end
  end
end