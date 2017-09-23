require 'rails_helper'

feature "Listing Packagings" do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given!(:packagings) { create_list(:packaging,2, commodity_reference_id: commodity_reference.id) }

  context "When user logged in" do
    background do
      log_in(user)
      visit app_commodity_reference_packagings_path(app, commodity_reference)
    end

    scenario "it should list available packagings" do
      packagings.each do |packaging|
        expect(page).to have_content(packaging.name)
        expect(page).to have_content(packaging.quantity)
        expect(page).to have_content(packaging.uom)
      end
    end
  end

  context "When not logged in" do
    background do
      visit packagings_path
    end

    scenario "it should list available packagings" do
      packagings.each do |packaging|
        expect(page).to have_content(packaging.name)
        expect(page).to have_content(packaging.quantity)
        expect(page).to have_content(packaging.uom)
      end
    end
  end
end
