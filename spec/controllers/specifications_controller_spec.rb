require 'rails_helper'

RSpec.describe SpecificationsController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:app) { create(:app, user_id: user.id) }
  let!(:commodity_reference) { create(:commodity_reference, app_id: app.id) }

  context "As an authenticated user" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index, params: { app_id: app.id, commodity_reference_id: commodity_reference.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
        specification =  create(:specification, parent: commodity_reference)
        get :show, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: specification.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { app_id: app.id, commodity_reference_id: commodity_reference.id }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        context "providing only value" do
          it "saves the new specification in the database" do
            expect{
              post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, specification: attributes_for(:specification) }
            }.to change(Specification, :count).by(1)
          end
        end

        context "providing either a min or max" do
          it "saves the new specification in the database" do
            expect{
              post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, specification: attributes_for(:spec_with_min_max, min: nil) }
            }.to change(Specification, :count).by(1)

            expect{
              post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, specification: attributes_for(:spec_with_min_max, max: nil) }
            }.to change(Specification, :count).by(1)
          end
        end
      end

      context "with invalid attributes" do
        it "does not save the new specification in the database" do
          expect{
            post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, specification: attributes_for(:invalid_specification)}
          }.not_to change(Specification, :count)
        end
      end
    end

    describe "PATCH #update" do
      let!(:specification){  create(:specification, parent: commodity_reference, value: 6.9000) }

      context "with valid attributes" do
        it "updates the specification in the database" do
          specification.value = 5.0004
          patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: specification.id, specification: specification.attributes }
          specification.reload
          expect(specification.value).to eq  BigDecimal.new("5.0004")
        end
      end

      context "with invalid attributes" do
        it "does not update the specification" do
          specification.value = ""
          patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: specification.id, specification: specification.attributes }
          specification.reload
          expect(specification.value).to eq BigDecimal.new("6.9000")
        end
      end
    end
  end

  context "As an unauthenticated user" do

    describe "GET #index" do
      it "redirects to the signin page" do
        get :index, params: { app_id: app.id, commodity_reference_id: commodity_reference.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #new" do
      it "redirects to the signin page" do
        get :new, params: { app_id: app.id, commodity_reference_id: commodity_reference.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, specification: attributes_for(:specification) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #show" do
      it "redirects to the signin page" do
        get :show, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #edit" do
      it "redirects to the signin page" do
        get :edit, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATCH #update" do
      it "redirects to the signin page" do
        patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: 1, specification: attributes_for(:specification) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end