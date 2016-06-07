require 'rails_helper'

RSpec.describe LinksController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "returns 200 http status code" do
      app = create(:app, user_id: @user.id)

      get :index, params: { app_id: app.id }
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    it "returns 200 http status code" do
      app = create(:app, user_id: @user.id)
      commodity =  create(:commodity, app_id: app.id)
      link = create(:link, app_id: app.id, commodity_id: commodity.id)

      get :show, params: { app_id: app.id, id: link.id }
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
      it "saves the new link in the database" do
        app = create(:app, user_id: @user.id)
        commodity = create(:commodity)

        expect{
          post :create, params: { app_id: app.id, link: attributes_for(:link, commodity_id: commodity.id) }
        }.to change(Link, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new link in the database" do
        app = create(:app, user_id: @user.id)
        commodity = create(:commodity)

        expect{
          post :create, params: { app_id: app.id, link: attributes_for(:invalid_link, commodity_id: commodity.id)}
        }.not_to change(Link, :count)
      end
    end
  end
end
