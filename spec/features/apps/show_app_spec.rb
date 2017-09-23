require 'rails_helper'

feature 'Viewing an app' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }

  background do
    log_in(user)
    visit app_path(app)
  end

  scenario "should show the app details" do
    expect(page).to have_text(app.name)
    expect(page).to have_text(app.description)
  end
end
