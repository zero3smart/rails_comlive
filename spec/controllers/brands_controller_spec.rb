require 'rails_helper'

RSpec.describe BrandsController, :type => :controller do
  let!(:user){ create(:user) }
  let!(:brand) { create(:brand, name: "Subaru") }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
        get :show, params: { id: brand.id }
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
      it "saves the new brand in the database" do
        expect{
          post :create, params: { brand: attributes_for(:brand) }
        }.to change(Brand, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new brand in the database" do
        expect{
          post :create, params: { brand: attributes_for(:invalid_brand) }
        }.not_to change(Brand, :count)
      end
    end

    context "With optional fields" do
      skip "Add specs for facebook_url url logo etc"
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the brand in the database" do
        brand.name = "BMW"
        patch :update, params: { id: brand.id, brand: brand.attributes }
        brand.reload
        expect(brand.name).to eq  "BMW"
      end
    end

    context "with invalid attributes" do
      it "does not update the brand" do
        brand.name = ""
        patch :update, params: { id: brand.id, brand: brand.attributes }
        brand.reload
        expect(brand.name).to eq "Subaru"
      end
    end
  end
end

  context "As an unauthenticated user" do
    describe "GET #index" do
      it "redirects to the signin page" do
        get :index

        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "redirects to the signin page" do
        get :new

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { brand: attributes_for(:brand) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #show" do
      it "redirects to the signin page" do
        get :show, params: { uuid: brand.uuid, title: brand.name }

        expect(response.status).to eq 200
      end
    end

    describe "GET #edit" do
      it "redirects to the signin page" do
        get :edit, params: { id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATH #update" do
      it "redirects to the signin page" do
        patch :update, params: { id: 1, brand: attributes_for(:brand) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end

  describe "GET #autocomplete" do
    it "returns 200 http status code" do
      get :autocomplete
      expect(response.status).to eq 200
    end
  end
end
