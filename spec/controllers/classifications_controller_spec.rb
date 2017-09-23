require 'rails_helper'

RSpec.describe ClassificationsController, :type => :controller do
  let(:user){ create(:user) }
  let(:app) { user.default_app }
  let(:classification) { create(:classification, app: app, moderator: user, name: "Boat") }

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

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { app_id: app.id }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new classification in the database" do
          expect{
            post :create, params: { app_id: app.id, classification: attributes_for(:classification) }
          }.to change(Classification, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new classification in the database" do
          expect{
            post :create, params: { app_id: app.id, classification: attributes_for(:invalid_classification) }
          }.not_to change(Classification, :count)
        end
      end
    end

    describe "GET #edit" do
      it "returns 200 http status code" do
        get :edit, params: { app_id: app.id, id: classification }
        expect(response.status).to eq 200
      end
    end

    describe "PATCH #update" do
      context "With valid attributes" do
        it "updates the classification in the database" do
          classification.name = "Bike"
          patch :update, params: { app_id: app.id, id: classification, classification: classification.attributes }
          classification.reload
          expect(classification.name).to eq "Bike"
        end
      end

      context "With invalid attributes" do
        it "should not update the classification" do
          classification.name = ""
          patch :update, params: { app_id: app.id, id: classification, classification: classification.attributes }
          classification.reload
          expect(classification.name).to eq "Boat"
        end
      end
    end
  end

  context "When not logged in" do
    describe "GET #index" do
      it "returns 302  http status code" do
        get :index, params: { app_id: app.id }
        expect(response.status).to eq 302
        expect(flash[:alert]).to be_present
      end
    end
  end
end
