class TokenRefresher
  attr_reader :client_id, :refresh_token

  def initialize(refresh_token)
    @refresh_token = refresh_token
    @client_id     = ENV["AUTH0_API_KEY"]
  end

  def request
    uri    = URI.parse("https://ntty.eu.auth0.com/delegation")
    params = {
        client_id: client_id,
        grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
        refresh_token: refresh_token,
        api_type: "app"
    }

    response = Net::HTTP.post_form(uri, params)

    return JSON.parse(response.body)
  end
end