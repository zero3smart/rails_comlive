require 'rails_helper'

feature 'Adding barcode to a packaging' do
  given(:user) { create(:user) }
  given(:commodity) { create(:commodity) }
  given(:barcode) { build(:barcode, format: "ean_8", content: "1234567") }

  background do
    log_in(user)
    visit commodity_path(commodity)
    click_link "Add Barcode"
  end

  context "With valid details" do
    scenario "User can successfully add barcode to a package", js: true do
      within("div#sharedModal") do
        select barcode.format.titleize.upcase, from: "barcode[format]"
        fill_in "barcode[content]", with: barcode.content

        click_button "Submit"
      end

      expect(page).to have_text("Barcode successfully created")
      expect(page).to have_text(barcode.format.titleize)
      expect(page).to have_text(barcode.content)
      expect(page).to have_css("table.barby-barcode")
    end
  end

  context "With invalid details" do
    scenario "User cannot add the barcode to package", js: true do
      within("div#sharedModal") do
        select barcode.format.titleize.upcase, from: "barcode[format]"
        fill_in "barcode[content]", with: ""

        click_button "Submit"
      end

      expect(page).to have_text("Content can't be blank")
    end
  end
end