require 'rails_helper'

feature 'User logout' do
  given!(:user) { create(:user) }

  background do
    login(user)
  end

  scenario 'Should Logout user from system' do
    click_link "Logout"
    expect(page).to have_content("Signed out successfully.")
  end
end