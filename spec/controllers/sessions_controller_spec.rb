require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  describe "GET #new" do
    it "returns 200 http status code" do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = create(:user)
      sign_in(@user)
    end

    it "logs out the current user" do
      get :destroy
      expect(session[:user_id]).to be_nil
      expect(response.status).to eq 302
    end
  end

end
