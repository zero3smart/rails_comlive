require 'rails_helper'

RSpec.describe StandardizationsController, :type => :controller do
  let!(:user) {  create(:user) }
  let!(:standard) { create(:standard) }
  let!(:commodity_reference) { create(:commodity_reference) }

  context "As an authenticated user" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new standardization in the database" do
          attrs = { standard_id: standard.id, referable_type: commodity_reference.class.to_s, referable_id: commodity_reference.id }
          expect{
            post :create, params: { standardization: attrs }
          }.to change(Standardization, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new ownership in the database" do
          attrs = { standard_id: standard.id, referable_type: commodity_reference.id }
          expect{
            post :create, params:  { standardization: attrs }
          }.not_to change(Standardization, :count)
        end
      end
    end
  end

  context "As an unauthenticated user" do
    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params:  { standardization: {} }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end