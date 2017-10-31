require 'rails_helper'

RSpec.describe ReferencesController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:app) { create(:app) }
  let(:reference) { create(:reference, app: app) }

  before(:each) do
    sign_in user
  end

  describe "GET #index" do
    it "returns 200 http status code" do
      get :index, params: { app_id: app.id }
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    it "returns 200 http status code" do
      get :show, params: { app_id: app.id, id: reference.id }
      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    it "returns 200 http status code" do
      get :new, params: { app_id: app.id }
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new reference in the database" do
        expect{
          post :create, params: { app_id: app.id, reference: attributes_for(:reference) }
        }.to change(Reference, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new reference in the database" do
        expect{
          post :create, params: { app_id: app.id, reference: attributes_for(:invalid_reference) }
        }.not_to change(Reference, :count)
      end
    end
  end
end