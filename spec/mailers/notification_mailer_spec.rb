require "rails_helper"

RSpec.describe NotificationMailer, :type => :mailer do
  describe "claim" do
    let(:user) { create(:user) }
    let(:ownership) { build(:ownership, parent: user.default_app)  }
    let(:mail) { NotificationMailer.claim(ownership) }

    it "renders the headers" do
      expect(mail.subject).to eq("New Brand Claim")
      expect(mail.to).to eq(["info@ntty.com"])
      expect(mail.from).to eq(["info@ntty.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("App")
      expect(mail.body.encoded).to match("Owner")
      expect(mail.body.encoded).to match("Brand")
    end
  end

  describe "contact_message" do
    let(:message) { OpenStruct.new(name: "John Doe", email: "johndoe@example.com",content: "Example Message")}
    let(:mail) { NotificationMailer.contact_message(message.name, message.email, message.content) }

    it "renders the headers" do
      expect(mail.subject).to eq("Someone contacted you")
      expect(mail.to).to eq(["info@ntty.com"])
      expect(mail.from).to eq(["info@ntty.com"])
      expect(mail.reply_to).to eq([message.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(message.name)
      expect(mail.body.encoded).to match(message.content)
    end
  end
end
