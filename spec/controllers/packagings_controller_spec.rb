require 'rails_helper'

RSpec.describe PackagingsController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:app) { create(:app) }
  let!(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  let(:packaging) { create(:packaging, commodity_reference_id: commodity_reference.id, name: "Milk Packaging", uom: "packets") }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new packaging state in the database" do
          expect{
            post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging: attributes_for(:packaging) }
          }.to change(Packaging, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new packaging in the database" do
          expect{
            post :create, params:  { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging: attributes_for(:invalid_packaging) }
          }.not_to change(Packaging, :count)
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates the packaging in the database" do
          packaging.name = "Malt Beer"
          packaging.uom = "Crates"
          patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: packaging.id, packaging: packaging.attributes }
          packaging.reload
          expect(packaging.name).to eq "Malt Beer"
          expect(packaging.uom).to eq "Crates"
        end
      end

      context "with invalid attributes" do
        it "does not update the packaging" do
          packaging.name = ""
          patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: packaging.id, packaging: packaging.attributes }
          packaging.reload
          expect(packaging.name).to eq "Milk Packaging"
        end
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
        get :show, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: packaging.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { app_id: app.id, commodity_reference_id: commodity_reference.id }
        expect(response.status).to eq 200
      end
    end
  end

  context "As an unauthenticated user" do

    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging: attributes_for(:packaging) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATCH #update" do
      it "redirects to the signin page" do
        patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: packaging.id, packaging: attributes_for(:packaging) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end