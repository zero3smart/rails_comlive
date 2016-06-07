require 'rails_helper'

feature 'User signs in' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'secretpass')
  end

  scenario 'with valid email and password' do
    sign_in_with(@user.email, @user.password)

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_link("Logout", href: destroy_user_session_path)
  end

  scenario "with invalid email" do
    sign_in_with('invalid.com', 'secretpass')

    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "with invalid password" do
    sign_in_with(@user.email, 'invalidpass')

    expect(page).to have_content("Invalid Email or password.")
  end

  def sign_in_with(email, password)
    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end