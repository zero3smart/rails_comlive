require 'rails_helper'

RSpec.describe SearchesController, :type => :controller do
  describe "GET #index" do
    it "returns 200 http status code" do
      get :index
      expect(response.status).to eq 200
    end
  end
end
