require 'rails_helper'

feature 'Claiming a Brand' do
  given!(:user) { create(:user) }
  given(:brand) { create(:brand) }
  given(:app) { user.apps.sample }

  background do
    log_in(user)
    visit brand_path(brand)
    click_link "Claim this brand"
  end

  scenario "User can claim a brand" do
    select app.name, from: "ownership[parent_id]"
    click_button "Submit Claim"

    expect(page).to have_content(I18n.t("ownerships.messages.created"))
  end
end
