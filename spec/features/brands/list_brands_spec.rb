require 'rails_helper'

feature 'Viewing a Brand' do
  given(:user) { create(:user) }
  given!(:brands) { create_list(:brand, 3) }

  context "When user is logged in" do
    background do
      log_in(user)
      visit brands_path
    end

    scenario "User should see a list of brands" do
      brands.each do |brand|
        expect(page).to have_content(brand.name)
      end
    end
  end

  context "When user is not logged in" do
    background do
      visit brands_path
    end

    scenario "User should see a list of brands" do
      brands.each do |brand|
        expect(page).to have_content(brand.name)
      end
    end
  end
end