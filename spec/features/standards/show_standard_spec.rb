require 'rails_helper'

feature 'Visiting #show page' do
  given(:user){ create(:user) }
  given(:standard) { create(:standard) }

  context "When user is signed in" do
    background do
      log_in(user)
      visit standard_path(standard)
    end

    scenario "It should show the standard's details" do
      expect(page).to have_text(standard.name)
      expect(page).to have_text(standard.description)
      expect(page).to have_link("Claim This Standard")
    end
  end

  context "When user is not signed in" do
    background do
      visit slugged_standard_path(uuid: standard.uuid, title: standard.name)
    end

    scenario "It should show the standard's details" do
      expect(page).to have_text(standard.name)
      expect(page).to have_text(standard.description)
      expect(page).not_to have_link("Claim This Standard")
    end
  end
end