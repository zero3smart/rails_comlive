require 'rails_helper'

RSpec.describe BarcodesController, :type => :controller do
  let(:user) { create(:user) }
  let(:app) { user.default_app }
  let(:commodity_reference){ create(:commodity_reference, app: app) }
  let(:packaging) { create(:packaging, commodity_reference_id: commodity_reference.id) }
  let(:barcode) { create(:barcode, format: "ean_13", content: "5463", barcodeable: packaging) }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new barcode in the database" do
          expect{
            post :create, params: {
                app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id,
                barcode: attributes_for(:barcode)
            }
          }.to change(Barcode, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new barcode in the database" do
          expect{
            post :create, params: {
                app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id,
                barcode: attributes_for(:invalid_barcode)
            }
          }.not_to change(Barcode, :count)
        end
      end
    end

    describe "GET #edit" do
      it "returns 200 http status code" do
        get :edit, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id,
                             id: barcode }
        expect(response.status).to eq 200
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates the barcode in the database" do
          barcode.format = "code_128"
          patch :update, params: {
              app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id, id: barcode,
              barcode: barcode.attributes }
          barcode.reload
          expect(barcode.format).to eq 'code_128'
        end
      end

      context "with invalid attributes" do
        it "does not update the barcode" do
          barcode.format = ""
          patch :update, params: {
              app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id, id: barcode,
              barcode: barcode.attributes }
          barcode.reload
          expect(barcode.format).to eq 'ean_13'
        end
      end
    end
  end

  context "As an unauthenticated user" do
    describe "GET #index" do
      it "redirects to the signin page" do
        get :index, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #new" do
      it "redirects to the signin page" do
        get :new, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #edit" do
      it "redirects to the signin page" do
        get :edit, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id,
                             id: barcode }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end


    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: {
            app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id, barcode: {}
        }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATCH #update" do
      it "redirects to the signin page" do
        patch :update, params: {
            app_id: app.id, commodity_reference_id: commodity_reference.id, packaging_id: packaging.id, id: barcode,
            barcode: {}}

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end