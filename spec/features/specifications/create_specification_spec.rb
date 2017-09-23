require 'rails_helper'

feature 'User can create a spec' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:specification) { build(:specification) }
  given!(:custom_units) { create_list(:custom_unit, 4, app_id: app.id) }

  background do
    log_in(user)
    visit new_app_commodity_reference_specification_path(app, commodity_reference)
  end

  context "Creating a predefined spec" do
    scenario "User can create a predefined spec", js: true do
      unit_of_measure = uom("length").sample

      choose("kind_width")
      fill_in "specification[value]", with: specification.value
      select unit_of_measure[0], from: "specification[uom]"

      click_button "Create Specification"

      page.execute_script("$('a[href=\"#tab-1\"]').tab('show')")

      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text("width")
      expect(page).to have_text(specification.value)
      expect(page).to have_text(unit_of_measure[1])
    end

    context "With value empty" do
      scenario "a specification should not be created" do

        fill_in "specification[value]", with: ""
        click_button "Create Specification"

        expect(page).to have_content("can't be blank")
      end
    end
  end

  context "Creating a custom spec" do
    scenario "User can create a spec with custom details", js: true do
      property = properties.sample
      unit_of_measure = uom(property).sample

      page.execute_script("$('input[value=\"custom\"]').click()") # switch tab

      fill_in "specification[property]", with: property
      fill_in "specification[value]", with: specification.value
      select property, from: "type_of_measure"
      select unit_of_measure[0], from: "specification[uom]"

      click_button "Create Specification"

      page.execute_script("$('a[href=\"#tab-1\"]').tab('show')")

      expect(page).to have_text("Specification successfully created")
      expect(page).to have_text(property)
      expect(page).to have_text(specification.value)
      expect(page).to have_text(unit_of_measure[1])
    end

    context "with empty min or max" do
      scenario "a specification should not be created", js: true do
        page.execute_script("$('input[value=\"custom\"]').click()") # switch tab

        find(:css, 'label[for="value-opts_min-max"]').click
        fill_in "specification[min]", with: ""
        fill_in "specification[max]", with: ""
        click_button "Create Specification"

        page.execute_script("$('input[value=\"custom\"]').click()") # switch tab
        find(:css, 'label[for="value-opts_min-max"]').click

        expect(page).to have_content("You must set either a minimum or a maximum value")
      end
    end

    context "When the selected property is from the database" do
      scenario "User should successfully create a specification", js: true do
        custom_unit = custom_units.sample

        page.execute_script("$('input[value=\"custom\"]').click()") # switch tab

        fill_in "specification[property]", with: custom_unit.property
        fill_in "specification[value]", with: specification.value
        select custom_unit.property, from: "type_of_measure"
        select custom_unit.uom, from: "specification[uom]"


        click_button "Create Specification"

        page.execute_script("$('a[href=\"#tab-1\"]').tab('show')")

        expect(page).to have_text("Specification successfully created")
        expect(page).to have_text(custom_unit.property)
        expect(page).to have_text(specification.value)
        expect(page).to have_text(custom_unit.uom)
      end
    end
  end

  scenario "Adding pre-defined units", skip: "Pending"
end

def properties
  Unitwise::Atom.all.uniq.map {|x| "#{x.property}"}.uniq
end

def uom(property)
  uoms = Unitwise::Atom.all.select{|a|
    a.property == property
  }.map {|i| ["#{i.to_s(:names)} (#{i.to_s(:primary_code)})",i.to_s(:primary_code)] }
  custom_units = CustomUnit.where(property: property)
  uoms += custom_units.map{|u| ["#{u.property} (#{u.uom})", u.uom] } if custom_units.any?
  return uoms
end
