require 'rails_helper'

RSpec.describe ListsController, :type => :controller do
  let(:user) { create(:user) }
  let(:list) { user.list }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "PATCH #update" do
      context "With a non-existing commodity id" do
        it "adds the commodity id to the list of commodities" do
          patch :update, params: { id: list.id, list: { commodity_id: 4 } }
          list.reload
          expect(list.commodities.length).to eq 1
          expect(list.commodities).to include("4")
        end
      end

      context "With an already existing commodity id" do
        it "does not add the commodity id to the list of commodities" do
          list.update(commodities: ["2","3","4"])
          patch :update, params: { id: list.id, list: { commodity_id: 4 } }
          list.reload
          expect(list.commodities.length).to eq 3
        end
      end
    end
  end

  context "As an unauthenticated user" do
    describe "PATCH #update" do
      it "redirects to the signin page" do
        patch :update, params: { id: list.id, list: { commodity_id: 4 } }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end
