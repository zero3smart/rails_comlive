require 'rails_helper'

feature 'Adding specification to a commodity' do
  given!(:user) { create(:user, email: 'user@example.com', password: 'secretpass') }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity) { create(:generic_commodity, app_id: app.id) }
  given(:specification) { build(:spec_with_min_max, value: 34.90) }


  background do
    log_in(user)
    visit app_commodity_path(app, commodity)
  end

  feature 'User can add a specification to a commodity', js: true do
    background do
      click_link "Add Specification"
    end

    scenario "Providing only value" do
      within("div#sharedModal") do
        select specification.property, from: "specification[property]"
        fill_in "specification[value]", with: specification.value
        select "Joule (J)", from: "specification[uom]"

        click_button "Submit"
      end
      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.value)
      expect(page).to have_text(specification.uom)
    end

    scenario "Providing either a min or a max" do
      within("div#sharedModal") do
        select specification.property, from: "specification[property]"
        choose('Define Min / Max')
        fill_in 'specification[min]', with: specification.min
        fill_in 'specification[max]', with: specification.max
        select "Joule (J)", from: "specification[uom]"

        click_button "Submit"
      end
      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(specification.property)
      expect(page).to have_text(specification.min)
      expect(page).to have_text(specification.max)
      expect(page).to have_text(specification.uom)
    end
  end
end