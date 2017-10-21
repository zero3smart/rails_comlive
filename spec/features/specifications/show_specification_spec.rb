require 'rails_helper'

feature 'User can view a specification' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given!(:specification) { create(:spec_with_min_max, parent: commodity_reference ) }

  background do
    log_in(user)
    visit app_commodity_reference_specification_path(app, commodity_reference, specification)
  end

  feature "Visiting #show page" do
    scenario "It should show the specification's details" do
      expect(page).to have_text("Specification Details")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.min)
      expect(page).to have_text(specification.max)
      expect(page).to have_text(specification.uom)
    end
  end
end
