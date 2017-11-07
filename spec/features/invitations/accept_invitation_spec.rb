require 'rails_helper'

feature 'Accept Invitation' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:invitation) { create(:invitation, app: app, recipient_email: user.email) }

  background do
    mock_accept_invitation(user, invitation.token)
  end

  scenario "User can accept an invitation" do
    expect(page).to have_text app.name
    expect(page).to have_text "Signed in successfully"
  end
end