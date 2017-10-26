require 'rails_helper'

RSpec.describe Auth0Controller, :type => :controller do

  describe "GET #callback" do
    before(:each) do
      setup_omniauth_mock
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:auth0]
    end

    it "logs in the user" do
      get :callback, params: { code: "ksdf89sdf" }
      expect(session[:user_id]).not_to be_nil
      expect(response.status).to eq 302
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Signed in successfully")
    end

    context "When responding to an invitation" do
      it "adds user to the invited app" do
        invitation = create(:invitation)
        get :callback, params: { code: "sfkldf8sdf", state: invitation.token }
        expect(invitation.app.users.count).to eq 1
        expect(flash[:notice]).to eq("Signed in successfully")
      end
    end
  end

  describe "GET #failure" do
    it "redirects to root path with error message" do
      get :failure, params: { message: "Invalid Credentials" }
      expect(response.status).to eq 302
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("Invalid Credentials")
    end
  end

end