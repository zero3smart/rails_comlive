require 'rails_helper'

feature 'Welcome#contact' do
  let(:message) { OpenStruct.new(name: "John Doe", email: "johndoe@example.com",content: "Example Message")}

  background do
    visit contact_path
  end

  scenario "User can leave a message using the contact us form" do
    fill_in "name", with: message.name
    fill_in "email", with: message.email
    fill_in "message", with: message.content

    click_button "Submit"

    expect(page).to have_content(I18n.t("welcome.contact.success_message"))
  end
end
