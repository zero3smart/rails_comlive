require 'rails_helper'

feature 'Invitations' do
  given(:user) { create(:user) }

  context "When current user is owner of the app" do
    given(:app) { user.default_app }

    background do
      log_in(user)
    end

    feature 'User can invite another user to an app' do
      background do
        visit app_path(app)
        click_link "Invite Users"
      end

      context "With a valid email" do
        scenario "It should successfully save the user" do
          fill_in "invitation[recipient_email]", with: "user@example.com"
          click_button "Send Invitation"

          expect(page).to have_text("Invitation sent to user@example.com")
        end
      end

      context "With an invalid email" do
        scenario "It should display email invalid error" do
          fill_in "invitation[recipient_email]", with: "userexample.com"
          click_button "Send Invitation"

          expect(page).to have_text("Recipient email is invalid")
        end
      end
    end
  end

  context "When current user is not owner of the app" do
    given(:app) { create(:app) }

    background do
      log_in(user)
    end

    scenario "User should not be able to invite users to the app" do
      visit new_app_invitation_path(app)
      expect(page).to have_text("You are not authorized to perform this action.")
    end
  end
end
