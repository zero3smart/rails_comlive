require 'rails_helper'

feature 'App Management' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'secretpass')
    sign_in(@user)
  end

  scenario "User can create app with valid app details" do
    visit new_app_path

    app = build(:app)

    fill_in "Description", with: app.description
    click_button "Create App"

    expect(page).to have_text("app created successfully")
    expect(page).to have_text(app.description)
  end

  scenario "does not allow app creation with description blank" do
    visit new_app_path

    fill_in "Description", with: ""
    click_button "Create App"

    expect(page).to have_text("Create App")
    expect(page).to have_text("Description can't be blank")
  end

  scenario "allows user to edit app" do
    app = create(:app, user_id: @user.id)

    visit edit_app_path(app)

    fill_in "Description", with: "updated app description"
    click_button "Update App"

    expect(page).to have_text("app updated successfully")
    expect(page).to have_text("updated app description")
  end

  scenario "user can view app" do
    app = create(:app, user_id: @user.id)

    visit app_path(app)
    expect(page).to have_text(app.description)
  end

  def sign_in(user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end