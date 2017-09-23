require 'rails_helper'

feature 'Searching commodities' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given!(:samsung){ create(:commodity, name: "Samsung Tvs") }
  given!(:sony){ create(:commodity,  name: "Sony home theatre") }
  given!(:hotpoint){ create(:commodity, name: "Hotpoint electronics") }

  background do
    log_in(user)
    Commodity.reindex
    Commodity.all.each{|c|
      c.create_reference(user)
    }
    visit commodities_path(app)
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

    expect(page).to have_link(sony.name, href: commodity_path(sony) )
  end

  scenario "clicking suggestion redirects to the commodity", js: true do
    type_ahead("commodity-search", { with: "hotpoint"} )

    within("div.tt-dataset") do
      click_link hotpoint.name
    end

    expect(page.current_path).to eq commodity_path(hotpoint)
  end

  scenario "When user not logged in", skip: "Address case when user is not logged in" do
  end
end

