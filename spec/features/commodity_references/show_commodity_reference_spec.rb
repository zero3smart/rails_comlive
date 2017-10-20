require 'rails_helper'

feature 'Invitations' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }

  background do
    log_in(user)
    visit app_path(app)
  end

  feature 'User can invite another user to an app', js: true do
    background do
      click_link "Invite Users"
    end

    context "With a valid email" do
      scenario "It should successfully save the user" do
        within("div#sharedModal") do
          fill_in "email", with: "user@example.com"

          click_button "Submit"
        end
        expect(page).to have_text("Invitation sent to user@example.com")
      end
    end

    context "With an invalid email" do
      scenario "It should display email invalid error" do
        within("div#sharedModal") do
          fill_in "email", with: "userexample.com"

          click_button "Submit"
        end
        expect(page).to have_text("Email is invalid")
      end
    end
  end
end