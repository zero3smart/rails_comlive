require 'rails_helper'

feature 'Adding Product From Brand' do
  given(:user) { create(:user) }
  given(:brand) { create(:brand) }
  given(:commodity) { build(:commodity) }

  background do
    log_in(user)
    visit brand_path(brand)
  end

  scenario "Visiting commodity#new should show relevant info only", js: true do
    click_link "Add"

    within("#modalAddBrand") do
      click_link "Product"
    end

    expect(page).to have_content(I18n.t("commodities.new.description.product"))
    expect(page).not_to have_content(I18n.t("commodities.new.description.commodity"))
  end

  scenario "User can successfully create a brand product", js: true do
    click_link "Add"

    within("#modalAddBrand") do
      click_link "Product"
    end

    fill_in 'commodity[name]', with: commodity.name
    fill_in 'commodity[short_description]', with: commodity.short_description
    page.execute_script("$('#commodity_measured_in').selectpicker('val','mass')")

    click_button "Create Commodity"

    expect(page).to have_text(I18n.t("commodities.messages.created"))
    expect(page).to have_text(commodity.name)
    expect(page).to have_text(commodity.short_description)
  end
end
