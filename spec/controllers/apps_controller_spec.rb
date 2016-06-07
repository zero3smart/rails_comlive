require 'rails_helper'

RSpec.describe AppsController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "returns 200 http status code" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    it "returns 200 http status code" do
      app = create(:app, user_id: @user.id)
      get :show, params: { id: app }
      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    it "returns 200 http status code" do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new app in the database" do
        expect{
          post :create, params: { app: attributes_for(:app) }
        }.to change(App, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new app in the database" do
        expect{
          post :create, params: { app: attributes_for(:invalid_app)}
        }.not_to change(App, :count)
      end
    end
  end

end
