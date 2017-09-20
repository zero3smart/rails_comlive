require 'rails_helper'

feature 'Measurements View' do

  context "As an Authenticated user" do
    background do
      @user = create(:user, email: 'user@example.com', password: 'secretpass')
      @app = create(:app, user_id: @user.id)
      log_in(@user)
    end

    feature "Visiting #index page" do
      scenario "With measurements present, it should list available measurements" do
        measurement_1 = create(:measurement, app_id: @app.id)
        measurement_2 = create(:measurement, app_id: @app.id)

        visit app_measurements_path(@app)

        expect(page).to have_text("#{measurement_1.property}: #{measurement_1.value}#{measurement_1.uom}")
        expect(page).to have_text("#{measurement_2.property}: #{measurement_2.value}#{measurement_2.uom}")
      end

      scenario "With no measurements present, it should display no measurements found" do
        visit app_measurements_path(@app)

        expect(page).to have_text("No measurements found")
      end
    end

    feature "Visiting #new page" do
      background do
        4.times { create(:custom_unit, app: @app) }
        visit new_app_measurement_path(@app)
      end

      context "When the selected property is from the database" do
        scenario "User should successfully create a measurement", js: true do
          custom_unit = @app.custom_units.sample

          select custom_unit.property, from: "measurement_property"
          fill_in "Value", with: "10.56"
          select custom_unit.uom, from: "measurement_uom"

          click_button "Create Measurement"
          expect(page).to have_text("Measurement successfully created")
          expect(page).to have_text("#{custom_unit.property}: 10.56#{custom_unit.uom}")
        end
      end

      context "When the selected property is from unitwise" do
        scenario "User should successfully create a measurement", js: true do
          property = properties.sample
          unit_of_measure = uom(property).sample

          select property, :from => "measurement_property"
          fill_in "Value", with: "5.67"
          select unit_of_measure[0], :from => "measurement_uom"

          click_button "Create Measurement"

          expect(page).to have_text("Measurement successfully created")
          expect(page).to have_text("#{property}: 5.67#{unit_of_measure[1]}")
        end
      end

      scenario "With incorrect details, a measurement should not be created" do

        fill_in "Value", with: ""
        click_button "Create Measurement"

        expect(page).to have_text("New Measurement")
        expect(page).to have_content("Value can't be blank")
      end
    end

    feature "Visiting #show page" do
      scenario "It should show the measurement's details" do
        measurement = create(:measurement, app_id: @app.id)
        visit app_measurement_path(@app, measurement)

        expect(page).to have_text("Measurement Details")
        expect(page).to have_text("#{measurement.property}: #{measurement.value}#{measurement.uom}")
      end
    end

    feature "Visiting #edit page" do
      background do
        @measurement = create(:measurement, app_id: @app.id)
        visit edit_app_measurement_path(@app, @measurement)
      end

      scenario "should show the current measurement's details" do
        uom_value = uom(@measurement.property).select{|u| u[1] == @measurement.uom }.flatten[0]

        expect(page).to have_text("Edit Measurement")
        expect(page).to have_select('measurement_property', selected: @measurement.property)
        expect(find_field('Value').value).to eq @measurement.value.to_s
        expect(page).to have_select('measurement_uom', selected: uom_value)
      end

      feature "with valid details" do
        scenario "user should be able to update the measurement", js: true do
          property = properties.sample
          unit_of_measure = uom(property).sample

          select property, :from => "measurement_property"
          fill_in "Value", with: "30.87"
          select unit_of_measure[0], :from => "measurement_uom"

          click_button "Update Measurement"

          expect(page).to have_text("Measurement updated successfully")
          expect(page).to have_text("#{property}: 30.87#{unit_of_measure[1]}")
        end
      end

      feature "with invalid details" do
        scenario "user should not be able to update the measurement" do
          fill_in "Value", with: ""
          click_button "Update Measurement"

          expect(page).to have_text("Edit Measurement")
          expect(page).to have_text("Value can't be blank")
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
end