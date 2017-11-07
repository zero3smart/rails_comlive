require 'rails_helper'

feature 'Show Commodity Reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app: app) }

  background do
    log_in(user)
  end

  feature "Visiting #show page" do
    scenario "It should show the commodity reference's details" do
      visit app_commodity_reference_path(app,commodity_reference)

      expect(page).to have_text(commodity_reference.name)
      expect(page).to have_text(commodity_reference.short_description)
      expect(page).to have_text(commodity_reference.long_description)
    end

    scenario "With links present" do
      links = create_list(:link, 2, app_id: app.id, commodity_reference_id: commodity_reference.id )

      visit app_commodity_reference_path(app,commodity_reference)

      links.each do |link|
        expect(page).to have_text(link.description)
        expect(page).to have_link('Open Link', href: link.url)
      end
    end

    scenario "Without any links" do
      visit app_commodity_reference_path(app,commodity_reference)

      expect(page).to have_text("No links found")
    end
  end
end