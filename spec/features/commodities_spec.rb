require 'rails_helper'

feature 'Commodities' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'secretpass')
    @app = create(:app, user_id: @user.id)
    log_in(@user)
  end

  feature "Visiting #index page" do
    scenario "With commodities present, it should list available commodities" do
      commodity_1 = create(:commodity, app_id: @app.id)
      commodity_2 = create(:commodity, app_id: @app.id)

      visit app_commodities_path(@app)

      expect(page).to have_text(commodity_1.short_description)
      expect(page).to have_text(commodity_2.short_description)
    end

    scenario "With no commodities present, it should display no commodities found" do
      visit app_commodities_path(@app)

      expect(page).to have_text("No commodities found")
    end
  end

  feature "Visiting #show page" do
    scenario "It should show the commodity's details" do
      commodity = create(:commodity, app_id: @app.id)
      visit app_commodity_path(@app, commodity)

      expect(page).to have_text(commodity.short_description)
      expect(page).to have_text(commodity.long_description)
    end
  end

  feature "Visiting #new page" do
    background do
      visit new_app_commodity_path(@app)
    end

    scenario "With correct details, user should successfully create a commodity" do

      fill_in "Short description", with: "a brief short description"
      fill_in "Long description", with: "a very very long description"
      check('Generic')
      click_button "Create Commodity"

      expect(page).to have_text("commodity successfully created")
      expect(page).to have_text("a brief short description")
      expect(page).to have_text("a very very long description")
      expect(page).to have_text("Generic")
    end

    scenario "With incorrect details, a commodity should not be created" do

      fill_in "Short description", with: ""
      fill_in "Long description", with: ""
      click_button "Create Commodity"

      expect(page).to have_text("New Commodity")
      expect(page).to have_content("Short description can't be blank")
      expect(page).to have_content("Long description can't be blank")
    end
  end

  feature "Visiting #edit page" do
    background do
      @commodity = create(:commodity, app_id: @app.id)
      visit edit_app_commodity_path(@app, @commodity)
    end

    scenario "It should show the current commodity's details" do
      expect(page).to have_text("Edit Commodity")
      expect(find_field('Short description').value).to eq @commodity.short_description
      expect(find_field('Long description').value).to eq @commodity.long_description
    end

    context "With valid details" do
      scenario "User should successfully update a commodity" do
        fill_in "Short description", with: "short description updated"
        fill_in "Long description", with: "very long description updated"
        click_button "Update Commodity"

        expect(page).to have_text("commodity successfully updated")
        expect(page).to have_text("short description updated")
        expect(page).to have_text("very long description updated")
      end
    end

    context "With invalid details" do
      scenario "Commodity should not be updated" do
        fill_in "Short description", with: ""
        click_button "Update Commodity"

        expect(page).to have_text("Edit Commodity")
        expect(page).to have_text("Short description can't be blank")
      end
    end
  end
end