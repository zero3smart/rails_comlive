require 'rails_helper'

RSpec.describe BrandsController, :type => :controller do
  let!(:user){ create(:user) }
  let!(:brand) { create(:brand, name: "Subaru") }

  context "As an authenticated user" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
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

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #new" do
      it "redirects to the signin page" do
        get :new

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { brand: attributes_for(:brand) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #show" do
      it "redirects to the signin page" do
        get :show, params: { id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #edit" do
      it "redirects to the signin page" do
        get :edit, params: { id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATH #update" do
      it "redirects to the signin page" do
        patch :update, params: { id: 1, brand: attributes_for(:brand) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end