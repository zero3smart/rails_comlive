module Features
  module SessionHelpers

    def log_in(user, invalid=false, strategy = :auth0)
      invalid ?  mock_invalid_auth_hash : mock_valid_auth_hash(user)
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[strategy.to_sym]
      visit "/auth/#{strategy.to_s}/callback?code=vihipkGaumc5IVgs"
    end

    def mock_accept_invitation(user, token, strategy = :auth0)
      mock_valid_auth_hash(user)
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[strategy.to_sym]
      visit "/auth/#{strategy.to_s}/callback?code=vihipkGaumc5IVgs&state=#{token}"
    end

    # def log_in(user)
    #   sign_in_with(user.email, user.password)
    # end
    #
    # def sign_in_with(email, password)
    #   visit root_path
    #   click_button "LOGIN"
    #
    #   fill_in 'Email', with: email
    #   fill_in 'Password', with: password
    #   click_button 'SIGN IN'
    # end
    #
    # def sign_up_with(email, password, confirmation=nil)
    #   confirmation = confirmation.nil? ? password : confirmation
    #
    #   visit new_user_registration_path
    #
    #   fill_in 'Email', with: email
    #   fill_in 'user_password', with: password
    #   fill_in 'user_password_confirmation', with: confirmation
    #   click_button 'SIGN UP'
    # end
  end
end
