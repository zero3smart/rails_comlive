require 'rails_helper'

feature 'Searching commodity References' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given!(:samsung){ create(:commodity_reference, app_id: app.id, name: "Samsung Tvs") }
  given!(:sony){ create(:commodity_reference,  app_id: app.id, name: "Sony home theatre") }
  given!(:hotpoint){ create(:commodity_reference,  app_id: app.id, name: "Hotpoint electronics") }

  background do
    log_in(user)
    CommodityReference.reindex
    visit app_commodity_references_path(app)
  end

  scenario "returns a list of matching commodity references" do
    fill_in 'commodity-search', with: 'samsung'
    click_button "search-btn"

    expect(page).to have_content(samsung.name)
    expect(page).to have_content(samsung.short_description)
    expect(page).to have_content(samsung.long_description)

    expect(page).not_to have_content(sony.name)
    expect(page).not_to have_content(hotpoint.name)
  end

  scenario "renders a type ahead suggestion", js: true do
    type_ahead("commodity-search", { with: "sony"} )

    expect(page).to have_link(sony.name, href: app_commodity_reference_path(app, sony) )
  end

  scenario "clicking suggestion redirects to commodity reference", js: true do
    type_ahead("commodity-search", { with: "hotpoint"} )

    within("div.tt-dataset") do
      click_link hotpoint.name
    end

    expect(page.current_path).to eq app_commodity_reference_path(app, hotpoint)
  end
end
