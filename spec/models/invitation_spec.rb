require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      invitation = build(:invitation)
      expect(invitation).to be_valid
    end

    it "is invalid without recipient email" do
      invitation = build(:invitation,recipient_email: nil)
      invitation.valid?
      expect(invitation.errors[:recipient_email]).to include("can't be blank")
    end

    it "is invalid with an invalid email" do
      invitation = build(:invitation,recipient_email: "invalid@email")
      invitation.valid?
      expect(invitation.errors[:recipient_email]).to include("is invalid")
    end

    it "is invalid without a sender" do
      invitation = build(:invitation,sender_id: nil)
      invitation.valid?
      expect(invitation.errors[:sender_id]).to include("can't be blank")
    end

    it "is invalid without an app" do
      invitation = build(:invitation,app_id: nil)
      invitation.valid?
      expect(invitation.errors[:app_id]).to include("can't be blank")
    end

    it "is not accepted by default" do
      invitation = build(:invitation)
      expect(invitation.accepted).to eq false
    end

    it "Generates a token after create" do
      invitation = create(:invitation)
      expect(invitation.token).not_to be_nil
    end

    it "is invalid with duplicate email for same app" do
      app = create(:app)

      create(:invitation, recipient_email: "user@example.com", app_id: app.id)
      invitation = build(:invitation, recipient_email: "user@example.com", app_id: app.id)
      invitation.valid?
      expect(invitation.errors[:recipient_email]).to include(" is already a member of this app")
    end
  end

  describe "Associations" do
    it "belongs to sender" do
      assoc = Invitation.reflect_on_association(:sender)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to app" do
      assoc = Invitation.reflect_on_association(:sender)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
