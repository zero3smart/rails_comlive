require 'rails_helper'

RSpec.describe AppPolicy do

  let(:user) { create(:user) }
  let(:member_app) { user.apps.create(attributes_for(:app)) }
  let(:other_user_app) { create(:app) }

  subject { described_class }

  permissions :show? do
    it 'grants access if user is member of the app' do
      expect(subject).to permit(user, member_app)
    end

    it 'denies access if user is not member of the app' do
      expect(subject).not_to permit(user, other_user_app)
    end
  end

  permissions :create?, :new? do
    it "grants access to the current user" do
      expect(subject).to permit(user,App)
    end
  end

  permissions :update?, :edit? do
    it "grants access if user is member of app" do
      expect(subject).to permit(user, member_app)
    end

    it "denies access if user is not member of the app" do
      expect(subject).not_to permit(user, other_user_app)
    end
  end

  permissions :destroy? do
  end
end