require 'rails_helper'

RSpec.describe ImagesController, :type => :controller do
  let(:user) { create(:user) }
  let(:app) { user.default_app }
  let(:commodity_reference) { create(:commodity_reference, app: app) }

  before(:each) do
    sign_in user
  end

  describe "GET #new" do
    it "returns 200 http status code" do
      get :new, params: { app_id: app.id,  commodity_reference_id: commodity_reference.id }
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new image in the database" do
        expect{
          post :create, params: { app_id: app.id,  commodity_reference_id: commodity_reference.id, image: attributes_for(:image) }
        }.to change(Image, :count).by(1)
      end
      it "redirects to link's commodity#show path" do
        post :create, params: { app_id: app.id,  commodity_reference_id: commodity_reference.id, image: attributes_for(:image) }
        expect(response).to redirect_to(commodity_path(commodity_reference.commodity))
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      it "does not save the new url in the database" do
        expect{
          post :create, params: { app_id: app.id,  commodity_reference_id: commodity_reference.id, image: attributes_for(:invalid_image, commodity_reference_id: commodity_reference.id)}
        }.not_to change(Image, :count)
      end
    end
  end
end
