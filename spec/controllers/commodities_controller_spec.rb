require 'rails_helper'

RSpec.describe CommoditiesController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:commodity) { create(:commodity) }
  let!(:brand) { create(:brand) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #index" do
    it "returns 200 http status code" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    it "returns 200 http status code" do
      get :show, params: { id: commodity.id }
      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    it "returns 200 http status code" do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves a generic commodity in the database" do
        expect{
          post :create, params: { commodity: attributes_for(:generic_commodity) }
        }.to change(Commodity, :count).by(1)
      end

      it "creates an app for the commodity reference" do
        expect{
          post :create, params: { commodity: attributes_for(:generic_commodity) }
        }.to change(App, :count).by(1)
      end

      it "creates a commodity reference" do
        expect{
          post :create, params: { commodity: attributes_for(:generic_commodity) }
        }.to change(CommodityReference, :count).by(1)
      end

      it "saves a non generic commodity in the database" do
        expect{
          post :create, params: { commodity: attributes_for(:commodity, brand_id: brand.id) }
        }.to change(Commodity, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new app in the database" do
        expect{
          post :create, params: { commodity: attributes_for(:invalid_commodity, brand_id: brand.id)}
        }.not_to change(Commodity, :count)
      end
    end
  end

end