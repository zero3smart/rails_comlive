require 'rails_helper'

RSpec.describe LinksController, :type => :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

  describe "GET #new" do
    it "returns 200 http status code" do
      app = create(:app, user_id: @user.id)

      get :new, params: { app_id: app.id }
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    before(:each) do
      @app = create(:app, user_id: @user.id)
      @commodity = create(:commodity)
    end

    context "with valid attributes" do
      it "saves the new link in the database" do
        expect{
          post :create, params: { app_id: @app.id, link: attributes_for(:link, commodity_id: @commodity.id) }
        }.to change(Link, :count).by(1)
      end
      it "redirects to link's commodity#show path" do
        post :create, params: { app_id: @app.id, link: attributes_for(:link, commodity_id: @commodity.id) }
        expect(response).to redirect_to(app_commodity_path(@app,@commodity))
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      it "does not save the new link in the database" do
        expect{
          post :create, params: { app_id: @app.id, link: attributes_for(:invalid_link, commodity_id: @commodity.id)}
        }.not_to change(Link, :count)
      end
    end
  end

  describe "PATCH #update" do
    before(:each) do
      @app = create(:app, user_id: @user.id)
      @link = create(:link, app_id: @app.id)
    end

    context "with valid attributes" do
      it "updates the new link in the database" do
        @link.url = "https://facebook.com"
        patch :update, params: { app_id: @app.id, id: @link.id, link: @link.attributes }
        @link.reload
        expect(@link.url).to eq "https://facebook.com"
      end

      it "redirects to link's commodity#show path" do
        patch :update, params: { app_id: @app.id, id: @link.id, link: @link.attributes }
        expect(response).to redirect_to(app_commodity_path(@app,@link.commodity))
        expect(flash[:notice]).to be_present
      end
    end

  end
end