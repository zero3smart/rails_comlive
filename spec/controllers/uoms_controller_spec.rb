require 'rails_helper'

RSpec.describe UomsController, :type => :controller do
  context "when user is authenticated" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create(:user)
      sign_in @user
    end

    describe "GET #index" do
      it "returns 200 http status code" do
        get :index
        expect(response.status).to eq 200
      end

      it "returns a list of uoms belonging to a property" do
        property = properties.sample

        get :index, params: { property: property }
        uoms = JSON.parse(response.body)
        expect(uoms).to eq uom(property)
      end
    end
  end

  context "when user is unauthenticated" do
    describe "GET #index" do
      it "returns 302 http status code" do
        get :index
        expect(response.status).to eq 302
      end

      it "redirects to the signin page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  def properties
    Unitwise::Atom.all.uniq.map {|x| "#{x.property}"}.uniq
  end

  def uom(property)
    Unitwise::Atom.all.select{|a| a.property == property }.map {|i| ["#{i.to_s(:names)} (#{i.to_s(:primary_code)})",i.to_s(:primary_code)] }
  end
end
