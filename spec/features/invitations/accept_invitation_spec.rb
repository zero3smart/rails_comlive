require 'rails_helper'

feature 'Accept Invitation' do
  given(:user) { create(:user) }
  given(:apps) { user.apps << create(:app) } # creates a membership record
  given(:app) { apps.first }
  given(:invitation) { create(:invitation, app: app, recipient_email: user.email) }

  background do
    mock_accept_invitation(user, invitation.token)
  end

  scenario "User can accept an invitation" do
    expect(page).to have_text app.name
    expect(page).to have_text "Signed in successfully"
  end
end