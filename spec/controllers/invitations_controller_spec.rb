require 'rails_helper'

RSpec.describe InvitationsController, :type => :controller do
  let!(:user){  create(:user) }
  let!(:app) { create(:app, user_id: user.id) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #new" do
    it "returns 200 http status code" do
      get :new, params: { app_id: app.id }
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the invited user to the database" do
        expect{
          post :create, params: { app_id: app.id, email: "user@example.com" }
        }.to change(User, :count).by(1)
      end
      it "sends outs an invitation email" do
        expect{
          post :create, params: { app_id: app.id, email: "user@example.com" }
        }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
      it "shows a success flash message" do
        post :create, params: { app_id: app.id, email: "user@example.com" }
        expect(flash[:notice]).to eq("Invitation sent to user@example.com")
      end
      it "adds user to an app" do
        expect{
          post :create, params: { app_id: app.id, email: "user@example.com" }
        }.to change(app.users, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the invited user in the database" do
        expect{
          post :create, params: { app_id: app.id, email: "invalidemail.com" }
        }.not_to change(User, :count)
      end
      it "does not send out an invitation email" do
        expect{
          post :create, params: { app_id: app.id, email: "invalidemail.com" }
        }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end
  end
end