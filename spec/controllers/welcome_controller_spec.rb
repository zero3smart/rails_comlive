require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do
  describe "GET #landing" do
    it "returns 200 http code status" do
      get :landing
      expect(response.status).to eq 200
    end
  end

  describe "GET #add_items" do
    it "returns 200 http status code" do
      get :add_items
      expect(response.status).to eq 200
    end
  end

  describe "GET #dashboard" do
    it "returns 200 http status code" do
      get :dashboard
      expect(response.status).to eq 200
    end
  end

  describe "GET #contact-us" do
    it "returns 200 http status code" do
      get :contact
      expect(response.status).to eq 200
    end
  end

  describe "GET #team" do
    it "returns 200 http status code" do
      get :team
      expect(response.status).to eq 200
    end
  end

  describe "GET #pricing" do
    it "returns 200 http status code" do
      get :pricing
      expect(response.status).to eq 200
    end
  end

  describe "POST #send_message" do
    let(:name) { "John Doe"}
    let(:email) { "johndoe@email.com" }
    let(:message) { "This is an example message" }

    it "sends a notification email to admin" do
      expect {
        post :send_message, params:  { name: name, email: email, message: message }
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end

  describe "POST #subscribe" do
    it "subscribes the user" do
      post :subscribe, params:  { subscribe_email: "johndoe@email.com"  }
      expect(flash[:notice]).to eq(I18n.t("welcome.subscribe.success_message"))
      expect(response.status).to eq 302
    end
  end
end
