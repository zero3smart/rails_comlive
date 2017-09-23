require 'rails_helper'

RSpec.describe HscodeSubheadingsController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:horses){ create(:hscode_heading, category: "34R6") }
  let!(:bovine_animals){ create(:hscode_heading, category: "59X0") }

  let!(:purebred_animals){ create(:hscode_subheading, hscode_heading: horses) }
  let!(:other_horses){ create(:hscode_subheading, hscode_heading: horses) }
  let!(:weighing_lt50){ create(:hscode_subheading, hscode_heading: bovine_animals) }
  let!(:weighing_gte50){ create(:hscode_subheading, hscode_heading: bovine_animals) }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "GET #index" do
      context "Given a hscode heading id" do
        it "returns hscode sub-headings belonging to the hscode heading" do
          get :index, params: { hscode_heading_id: horses.id }

          results = JSON.parse(response.body)

          expected_results = [purebred_animals,other_horses].map{|r| {'id' => r.id, 'description' => r.description} }
          ommitted_results = [weighing_lt50,weighing_gte50].map{|r| {'id' => r.id, 'description' => r.description} }

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
