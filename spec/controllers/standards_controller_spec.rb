require 'rails_helper'

RSpec.describe StandardsController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:standard) { create(:standard, name: "ISO 9000") }

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
        get :show, params: { id: standard.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new
        expect(response.status).to eq 200
      end
    end

    describe "GET #edit" do
      it "returns 200 http status code" do
        get :edit, params: { id: standard.id  }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new standard in the database" do
          expect{
            post :create, params: { standard: attributes_for(:standard) }
          }.to change(Standard, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new standard in the database" do
          expect{
            post :create, params: { standard: attributes_for(:invalid_standard)}
          }.not_to change(Standard, :count)
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates the standard in the database" do
          standard.name = "ISO 3166-1"
          patch :update, params: { id: standard.id, standard: standard.attributes }
          standard.reload
          expect(standard.name).to eq  "ISO 3166-1"
        end
      end

      context "with invalid attributes" do
        it "does not update the standard" do
          standard.name = ""
          patch :update, params: { id: standard.id, standard: standard.attributes }
          standard.reload
          expect(standard.name).to eq "ISO 9000"
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
        post :create, params: { standard: attributes_for(:standard) }

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
        patch :update, params: { id: 1, standard: attributes_for(:standard) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end