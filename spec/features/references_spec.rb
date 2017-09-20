require 'rails_helper'

feature 'References' do
  background do
    @user = create(:user, email: 'user@example.com', password: 'secretpass')
    @app = create(:app, user_id: @user.id)
    log_in(@user)
  end

  feature "Visiting #index page" do
    scenario "With references present, it should list available references" do
      reference_1 = create(:reference, app: @app)
      reference_2 = create(:reference, app: @app)

      visit app_references_path(@app)

      expect(page).to have_text("References")
      expect(page).to have_content(reference_1.kind)
      expect(page).to have_content(reference_1.source_commodity.short_description)
      expect(page).to have_content(reference_2.kind)
      expect(page).to have_content(reference_2.source_commodity.short_description)
    end

    scenario "With no links present, it should display no references found" do
      visit app_references_path(@app)

      expect(page).to have_text("No references found")
    end
  end

  feature "Visiting #show page" do
    scenario "It should show the reference's details" do
      reference = create(:reference, app_id: @app.id)
      visit app_reference_path(@app, reference)

      expect(page).to have_text(reference.kind)
      expect(page).to have_text(reference.description)
      expect(page).to have_text(reference.source_commodity.short_description)
      expect(page).to have_text(reference.target_commodity.short_description)
    end
  end

  feature "Visiting #new page" do
    background do
      @generic_commodity = create(:commodity, generic: true)
      @commodity = create(:commodity)
      visit new_app_reference_path(@app)
    end

    scenario "With correct details, user should successfully create a link" do

      select "specific_of", :from => "reference_kind"
      select @generic_commodity.short_description, :from => "reference_source_commodity_id"
      select @commodity.short_description, :from => "reference_target_commodity_id"
      fill_in "Description", with: "description for reference"
      click_button "Create Reference"

      expect(page).to have_text("reference successfully created")
      expect(page).to have_text("description for reference")
      expect(page).to have_text("specific_of")
    end

    scenario "With incorrect details, a link should not be created" do

      fill_in "Description", with: ""
      select "specific_of", :from => "reference_kind"
      click_button "Create Reference"

      expect(page).to have_text("New Reference")
      expect(page).to have_content("Description can't be blank")
    end
  end

  feature "Visiting #edit page" do
    background do
      @reference = create(:reference, app_id: @app.id, kind: "variation_of")
      visit edit_app_reference_path(@app, @reference)
    end

    scenario "It should show the current reference's details" do
      expect(page).to have_text("Edit Reference")
      expect(page).to have_select('reference_kind', selected: @reference.kind)
      expect(page).to have_select('reference_source_commodity_id', selected: @reference.source_commodity.short_description)
      expect(page).to have_select('reference_target_commodity_id', selected: @reference.target_commodity.short_description)
      expect(find_field('Description').value).to eq @reference.description
    end

    context "With valid details" do
      scenario "User should successfully update a link" do
        fill_in "Description", with: "description of reference updated"
        select "alternative_to", :from => "reference_kind"

        click_button "Update Reference"

        expect(page).to have_text("reference successfully updated")
        expect(page).to have_text("description of reference updated")
        expect(page).to have_text("alternative_to")
      end
    end

    context "With invalid details" do
      scenario "Link should not be updated" do
        fill_in "Description", with: ""
        click_button "Update Reference"

        expect(page).to have_text("Edit Reference")
        expect(page).to have_text("Description can't be blank")
      end
    end
  end
end