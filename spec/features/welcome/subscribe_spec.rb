require 'rails_helper'

feature 'Welcome#subscribe' do
  let(:message) { OpenStruct.new(subscriber_email: "johndoe@email.com")}

  background do
    visit root_path
  end

  scenario "User can subscribe to newsletter" do
    fill_in "subscribe_email", with: message.subscriber_email

    click_button "Subscribe"

    expect(page).to have_content(I18n.t("welcome.subscribe.success_message"))
  end
end
