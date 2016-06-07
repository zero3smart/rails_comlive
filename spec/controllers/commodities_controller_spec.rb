require 'rails_helper'

RSpec.describe CommoditiesController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "returns 200 http status code" do
      app = create(:app, user_id: @user.id)
      get :index, params: { app_id: app }
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    it "returns 200 http status code" do
      app = create(:app, user_id: @user.id)
      commodity =  create(:commodity, app_id: app.id)
      get :show, params: { app_id: app.id, id: commodity.id }
      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    it "returns 200 http status code" do
      app = create(:app, user_id: @user.id)
      get :new, params: { app_id: app.id }
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new app in the database" do
        app = create(:app, user_id: @user.id)
        expect{
          post :create, params: { app_id: app.id, commodity: attributes_for(:commodity) }
        }.to change(Commodity, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new app in the database" do
        app = create(:app, user_id: @user.id)
        expect{
          post :create, params: { app_id: app.id, commodity: attributes_for(:invalid_commodity)}
        }.not_to change(Commodity, :count)
      end
    end
  end
end
