require 'rails_helper'

feature 'Login with Omniauth' do
  given!(:user) { create(:user) }
  given(:app) { create(:app, user: user) }

  context "With valid credentials" do
    scenario 'Should successfully login user' do
      login(user)

      expect(page).to have_content('Signed in successfully')
      expect(page).to have_link("Logout", href: logout_path)
    end

    scenario "Should redirect to last visited app if user visited app" do
      login(user)
      visit app_path(app)
      click_link "Logout"

      login(user)

      expect(page.current_path).to eq app_path(app)
    end

    scenario "should redirect to root path if no last visited app" do
      login(user)
      click_link "Logout"
      login(user)
      expect(page.current_path).to eq root_path
    end
  end

  context "With invalid credentials" do
    scenario "Should not log in user" do
      login(user,true)
      expect(page).to have_content('invalid_credentials')
    end
  end
end