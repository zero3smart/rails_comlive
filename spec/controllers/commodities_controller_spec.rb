require 'rails_helper'

RSpec.describe CommoditiesController, :type => :controller do
  let(:user) { create(:user) }
  let(:commodity) { create(:commodity, :with_reference, ref_app_id: user.default_app.id) }
  let(:brand) { create(:brand) }

  context "When user signed in" do
    before(:each) do
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
        get :show, params: { id: commodity }
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

    describe "GET #autocomplete" do
      it "returns 200 http status code" do
        get :autocomplete
        expect(response.status).to eq 200
        # expect(JSON.parse(response.body)).to be_an Array
      end
    end

    describe "GET #prefetch" do
      it "returns 200 http status code" do
        get :prefetch
        expect(response.status).to eq 200
        # expect(JSON.parse(response.body)).to be_an Array
      end
    end
  end

  context "When user not signed in" do
    describe "GET #index" do
      it "returns 200 http status code" do
        get :index
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
        get :show, params: { uuid: commodity.uuid, title: commodity.name.parameterize }
        expect(response.status).to eq 200
      end
    end

    describe "GET #autocomplete" do
      it "returns 200 http status code" do
        get :autocomplete
        expect(response.status).to eq 200
        # expect(JSON.parse(response.body)).to be_an Array
      end
    end

    describe "GET #prefetch" do
      it "returns 200 http status code" do
        get :prefetch
        expect(response.status).to eq 200
        # expect(JSON.parse(response.body)).to be_an Array
      end
    end

    describe "GET #new" do
      it "redirects to the signin page" do
        get :new

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #edit" do
      it "redirects to the signin page" do
        commodity = create(:commodity)
        get :edit, params: { id: commodity }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { commodity: attributes_for(:commodity) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATCH #update" do
      it "redirects to the signin page" do
        commodity = create(:commodity)
        patch :update, params: { id: commodity, commodity: commodity.attributes }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end
