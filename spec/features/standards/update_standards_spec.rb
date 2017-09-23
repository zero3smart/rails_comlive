require 'rails_helper'

feature 'Updating a Standard' do
  given(:user){ create(:user) }
  given(:brand) { create(:brand)}
  given(:standard) { create(:standard, brand: brand) }
  given(:new_standard) { build(:standard) }

  background do
    log_in(user)
    visit edit_brand_standard_path(standard, brand)
  end

  feature "Visiting #edit page" do
    scenario "should show the current standard's details" do

      expect(page).to have_text("Edit Standard")
      expect(find_field('standard[name]').value).to eq standard.name
      expect(find_field('standard[description]').value).to eq standard.description
    end

    context "With valid details" do
      scenario "user should be able to update the standard" do

        fill_in "standard[name]", with: new_standard.name
        fill_in "standard[description]", with: new_standard.description

        click_button "Update Standard"

        expect(page).to have_text("Standard successfully updated")
        expect(page).to have_text(new_standard.name)
        expect(page).to have_text(new_standard.description)
      end
    end

    context "With invalid details" do
      scenario "user should not be able to update the standard" do
        fill_in "standard[name]", with: ""
        click_button "Update Standard"

        expect(page).to have_text("Edit Standard")
        expect(page).to have_text("can't be blank")
      end
    end
  end
end
