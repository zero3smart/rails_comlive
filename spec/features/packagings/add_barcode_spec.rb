require 'rails_helper'

feature 'Adding barcode to a packaging' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:packaging) { create(:packaging, commodity_reference_id: commodity_reference.id) }
  given(:barcode) { build(:barcode) }

  background do
    log_in(user)
    visit app_commodity_reference_packaging_path(app, commodity_reference, packaging)
    click_link "Add Barcode"
  end

  context "With valid details" do
    scenario "User can successfully add barcode to a package", js: true do
      select barcode.format.titleize.upcase, from: "barcode[format]"
      fill_in "barcode[content]", with: barcode.content
      fill_in "barcode[name]", with: barcode.name

      click_button "Create Barcode"

      page.execute_script("$('a[href=\"#tab-4\"]').tab('show')")

      expect(page).to have_text("Barcode successfully created")
      expect(page).to have_text(barcode.name)
      expect(page).to have_text(barcode.content)
      expect(page).to have_css('img[src*="png"]')
    end
  end

  context "With invalid details" do
    scenario "User cannot add the barcode to package" do
      select barcode.format.titleize.upcase, from: "barcode[format]"
      fill_in "barcode[content]", with: ""

      click_button "Create Barcode"

      expect(page).to have_text("Content can't be blank")
    end
  end
end
