require 'rails_helper'

feature 'Show Commodities' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'secretpass')
    @app = create(:app, user_id: @user.id)
    log_in(@user)
    @commodity =  create(:commodity, app_id: @app.id)
  end

  feature "Visiting #show page" do
    scenario "It should show the commodity's details" do
      visit app_commodity_path(@app, @commodity)
      expect(page).to have_text(@commodity.short_description)
      expect(page).to have_text(@commodity.long_description)
    end

    scenario "With links present" do
      link_1 = create(:link, app_id: @app.id, commodity_id: @commodity.id)
      link_2 = create(:link, app_id: @app.id, commodity_id: @commodity.id)

      visit app_commodity_path(@app, @commodity)

      expect(page).to have_text(link_1.description)
      expect(page).to have_link('Open Link', href: link_1.url)
      expect(page).to have_text(link_2.description)
      expect(page).to have_link('Open Link', href:link_2.url)
    end

    scenario "Without any links" do
      visit app_commodity_path(@app, @commodity)
      expect(page).to have_text("No links found")
    end
  end
end