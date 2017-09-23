require 'rails_helper'

feature 'Upload Image' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given!(:commodity_reference) { create(:commodity_reference, app_id: app.id) }
  given(:image) { build(:image) }

  background do
    log_in(user)
    visit new_app_commodity_reference_image_path(app,commodity_reference)
  end

  scenario "User should be in a position to upload an image", js: true do

    # mock successfull upload event
    find('#image_url', visible: false).set(image.url)

    page.execute_script("$('form#new_image').submit()")

    expect(page).to have_text("Images successfully created")
  end

end
