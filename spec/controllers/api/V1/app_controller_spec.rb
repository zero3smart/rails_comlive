require 'rails_helper'

RSpec.describe Api::V1::AppsController, :type => :controller do
  let(:user) { create(:user) }
  let(:app) { user.default_app }

  context "With an access token" do
    before(:each) do
      setup_knock_for(user)
    end

    describe "GET #index" do
      before(:each) do
        get :index
      end

      it 'responds with 200 http status code' do
        expect(response.status).to eq 200
      end

      it "returns information about user's apps" do
        app_details = json_response["data"][0]["attributes"]

        expect(json_response["data"].count).to eq 1
        expect(json_response["data"]).to be_an Array
        expect(app_details["name"]).to eq app.name
        expect(app_details["description"]).to eq app.description
      end

      it "returns only the allowed valid attributes" do
        app_details = json_response["data"][0]["attributes"]

        expect(app_details.keys).to match_array(["name","description"])
      end
    end

    describe "GET #show" do
      context "With a valid record id" do
        before(:each) do
          get :show, params: { id: app }
        end

        it "responds with 200 http status code" do
          expect(response.status).to eq 200
        end

        it "returns the app's info" do
          app_details = json_response["data"]["attributes"]

          expect(json_response).to be_a Hash
          expect(app_details["name"]).to eq app.name
          expect(app_details["description"]).to eq app.description
        end

        it "returns only the allowed valid attributes" do
          app_details = json_response["data"]["attributes"]

          expect(app_details.keys).to match_array(["name","description"])
        end
      end

      context "With an invalid record id" do
        it "responds with 404 http status code" do
          get :show, params: { id: 67 }

          expect(response.status).to eq 404
          expect(json_response["error"]).to eq "Record not found"
        end
      end
    end
  end

  context "Without an access token" do
    describe "GET #index" do
      it 'responds with 401 http status code' do
        get :index
        expect(response.status).to eq 401
      end
    end
  end
end
