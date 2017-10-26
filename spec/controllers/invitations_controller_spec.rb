require 'rails_helper'

RSpec.describe InvitationsController, :type => :controller do
  let!(:user){  create(:user) }
  let!(:app) { create(:app, user_id: user.id) }

  describe "GET #new" do
    it "returns 200 http status code" do
      sign_in user

      get :new, params: { app_id: app.id }
      expect(response.status).to eq 200
    end
  end

  describe "GET #accept" do
    context "With a valid invitation token" do
      it "returns 200 http status code" do
        invitation = create(:invitation)
        get :accept, params: { token: invitation.token }
        expect(response.status).to eq 200
      end
    end

    context "With an invalid invitation token" do
      it "returns 302 http status code" do
        get :accept, params: { token: "6q8y9nh1mwvrx3sm" }
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq("Invalid invitation token")
      end
    end
  end

  describe "POST #create" do
    before(:each) do
      sign_in user
    end

    context "with valid attributes" do
      it "saves the invitation to the database" do
        expect{
          post :create, params: { app_id: app.id, invitation: attributes_for(:invitation) }
        }.to change(Invitation, :count).by(1)
      end

      it "sends outs an invitation email" do
        expect{
          post :create, params: { app_id: app.id, invitation: attributes_for(:invitation) }
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end

      it "shows a success flash message" do
        invitation = attributes_for(:invitation)
        post :create, params: { app_id: app.id, invitation: invitation }
        expect(flash[:notice]).to eq("Invitation sent to #{invitation[:recipient_email]}")
      end
    end

    context "with invalid attributes" do
      it "does not save the invitation in the database" do
        expect{
          post :create, params: { app_id: app.id, invitation: attributes_for(:invalid_invitation) }
        }.not_to change(Invitation, :count)
      end
      it "does not send out an invitation email" do
        expect{
          post :create, params: { app_id: app.id, invitation: attributes_for(:invalid_invitation) }
        }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end
  end
end