class InvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite.subject
  #
  def invite(invitation)
    @sender = invitation.sender
    @recipient_email = invitation.recipient_email
    @app = invitation.app
    @token = invitation.token

    mail to: @recipient_email, subject: "You have been invited to be an admin of #{invitation.app.name} app on Commodity Live"
  end
end