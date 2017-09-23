require 'rails_helper'

RSpec.describe HscodeChaptersController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:animal_products) { create(:hscode_section) }
  let!(:vegetable_products) { create(:hscode_section) }

  let!(:live_animals) { create(:hscode_chapter, hscode_section: animal_products) }
  let!(:edible_meat_offal) { create(:hscode_chapter, hscode_section: animal_products) }
  let!(:live_trees) { create(:hscode_chapter, hscode_section: vegetable_products) }
  let!(:edible_vegetables) { create(:hscode_chapter, hscode_section: vegetable_products) }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "GET #index" do
      context "Given a hscode section id" do
        it "returns hscode chapters belonging to the hscode section" do
          get :index, params: { hscode_section_id: animal_products.id }

          results = JSON.parse(response.body)

          expected_results = [live_animals,edible_meat_offal].map{|r| {'id' => r.id, 'description' => r.description} }
          ommitted_results = [live_trees,edible_vegetables].map{|r| {'id' => r.id, 'description' => r.description} }

          expect(results).to match_array(expected_results)
          expect(results.count).to eq 2
          expect(results).not_to include(ommitted_results)
        end
      end
    end
  end

  context "As an unauthenticated user" do
    describe "GET #index" do
      it "redirects to the signin page" do
        get :index

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end
