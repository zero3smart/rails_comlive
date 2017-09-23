require 'rails_helper'

feature 'Packaging#show' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:packaging) { create(:packaging, commodity_reference_id: commodity_reference.id) }

  background do
    log_in(user)
    visit app_commodity_reference_packaging_path(app, commodity_reference, packaging)
  end

  scenario "User should see packaging details" do
    expect(page).to have_content(packaging.name)
    expect(page).to have_content(packaging.quantity)
    expect(page).to have_content(packaging.description)
    expect(page).to have_content(packaging.uom)
  end

  scenario "User should see share link" do
    expect(page).to have_text("Share")
    expect(page).to have_field("share_url")
    expect(find_field('share_url').value).to eq slugged_packaging_url(uuid: packaging.uuid, title: packaging.name.parameterize)
  end

  context "When not logged in" do
    scenario "Should show a qr code" do
      expect(page).to have_css("img.qr_code")
    end

    scenario "Should show packaging details" do
      expect(page).to have_content(packaging.name)
      expect(page).to have_content(packaging.quantity)
      expect(page).to have_content(packaging.description)
      expect(page).to have_content(packaging.uom)
    end
  end

end
