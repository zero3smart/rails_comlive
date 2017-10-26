require "rails_helper"

RSpec.describe Invitation, :type => :mailer do
  describe "invite" do
    let(:invitation) { create(:invitation) }
    let(:mail) { InvitationMailer.invite(invitation) }

    it "renders the headers" do
      expect(mail.subject).to eq("You have been invited to be an admin of #{invitation.app.name} app on Commodity Live")
      expect(mail.to).to eq([invitation.recipient_email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello #{invitation.recipient_email}")
      expect(mail.body.encoded).to match(invitation.token)
    end
  end

end