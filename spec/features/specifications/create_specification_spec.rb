require 'rails_helper'

feature 'Creating a specification' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity) { create(:commodity, app_id: app.id) }
  given!(:custom_units) { create_list(:custom_unit, 4, app_id: app.id) }

  feature "Visiting #new page" do
    background do
      log_in(user)
      visit new_app_commodity_specification_path(app, commodity)
    end

    feature "With valid details" do
      context "When the selected property is from the database" do
        scenario "User should successfully create a specification", js: true do
          custom_unit = custom_units.sample

          select custom_unit.property, from: "specification[property]"
          fill_in "specification[value]", with: "10.56"
          select custom_unit.uom, from: "specification[uom]"

          click_button "Create Specification"

          expect(page).to have_text("Specification successfully created")
          expect(page).to have_text(custom_unit.property)
          expect(page).to have_text("10.56")
          expect(page).to have_text(custom_unit.uom)
        end
      end

      context "When the selected property is from unitwise" do
        scenario "User should successfully create a specification", js: true do
          property = properties.sample
          unit_of_measure = uom(property).sample

          select property, :from => "specification[property]"
          fill_in "specification[value]", with: "5.67"
          select unit_of_measure[0], :from => "specification[uom]"

          click_button "Create Specification"

          expect(page).to have_text("Specification successfully created")
          expect(page).to have_text(property)
          expect(page).to have_text("5.67")
          expect(page).to have_text(unit_of_measure[1])
        end
      end
    end

    feature "With incorrect details" do
      context "With value empty" do
        scenario "a specification should not be created" do

          fill_in "specification[value]", with: ""
          click_button "Create Specification"

          expect(page).to have_content("Value can't be blank")
        end
      end

      context "with empty min or max" do
        scenario "a specification should not be created" do

          fill_in "specification[min]", with: ""
          fill_in "specification[max]", with: ""
          click_button "Create Specification"

          expect(page).to have_content("You must set either a minimum or a maximum value")
        end
      end
    end
  end
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