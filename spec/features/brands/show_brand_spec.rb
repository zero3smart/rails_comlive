require 'rails_helper'

feature 'Viewing a Brand' do
  given(:user) { create(:user) }
  given(:brand) { create(:brand) }
  given(:official_brand) { create(:official_brand)}
  given(:brand_without_description) { create(:brand, description: nil)}

  context "When user is logged in" do
    background do
      log_in(user)
      visit brand_path(brand)
    end

    scenario "User should see the brands details" do
      expect(page).to have_content(brand.name)
      expect(page).to have_content(brand.description)
      within(".tab-content .box.segment-edit .segment-actions") do
        expect(page).to have_link("Edit", href: edit_brand_path(brand))
      end
      within(".segment-brand .segment-actions") do
        expect(page).to have_link("Edit", href: edit_brand_path(brand))
      end
      expect(page).to have_css("a[data-target='#modalAddBrand']")
    end

    scenario "User should see share link" do
      expect(page).to have_text("Share")
      expect(page).to have_field("share_url")
      expect(find_field('share_url').value).to eq slugged_brand_url(uuid: brand.uuid, title: brand.name.parameterize)
    end

    context "With only name" do
      scenario "It should prompt user to add summary" do
        visit brand_path(brand_without_description)

        expect(page).to have_text(I18n.t("brands.show.tabs.summary.title"))
        expect(page).to have_text(I18n.t("brands.show.tabs.summary.description"))
        expect(page).to have_link(I18n.t("brands.show.tabs.summary.button"))
      end
    end

    context "When brand is official" do
      scenario "It should show all tabs" do
        visit brand_path(official_brand)

        within("div.segment-add") do
          expect(page).to have_text("summary")
          expect(page).to have_text("products")
          expect(page).to have_text("standards")
          expect(page).to have_text("classification")
        end
      end
    end

    context "When brand is not official" do
      scenario "It should show only summary and products tabs" do
        within("div.segment-add") do
          expect(page).to have_text("summary")
          expect(page).to have_text("products")
        end
      end
    end

    context "With no commodities present" do
      scenario "It should show a prompt to add commodities" do
        expect(page).to have_text(I18n.t('brands.show.tabs.commodities.title'))
        expect(page).to have_text(I18n.t('brands.show.tabs.commodities.description'))
        expect(page).to have_link(I18n.t('brands.show.tabs.commodities.button'))
      end
    end
  end

  context "When user is not logged in" do
    background do
      visit slugged_brand_path(uuid: brand.uuid, title: brand.name)
    end

    scenario "User should see only the public brands details" do
      expect(page).to have_content(brand.name)
      expect(page).to have_content(brand.description)
      within(".tab-content .box.segment-edit .segment-actions") do
        expect(page).not_to have_link("Edit", href: edit_brand_path(brand))
      end
      within(".segment-brand .segment-actions") do
        expect(page).not_to have_link("Edit", href: edit_brand_path(brand))
      end

      expect(page).not_to have_css("a[data-target='#modalAddBrand']")
    end
  end
end
