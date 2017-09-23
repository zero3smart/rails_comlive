require 'rails_helper'

feature 'Create Link' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given!(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:link) { build(:link) }

  background do
    log_in(user)
    visit new_app_commodity_reference_link_path(app,commodity_reference)
  end

  feature "Visiting #new page" do
    scenario "With correct details, user should successfully create a link" do

      fill_in "link[url]", with: link.url
      fill_in "link[description]", with: link.description

      click_button "Create Link"

      expect(page).to have_text("link successfully created")
      expect(page).to have_link(link.url, href: link.url)
      expect(page).to have_text(link.description)
    end

    scenario "With incorrect details, a link should not be created" do

      fill_in "link[url]", with: ""
      fill_in "link[description]", with: ""

      click_button "Create Link"

      expect(page).to have_button("Create Link")
      expect(page).to have_content("Url can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
  end
end
