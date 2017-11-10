require 'rails_helper'

feature 'Listing Commodity References' do
  given(:user) { create(:user) }
  given(:commodity) { create(:commodity) }

  context "When user logged in" do
    background do
      log_in(user)
      visit commodity_path(commodity)
    end

    feature "Visiting #show page" do
      scenario "Should show commodity details" do
        expect(page).to have_content commodity.name
        expect(page).to have_content commodity.short_description
        expect(page).to have_content commodity.long_description
      end

      scenario "Should show a qr code" do
        expect(page).to have_css('img.qr_code')
      end
    end
  end

  context "When not logged in" do
    feature "Visiting #show page" do

      background do
        visit slugged_commodity_path(commodity.uuid,commodity.name.parameterize)
      end

      scenario "Should show commodity details" do
        expect(page).to have_content commodity.name
        expect(page).to have_content commodity.short_description
        expect(page).to have_content commodity.long_description
      end

      scenario "Should show a qr code" do
        expect(page).to have_css('img.qr_code')
      end
    end
  end
end