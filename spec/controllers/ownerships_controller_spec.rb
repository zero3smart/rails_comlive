require 'rails_helper'

RSpec.describe OwnershipsController, :type => :controller do
  let!(:user) { create(:user) }
  let(:brand) { create(:brand) }
  let(:ownership) { build(:ownership, parent: user.default_app)  }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { child_id: brand.id, child_type: "Brand" }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "With valid attributes" do
        it "saves the new ownership in the database" do
          ownership_attrs = ownership.attributes
          ownership_attrs["parent_id"] = "#{ownership_attrs["parent_type"]}-#{ownership_attrs["parent_id"]}"
          expect{
            post :create, params: { ownership: ownership_attrs }
          }.to change(Ownership, :count).by(1)
        end
        it "sends a notification mail to admin" do
          ownership_attrs = ownership.attributes
          ownership_attrs["parent_id"] = "#{ownership_attrs["parent_type"]}-#{ownership_attrs["parent_id"]}"

          expect {
            post :create, params:  { ownership: ownership_attrs }
          }.to change(ActionMailer::Base.deliveries, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new ownership in the database"
      end
    end
  end

  context "As an unauthenticated user" do
    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params:  { ownership: attributes_for(:ownership) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #new" do
      it "returns 302 http status code" do
        get :new, params: { child_id: brand.id, child_type: "Brand" }
        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end
