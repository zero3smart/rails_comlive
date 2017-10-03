require 'rails_helper'

feature 'Visiting #index page' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity) { create(:commodity, app_id: app.id) }

  background do
    log_in(user)
  end

  context "With specifications present" do
    scenario "it should list available specifications" do
      @specifications = create_list(:specification, 2, parent: commodity)

      visit app_commodity_specifications_path(app, commodity)

      @specifications.each do |specification|
        expect(page).to have_text(specification.property)
        expect(page).to have_text(specification.value)
        expect(page).to have_text(specification.uom)
      end
    end
  end

  context "With no specifications" do
    scenario "it should display no specifications found" do
      visit app_commodity_specifications_path(app, commodity)

      expect(page).to have_text("No specifications found")
    end
  end
end