require 'rails_helper'

RSpec.describe MeasurementsController, :type => :controller do
  context "As an authenticated user" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create(:user)
      @app = create(:app, user_id: @user.id)
      sign_in @user
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index, params: { app_id: @app.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #show" do
      it "returns 200 http status code" do
        measurement =  create(:measurement, app_id: @app.id)
        get :show, params: { app_id: @app.id, id: measurement.id }
        expect(response.status).to eq 200
      end
    end

    describe "GET #new" do
      it "returns 200 http status code" do
        get :new, params: { app_id: @app.id }
        expect(response.status).to eq 200
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new measurement in the database" do
          expect{
            post :create, params: { app_id: @app.id, measurement: attributes_for(:measurement) }
          }.to change(Measurement, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new measurement in the database" do
          expect{
            post :create, params: { app_id: @app.id, measurement: attributes_for(:invalid_measurement)}
          }.not_to change(Measurement, :count)
        end
      end
    end

    describe "PATCH #update" do
      before(:each) do
        @measurement = create(:measurement, app: @app, value: 6.9000)
      end

      context "with valid attributes" do
        it "updates the measurement in the database" do
          @measurement.value = 5.0004
          patch :update, params: { app_id: @app.id, id: @measurement.id, measurement: @measurement.attributes }
          @measurement.reload
          expect(@measurement.value).to eq  BigDecimal.new("5.0004")
        end
      end

      context "with invalid attributes" do
        it "does not update the measurement" do
          @measurement.value = ""
          patch :update, params: { app_id: @app.id, id: @measurement.id, measurement: @measurement.attributes }
          @measurement.reload
          expect(@measurement.value).to eq BigDecimal.new("6.9000")
        end
      end
    end
  end

  context "As an unauthenticated user" do
    before(:each) do
      user = create(:user)
      @app = create(:app, user_id: user.id)
    end

    describe "GET #index" do
      it "redirects to the signin page" do
        get :index, params: { app_id: @app.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #new" do
      it "redirects to the signin page" do
        get :new, params: { app_id: @app.id }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "POST #create" do
      it "redirects to the signin page" do
        post :create, params: { app_id: @app.id, measurement: attributes_for(:measurement) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #show" do
      it "redirects to the signin page" do
        get :show, params: { app_id: @app.id, id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "GET #edit" do
      it "redirects to the signin page" do
        get :edit, params: { app_id: @app.id, id: 1 }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "PATH #update" do
      it "redirects to the signin page" do
        patch :update, params: { app_id: @app.id, id: 1, measurement: attributes_for(:measurement) }

        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end
