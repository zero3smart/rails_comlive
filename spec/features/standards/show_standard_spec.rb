require 'rails_helper'

feature 'Viewing a standard' do
  given!(:user){ create(:user) }
  given!(:standard) { create(:standard) }

  background do
    log_in(user)
    visit standard_path(standard)
  end

  feature "Visiting #show page" do
    scenario "It should show the standard's details" do
      expect(page).to have_text(standard.name)
      expect(page).to have_text(standard.description)
    end
  end
end