require 'rails_helper'

feature 'Visiting #index page' do
  given(:user) { create(:user) }
  given(:apps) { user.apps << create(:app) } # creates a membership record
  given(:app) { apps.first }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }

  background do
    log_in(user)
  end

  context "With specifications present" do
    scenario "it should list available specifications" do
      @specifications = create_list(:specification, 2, parent: commodity_reference)

      visit app_commodity_reference_specifications_path(app, commodity_reference)

      @specifications.each do |specification|
        expect(page).to have_text(specification.property)
        expect(page).to have_text(specification.value)
        expect(page).to have_text(specification.uom)
      end
    end
  end

  context "With no specifications" do
    scenario "it should display no specifications found" do
      visit app_commodity_reference_specifications_path(app, commodity_reference)

      expect(page).to have_text("No specifications found")
    end
  end
end