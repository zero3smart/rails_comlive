require 'rails_helper'

feature 'Invitations' do
  given(:user) { create(:user) }
  given(:app) { create(:app) }

  background do
    log_in(user)
  end

  context "When current user is owner of the app" do
    feature 'User can invite another user to an app' do
      given!(:membership) { create(:membership, user: user, member: app, owner: true) }

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
    scenario "User should not see the invite user link" do
      visit app_path(app)

      expect(page).not_to have_link("Invite Users")
    end
  end
end