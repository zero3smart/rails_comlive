require 'rails_helper'

feature 'Listing Standards' do
  given!(:user) { create(:user) }
  given!(:brand) { create(:brand) }

  background do
    log_in(user)
  end

  feature "Visiting #index page" do
    scenario "With standards present, it should list available standards" do
      create_list(:standard, 2)

      visit brand_standards_path(brand)

      Standard.all.each do |standard|
        expect(page).to have_text(standard.name)
      end
      expect(page).to have_text("2 Standards")
    end

    scenario "With no standards present, it should display no standards found" do
      visit brand_standards_path(brand)

      expect(page).to have_text("0 Standards")
    end
  end
end
