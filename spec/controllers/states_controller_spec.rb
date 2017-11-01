require 'rails_helper'

RSpec.describe StatesController, :type => :controller do
  let(:user) { create(:user) }
  let(:apps) { user.apps << create(:app) } # creates a membership record
  let(:app) { apps.first }
  let(:commodity_reference){ create(:commodity_reference, app: app) }
  let(:state) { create(:state, commodity_reference: commodity_reference, status: "recall", url: "https://www.youtube.com/watch?v=lhkslaPN-4") }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new commodity state in the database" do
          expect{
            post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, state: attributes_for(:state) }
          }.to change(State, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new state in the database" do
          expect{
            post :create, params:  { app_id: app.id, commodity_reference_id: commodity_reference.id, state: attributes_for(:invalid_state) }
          }.not_to change(State, :count)
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates the state in the database" do
          state.status = "stop"
          state.url = "http://stackoverflow.com/questions/5103572/"
          patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: state.id, state: state.attributes }
          state.reload
          expect(state.status).to eq "stop"
          expect(state.url).to eq "http://stackoverflow.com/questions/5103572/"
        end
      end

      context "with invalid attributes" do
        it "does not update the state" do
          state.status = "forbidden state"
          patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: state.id, state: state.attributes }
          state.reload
          expect(state.status).to eq "recall"
        end
      end
    end
  end

  context "As an unauthenticated user" do
    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, state: attributes_for(:state) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATCH #update" do
      it "redirects to the signin page" do
        patch :update, params: { app_id: app.id, commodity_reference_id: commodity_reference.id, id: state.id, state: attributes_for(:state) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end