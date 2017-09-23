require 'rails_helper'

feature 'Showing a Commodity' do
  given(:user) { create(:user) }
  given(:commodity) { create(:commodity) }
  given!(:commodity_reference) { commodity.create_reference(user) }

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

      scenario "User should see share link" do
        expect(page).to have_text("Share")
        expect(page).to have_field("share_url")
        expect(find_field('share_url').value).to eq slugged_commodity_url(uuid: commodity.uuid, title: commodity.name.parameterize)
      end

      scenario "It should prompt user to add the various items" do
        expect(page).to have_text(I18n.t("commodities.show.tabs.summary.title"))
        expect(page).to have_text(I18n.t("commodities.show.tabs.specifications.title"))
        expect(page).to have_text(I18n.t("commodities.show.tabs.packagings.title"))
        expect(page).to have_text(I18n.t("commodities.show.tabs.standards.title"))
        expect(page).to have_text(I18n.t("commodities.show.tabs.barcodes.title"))
        expect(page).to have_text(I18n.t("commodities.show.tabs.references.title"))
        expect(page).to have_text(I18n.t("commodities.show.tabs.links.title"))
      end

      scenario "Should show a qr code"
      # scenario "Should show a qr code" do
      #   expect(page).to have_css('img.qr_code')
      # end
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

      scenario "Should not have edit links" do
        within(".box.commodity-brand.segment-edit .segment-actions") do
          expect(page).not_to have_link("Edit")
        end

        within(".box.m-0 .segment.segment-edit.segment-header .segment-actions") do
          expect(page).not_to have_link("Edit")
        end

        # within(".row.no-gutter .segment.segment-edit.segment-description .segment-actions") do
          # skip: "We have more than two figure this out"
          # expect(page).not_to have_link("Edit")
        # end
      end

      scenario "Should show a qr code", skip: "Add this when UI ready"
      # scenario "Should show a qr code" do
      #   expect(page).to have_css('img.qr_code')
      # end
    end
  end
end
