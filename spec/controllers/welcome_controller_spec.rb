require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do
  describe "GET #landing" do
    it "returns 200 http code status" do
      get :landing
      expect(response.status).to eq 200
    end
  end

end