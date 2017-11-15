require 'rails_helper'

feature 'Accept Invitation' do
  given(:user) { create(:user) }
  given(:app) { create(:app) }
  given(:invitation) { create(:invitation, app: app, recipient_email: user.email) }

  context "When user signed in" do
    background do
      log_in(user)
      visit accept_invitation_path(invitation.token)
    end

    scenario "User can accept an invitation" do
      expect(page).to have_text app.name
      expect(page).to have_text "Invitation accepted"
    end
  end

  context "When user not signed in" do
    background do
      mock_accept_invitation(user, invitation.token)
    end

    scenario "User can accept an invitation" do
      expect(page).to have_text app.name
      expect(page).to have_text "Signed in successfully"
    end
  end
end