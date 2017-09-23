require 'rails_helper'

feature 'App Creation' do
  given(:user) { create(:user)  }
  given(:app) { build(:app) }

  background do
    log_in(user)
  end

  scenario "With valid details" do
    visit new_app_path

    fill_in "app[name]", with: app.name
    fill_in "app[description]", with: app.description

    click_button "Create App"

    expect(page).to have_text("app created successfully")
    expect(page).to have_text(app.name)
    expect(page).to have_text(app.description)
  end

  scenario "With invalid details" do
    visit new_app_path

    fill_in "app[name]", with: ""

    click_button "Create App"

    expect(page).to have_text("Create App")
    expect(page).to have_text("can't be blank")
  end
end
