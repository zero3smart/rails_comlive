require 'rails_helper'

feature 'Invitations' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }

  background do
    log_in(user)
    visit app_path(app)
  end

  feature 'User can invite another user to an app' do
    background do
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