module Features
  module SessionHelpers
    def log_in(user)
      sign_in_with(user.email, user.password)
    end

    def sign_in_with(email, password)
      visit new_user_session_path

      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'SIGN IN'
    end

    def sign_up_with(email, password, confirmation=nil)
      confirmation = confirmation.nil? ? password : confirmation

      visit new_user_registration_path

      fill_in 'Email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: confirmation
      click_button 'SIGN UP'
    end
  end
end