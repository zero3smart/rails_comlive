require 'rails_helper'

feature 'Updating a Brand' do
  given!(:user) { create(:user) }
  given!(:brand) { create(:brand) }

  background do
    log_in(user)
    visit edit_brand_path(brand)
  end

  context "With valid details" do
    scenario "it should successfully update the brand" do
      fill_in 'brand[name]', with: "Samsung"
      fill_in 'brand[description]', with: "Plays nicely with kaminari and will_paginate."

      click_button 'Update Brand'

      expect(page).to have_content("brand successfully updated")
      expect(page).to have_content("Samsung")
      expect(page).to have_content("Plays nicely with kaminari and will_paginate.")
    end
  end

  context "With invalid details" do
    scenario 'it should not update the brand' do
      fill_in 'brand[name]', with: ''
      fill_in 'brand[description]', with: ''

      click_button 'Update Brand'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
  end
end