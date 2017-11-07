require 'rails_helper'

feature 'Update Link' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:link) { create(:link, app_id: app.id, commodity_reference: commodity_reference) }

  background do
    log_in(user)
    visit edit_app_link_path(app, link)
  end

  feature "Visiting #edit page" do
    scenario "It should show the current link's details" do
      expect(page).to have_text("Edit Link")
      expect(find_field('link[url]').value).to eq link.url
      expect(page).to have_select('link[commodity_reference_id]', selected: link.commodity_reference.name)
      expect(find_field('link[description]').value).to eq link.description
    end

    context "With correct details" do
      scenario "user should successfully update a link" do
        fill_in "link[description]", with: "description updated"
        fill_in "link[url]", with: "https://www.google.com/search?q=strengtheningthenumbers"
        select commodity_reference.name, :from => "link[commodity_reference_id]"

        click_button "Update Link"

        expect(page).to have_text("link successfully updated")
        expect(page).to have_text("description updated")
        expect(page).to have_link("Open Link", href: "https://www.google.com/search?q=strengtheningthenumbers")
      end
    end

    context "With incorrect details" do
      scenario "link should not be updated" do
        fill_in "link[description]", with: ""
        click_button "Update Link"

        expect(page).to have_text("Edit Link")
        expect(page).to have_text("Description can't be blank")
      end
    end
  end
end