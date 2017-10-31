require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "Validations" do
    it "has a valid factory" do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  describe "Associations" do
    it "has many brands" do
      assoc = User.reflect_on_association(:brands)
      expect(assoc.macro).to eq :has_many
    end

    it "has many standards" do
      assoc = User.reflect_on_association(:standards)
      expect(assoc.macro).to eq :has_many
    end

    it "has many apps" do
      assoc = User.reflect_on_association(:apps)
      expect(assoc.macro).to eq :has_many
    end
  end

  describe "Instance Methods" do
    describe "#accept_invite" do
      let!(:user) { create(:user) }
      let!(:invitation) { create(:invitation) }

      it "requires a token as an argument" do
        expect { user.accept_invite }.to raise_error(ArgumentError)
      end

      context "With a valid token" do
        it "creates a membership record" do
          expect {
            user.accept_invite(invitation.token)
          }.to change(Membership, :count).by(1)
        end

        it "sets the invitation as accepted" do
          i = user.accept_invite(invitation.token)
          expect(i.accepted).to eq true
        end
      end

      context "With an invalid token" do
        it "returns nil" do
          expect(user.accept_invite("fakeToken")).to be_nil
        end
      end
    end
  end
end