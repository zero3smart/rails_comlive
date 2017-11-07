require 'rails_helper'

feature 'Updating app' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }

  background do
    log_in(user)
    visit edit_app_path(app)
  end

  scenario "With valid details" do

    fill_in "app[name]", with: "Western Digital"
    fill_in "app[description]", with: "updated app description"

    click_button "Update App"

    expect(page).to have_text("app updated successfully")
  end

  scenario "With invalid details" do
    fill_in "app[name]", with: ""
    click_button "Update App"

    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Update App")
  end
end