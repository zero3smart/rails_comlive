module Controllers
  module RequestHelpers
    def sign_in(user)
      @request.session[:user_id] = user.id
    end

    def setup_omniauth_mock
      opts = {
          "provider": "auth0",
          "uid": "auth0|57c5379f0d498c4d7e49fa40",
          "info": {
              "email": "user@example.com",
              "first_name": "Fredrick",
              "last_name": "Mayor",
          },
          "credentials": {
              "token": "aet3Nty0WBYcjoXn",
          }
      }
      OmniAuth.config.mock_auth[:auth0] =  OmniAuth::AuthHash.new(opts)
    end
  end
end