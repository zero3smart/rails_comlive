require 'rails_helper'

RSpec.describe StandardsController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:brand) { create(:brand) }
  let!(:standard) { create(:standard, name: "ISO 9000", brand: brand) }

  context "As an authenticated user" do
    before(:each) do
      sign_in user
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index, params: { brand_id: brand.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
        get :show, params: { id: standard.id, brand_id: brand.id  }
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { brand_id: brand.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #edit" do
      it "returns 200 http status code" do
        get :edit, params: { id: standard.id, brand_id: brand.id  }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new standard in the database" do
          expect{
            post :create, params: { standard: attributes_for(:standard), brand_id: brand.id }
          }.to change(Standard, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new standard in the database" do
          expect{
            post :create, params: { standard: attributes_for(:invalid_standard), brand_id: brand.id }
          }.not_to change(Standard, :count)
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates the standard in the database" do
          standard.name = "ISO 3166-1"
          patch :update, params: { id: standard.id, standard: standard.attributes, brand_id: brand.id }
          standard.reload
          expect(standard.name).to eq  "ISO 3166-1"
        end
      end

      context "with invalid attributes" do
        it "does not update the standard" do
          standard.name = ""
          patch :update, params: { id: standard.id, standard: standard.attributes, brand_id: brand.id }
          standard.reload
          expect(standard.name).to eq "ISO 9000"
        end
      end
    end
  end


  context "As an unauthenticated user" do

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index, params: { brand_id: brand.id }

        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "redirects to the signin page" do
        get :new, params: { brand_id: brand.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { standard: attributes_for(:standard), brand_id: brand.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
        get :show, params: { uuid: standard.uuid, title: standard.name }

        expect(response.status).to eq 200
      end
    end

    describe "GET #edit" do
      it "redirects to the signin page" do
        get :edit, params: { id: 1, brand_id: 2 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATH #update" do
      it "redirects to the signin page" do
        patch :update, params: { id: 1, standard: attributes_for(:standard), brand_id: 3 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end

  describe "GET #autocomplete" do
    it "returns 200 http status code" do
      get :autocomplete
      expect(response.status).to eq 200
    end
  end
end
