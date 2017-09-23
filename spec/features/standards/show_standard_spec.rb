require 'rails_helper'

feature 'Visiting #show page' do
  given(:user){ create(:user) }
  given(:brand) { create(:brand) }
  given(:standard) { create(:standard) }

  context "When user is signed in" do
    background do
      log_in(user)
      visit brand_standard_path(brand, standard)
    end

    scenario "It should show the standard's details" do
      expect(page).to have_text(standard.name)
      expect(page).to have_text(standard.description)
    end
  end

  context "When user is not signed in" do
    background do
      visit slugged_standard_path(uuid: standard.uuid, title: standard.name)
    end

    scenario "It should show the standard's details" do
      expect(page).to have_text(standard.name)
      expect(page).to have_text(standard.description)
    end
  end
end
