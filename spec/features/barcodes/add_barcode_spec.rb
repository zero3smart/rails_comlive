require 'rails_helper'

feature 'Adding barcode' do
  given(:user) { create(:user) }
  given(:commodity) { create(:commodity, :with_reference, ref_app_id: user.default_app.id) }
  given(:barcode) { build(:barcode) }

  background do
    log_in(user)
    visit commodity_path(commodity)
  end

  context "With valid details" do
    scenario "User can successfully add barcode to a commodity", js: true do
      find("a[data-target='#modalAdd']").click
      within("#modalAdd") do
        click_link "Barcodes"
      end

      select barcode.format.titleize.upcase, from: "barcode[format]"
      fill_in "barcode[content]", with: barcode.content
      fill_in "barcode[name]", with: barcode.name

      click_button "Create Barcode"

      page.execute_script("$('a[href=\"#tab-4\"]').tab('show')")
      find('a[data-original-title="Change view"]').click

      expect(page).to have_text("Barcode successfully created")
      expect(page).to have_text(barcode.content)
      expect(page).to have_text(barcode.name)
      expect(page).to have_css('img[src*="png"]')
    end
  end

  context "With invalid details" do
    scenario "User cannot add the barcode to a commodity" do
      find("a[data-target='#modalAdd']").click
      within("#modalAdd") do
        click_link "Barcodes"
      end

      select barcode.format.titleize.upcase, from: "barcode[format]"
      fill_in "barcode[content]", with: ""

      click_button "Create Barcode"

      expect(page).to have_text("Content can't be blank")
    end
  end
end
