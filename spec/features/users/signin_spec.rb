require 'rails_helper'

feature 'Login with Omniauth' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }

  context "With valid credentials" do
    scenario 'Should successfully login user' do
      log_in(user)

      expect(page).to have_content('Signed in successfully')
      expect(page).to have_link("Logout", href: logout_path)
    end

    scenario "Should redirect to last visited app if user visited app" do
      log_in(user)
      visit app_path(app)
      click_link "Logout"

      log_in(user)

      expect(page.current_path).to eq app_path(app)
    end

    scenario "should redirect to root path if no last visited app" do
      log_in(user)
      click_link "Logout"
      log_in(user)
      expect(page.current_path).to eq root_path
    end
  end

  context "With invalid credentials" do
    scenario "Should not log in user" do
      log_in(user, true)
      expect(page).to have_content('invalid_credentials')
    end
  end
end