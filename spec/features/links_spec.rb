require 'rails_helper'

feature 'Links' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'secretpass')
    @app = create(:app, user_id: @user.id)
    @commodity = create(:commodity, app_id: @app.id)
    log_in(@user)
  end

  feature "Visiting #new page" do
    background do
      visit new_app_link_path(@app)
    end

    scenario "With correct details, user should successfully create a link" do

      fill_in "Url", with: "http://johnsonprohaska.biz/joaquin"
      fill_in "Description", with: "description for link"
      select @commodity.short_description, :from => "link_commodity_id"
      click_button "Create Link"

      expect(page).to have_text("link successfully created")
      expect(page).to have_link("Open Link", href: "http://johnsonprohaska.biz/joaquin")
      expect(page).to have_text("description for link")
    end

    scenario "With incorrect details, a link should not be created" do

      fill_in "Url", with: ""
      fill_in "Description", with: ""
      select @commodity.short_description, :from => "link_commodity_id"
      click_button "Create Link"

      expect(page).to have_text("Create Link")
      expect(page).to have_content("Url can't be blank")
      expect(page).to have_content("Description can't be blank")
    end
  end

  feature "Visiting #edit page" do
    background do
      @link = create(:link, app_id: @app.id, commodity_id: @commodity.id)
      visit edit_app_link_path(@app, @link)
    end

    scenario "It should show the current link's details" do
      expect(page).to have_text("Edit Link")
      expect(find_field('Url').value).to eq @link.url
      expect(page).to have_select('link_commodity_id', selected: @link.commodity.short_description)
      expect(find_field('Description').value).to eq @link.description
    end

    scenario "With correct details, user should successfully update a link" do
      fill_in "Description", with: "description updated"
      fill_in "Url", with: "https://www.google.com/search?q=strengtheningthenumbers"
      select @commodity.short_description, :from => "link_commodity_id"

      click_button "Update Link"

      expect(page).to have_text("link successfully updated")
      expect(page).to have_text("description updated")
      expect(page).to have_link("Open Link", href: "https://www.google.com/search?q=strengtheningthenumbers")
    end

    scenario "With incorrect details, link should not be updated" do
      fill_in "Description", with: ""
      click_button "Update Link"

      expect(page).to have_text("Edit Link")
      expect(page).to have_text("Description can't be blank")
    end
  end
end