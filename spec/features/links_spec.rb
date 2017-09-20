require 'rails_helper'

feature 'Links' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'secretpass')
    @app = create(:app, user_id: @user.id)
    log_in(@user)
  end

  feature "Visiting #index page" do
    scenario "With links present, it should list available commodities" do
      link_1 = create(:link, app_id: @app.id)
      link_2 = create(:link, app_id: @app.id)

      visit app_links_path(@app)

      expect(page).to have_text(link_1.description)
      expect(page).to have_text(link_1.url)
      expect(page).to have_text(link_2.description)
      expect(page).to have_text(link_2.url)
    end

    scenario "With no links present, it should display no links found" do
      visit app_links_path(@app)

      expect(page).to have_text("No links found")
    end
  end

  feature "Visiting #show page" do
    scenario "It should show the links's details" do
      link = create(:link, app_id: @app.id)
      visit app_link_path(@app, link)

      expect(page).to have_text(link.description)
      expect(page).to have_text(link.url)
    end
  end

  feature "Visiting #new page" do
    background do
      @commodity = create(:commodity)
      visit new_app_link_path(@app)
    end

    scenario "With correct details, user should successfully create a link" do

      fill_in "Url", with: "http://johnsonprohaska.biz/joaquin"
      fill_in "Description", with: "description for link"
      select @commodity.short_description, :from => "link_commodity_id"
      click_button "Create Link"

      expect(page).to have_text("link successfully created")
      expect(page).to have_text("http://johnsonprohaska.biz/joaquin")
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
      @link = create(:link, app_id: @app.id)
      @commodity = create(:commodity)

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
      expect(page).to have_text("https://www.google.com/search?q=strengtheningthenumbers")
    end

    scenario "With incorrect details, link should not be updated" do
      fill_in "Description", with: ""
      click_button "Update Link"

      expect(page).to have_text("Edit Link")
      expect(page).to have_text("Description can't be blank")
    end
  end
end