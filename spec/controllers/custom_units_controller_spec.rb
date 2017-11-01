require 'rails_helper'

RSpec.describe CustomUnitsController, :type => :controller do
  let(:user) { create(:user) }
  let(:apps) { user.apps << create(:app) } # creates a membership record
  let(:app) { apps.first }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index, params: { app_id: app.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
        custom_unit =  create(:custom_unit, app_id: app.id)
        get :show, params: { app_id: app.id, id: custom_unit.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { app_id: app.id }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new unit in the database" do
          expect{
            post :create, params: { app_id: app.id, custom_unit: attributes_for(:custom_unit) }
          }.to change(CustomUnit, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new unit in the database" do
          expect{
            post :create, params: { app_id: app.id, custom_unit: attributes_for(:invalid_custom_unit)}
          }.not_to change(CustomUnit, :count)
        end
      end
    end

    describe "PATCH #update" do
      before(:each) do
        @custom_unit = create(:custom_unit, app: app, property: "custom scale", uom: "points")
      end

      context "with valid attributes" do
        it "updates the unit in the database" do
          @custom_unit.property =  "Molarity"
          @custom_unit.uom = "moles"
          patch :update, params: { app_id: app.id, id: @custom_unit.id, custom_unit: @custom_unit.attributes }
          @custom_unit.reload
          expect(@custom_unit.property).to eq "Molarity"
          expect(@custom_unit.uom).to eq "moles"
        end
      end

      context "with invalid attributes" do
        it "does not update the unit" do
          @custom_unit.property = ""
          @custom_unit.uom = ""
          patch :update, params: { app_id: app.id, id: @custom_unit.id, custom_unit: @custom_unit.attributes }
          @custom_unit.reload
          expect(@custom_unit.property).to eq "custom scale"
          expect(@custom_unit.uom).to eq "points"
        end
      end
    end
  end

  context  "As an unauthenticated user" do
    before(:each) do
      user = create(:user)
      app = create(:app)
    end

    describe "GET #index" do
      it "redirects to the signin page" do
        get :index, params: { app_id: app.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #new" do
      it "redirects to the signin page" do
        get :new, params: { app_id: app.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { app_id: app.id, custom_unit: attributes_for(:custom_unit) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #show" do
      it "redirects to the signin page" do
        get :show, params: { app_id: app.id, id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #edit" do
      it "redirects to the signin page" do
        get :edit, params: { app_id: app.id, id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATH #update" do
      it "redirects to the signin page" do
        patch :update, params: { app_id: app.id, id: 1, measurement: attributes_for(:custom_unit) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end