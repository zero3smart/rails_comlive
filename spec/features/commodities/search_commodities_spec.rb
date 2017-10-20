require 'rails_helper'

feature 'Searching commodities' do
  given!(:user) { create(:user, email: 'user@example.com', password: 'secretpass') }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:samsung){ create(:commodity, app_id: app.id, name: "Samsung Tvs") }
  given!(:sony){ create(:commodity,  app_id: app.id, name: "Sony home theatre") }
  given!(:hotpoint){ create(:commodity,  app_id: app.id, name: "Hotpoint electronics") }

  background do
    log_in(user)
    Commodity.reindex
    visit app_commodities_path(app)
  end

  scenario "returns a list of matching commodities" do
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

    expect(page).to have_link(sony.name, href: app_commodity_path(app, sony) )
  end

  scenario "clicking suggestion redirects to commodity", js: true do
    type_ahead("commodity-search", { with: "hotpoint"} )

    within("div.tt-dataset") do
      click_link hotpoint.name
    end

    expect(page.current_path).to eq app_commodity_path(app, hotpoint)
  end
end
