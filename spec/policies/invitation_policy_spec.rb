require 'rails_helper'

RSpec.describe InvitationPolicy do

  let(:user) { create(:user) }
  let(:app) { create(:app) }
  let!(:membership) { create(:membership, user: user, member: app, owner: true)}

  let(:invitation) { Invitation.new(app_id: app.id) }
  let(:other_invitation) { build(:invitation) }

  subject { described_class }

  permissions :new?, :create? do
    it 'grants access if user is owner of the app' do
      expect(subject).to permit(user, invitation)
    end

    it 'denies access if user is not owner of the app' do
      expect(subject).not_to permit(user, other_invitation)
    end
  end

  permissions :accept? do
    it "grants access to the user" do
      expect(subject).to permit(User.new, Invitation)
    end
  end
end