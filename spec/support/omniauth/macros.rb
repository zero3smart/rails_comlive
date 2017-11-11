module Omniauth
  module Macros
    def mock_valid_auth_hash(user)
      # The mock_auth configuration allows you to set per-provider (or default)
      # authentication hashes to return during integration testing.
      opts = {
          "provider": user.provider,
          "uid": user.uid,
          "info": {
              "email": user.email,
              "first_name": user.first_name,
              "last_name": user.last_name,
          },
          "credentials": {
              "token": "XKLjnkKJj7hkHKJkk",
              "expires": true,
              "id_token": "eyJ0eXAiOiJK1VveHkwaTFBNXdTek41dXAiL.Wz8bwniRJLQ4Fqx_omnGDCX1vrhHjzw",
              "token_type": "Bearer"
          }
      }
      OmniAuth.config.mock_auth[:auth0] =  OmniAuth::AuthHash.new(opts)
    end

    def mock_invalid_auth_hash
      OmniAuth.config.mock_auth[:auth0] = :invalid_credentials
    end
  end
end