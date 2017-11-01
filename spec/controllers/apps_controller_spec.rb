require 'rails_helper'

RSpec.describe AppsController, :type => :controller do
  let!(:user) { create(:user) }
  let(:app_details) { attributes_for(:app, name: "No Limit") }
  let(:app) { user.apps.create(app_details) }

  context "As an authenticated user" do
    before(:each) do
      sign_in(user)
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
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

    describe "GET #edit" do
      it "returns 200 http status code" do
        get :edit, params: { id: app.id }
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

        it "creates a membership for the user" do
          expect{
            post :create, params: { app: attributes_for(:app) }
          }.to change(Membership, :count).by(1)
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

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates the app details" do
          app.name = "Galaxy"
          patch :update, params: { id: app.id, app: app.attributes }
          app.reload
          expect(app.name).to eq "Galaxy"
        end
      end

      context "with invalid attributes" do
        it "does not update the app" do
          app.name = ""
          patch :update, params: { id: app.id, app: app.attributes }
          app.reload
          expect(app.name).to eq "No Limit"
        end
      end
    end
  end

  context "As an unauthenticated user" do
    describe "GET #index" do
      it "returns 302 http status code" do
        get :index
        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #show" do
      it "returns 302 http status code" do
        get :show, params: { id: 1 }
        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #new" do
      it "returns 302 http status code" do
        get :new
        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "POST #create" do
      it "returns 302 http status code" do
        post :create, params: { app: attributes_for(:app) }
        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end