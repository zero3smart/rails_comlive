require 'rails_helper'

feature 'Standards' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'secretpass')
    @app = create(:app, user_id: @user.id)
    log_in(@user)
  end

  feature "Visiting #index page" do
    scenario "With standards present, it should list available standards" do
      iso_9000 = create(:standard, app_id: @app.id, name: "ISO 9000")
      iso_3000 = create(:standard, app_id: @app.id, name: "ISO 3000")

      visit app_standards_path(@app)

      expect(page).to have_text(iso_9000.name)
      expect(page).to have_text(iso_3000.name)
    end

    scenario "With no standards present, it should display no standards found" do
      visit app_standards_path(@app)

      expect(page).to have_text("No standards found")
    end
  end

  feature "Visiting #new page" do
    background do
      visit new_app_standard_path(@app)
    end

    scenario "With correct details, user should successfully create a standard" do

      fill_in "Name", with: "ISO 3166-1"
      fill_in "Description", with: "ISO 3166-1 is part of the ISO 3166 standard published by the International Organization"

      click_button "Create Standard"

      expect(page).to have_text("Standard successfully created")
      expect(page).to have_text("ISO 3166-1")
      expect(page).to have_text("ISO 3166-1 is part of the ISO 3166 standard published by the International Organization")
    end

    scenario "With incorrect details, the custom unit should not be created" do

      fill_in "Name", with: ""
      fill_in "Description", with: "ISO 3166-1 is part of the ISO 3166 standard published by the International Organization"

      click_button "Create Standard"

      expect(page).to have_text("New Standard")
      expect(page).to have_content("Name can't be blank")
    end
  end

  feature "Visiting #show page" do
    scenario "It should show the standard's details" do
      standard = create(:standard, app_id: @app.id)
      visit app_standard_path(@app, standard)

      expect(page).to have_text(standard.name)
      expect(page).to have_text(standard.description)
    end
  end

  feature "Visiting #edit page" do
    background do
      @standard = create(:standard, app_id: @app.id)
      visit edit_app_standard_path(@app, @standard)
    end

    scenario "should show the current standard's details" do

      expect(page).to have_text("Edit Standard")
      expect(find_field('Name').value).to eq @standard.name
      expect(find_field('Description').value).to eq @standard.description
    end

    feature "with valid details" do
      scenario "user should be able to update the standard" do

        fill_in "Name", with: "ISO 8955"
        fill_in "Description", with: "The alphabetic country codes were first included in ISO 3166 in 1974"

        click_button "Update Standard"

        expect(page).to have_text("Standard successfully updated")
        expect(page).to have_text("ISO 8955")
        expect(page).to have_text("The alphabetic country codes were first included in ISO 3166 in 1974")
      end
    end

    feature "with invalid details" do
      scenario "user should not be able to update the standard" do
        fill_in "Name", with: ""
        click_button "Update Standard"

        expect(page).to have_text("Edit Standard")
        expect(page).to have_text("Name can't be blank")
      end
    end
  end
end