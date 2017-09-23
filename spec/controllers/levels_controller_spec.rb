require 'rails_helper'

RSpec.describe LevelsController, :type => :controller do
  let(:user){ create(:user) }
  let(:app) { user.default_app }
  let(:classification) { create(:classification, app: app) }
  let(:level) { create(:level, classification: classification, added_by: app, name: "Wet Ingredients") }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index, params: { app_id: app.id, classification_id: classification.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { app_id: app.id, classification_id: classification.id }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new level in the database" do
          expect{
            post :create, params: { app_id: app.id, classification_id: classification.id, level: attributes_for(:level) }
          }.to change(Level, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new classification in the database" do
          expect{
            post :create, params: { app_id: app.id, classification_id: classification.id, level: attributes_for(:invalid_level) }
          }.not_to change(Level, :count)
        end
      end
    end

    describe "GET #edit" do
      it "returns 200 http status code" do
        get :edit, params: {  app_id: app.id, classification_id: classification.id, id: level }
        expect(response.status).to eq 200
      end
    end

    describe "PATCH #update" do
      context "With valid attributes" do
        it "updates the level in the database" do
          level.name = "Dry Ingredients"
          patch :update, params: { app_id: app.id, classification_id: classification.id, id: level, level: level.attributes }
          level.reload
          expect(level.name).to eq "Dry Ingredients"
        end
      end

      context "With invalid attributes" do
        it "should not update the level" do
          level.name = ""
          patch :update, params: { app_id: app.id, classification_id: classification.id, id: level, level: level.attributes }
          level.reload
          expect(level.name).to eq "Wet Ingredients"
        end
      end
    end
  end

  context "When not logged in" do
    describe "GET #index" do
      it "returns 302  http status code" do
        get :index, params: { app_id: app.id, classification_id: classification.id }
        expect(response.status).to eq 302
        expect(flash[:alert]).to be_present
      end
    end

    describe "GET #new" do
      it "returns 302  http status code" do
        get :new, params: {  app_id: app.id, classification_id: classification.id }
        expect(response.status).to eq 302
        expect(flash[:alert]).to be_present
      end
    end

    describe "POST #create" do
      it "returns 302  http status code" do
        post :create, params: { app_id: app.id, classification_id: classification.id, level: attributes_for(:level) }
        expect(response.status).to eq 302
        expect(flash[:alert]).to be_present
      end
    end

    describe "GET #show" do
      it "returns 302  http status code" do
        get :show, params: { app_id: app.id, classification_id: classification.id, id: 1 }
        expect(response.status).to eq 302
        expect(flash[:alert]).to be_present
      end
    end

    describe "GET #edit" do
      it "returns 302  http status code" do
        get :edit, params: { app_id: app.id, classification_id: classification.id, id: 1 }
        expect(response.status).to eq 302
        expect(flash[:alert]).to be_present
      end
    end
  end
end
