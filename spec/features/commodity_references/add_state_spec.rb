require 'rails_helper'

feature 'Commodity Reference state' do
  given!(:user) { create(:user) }
  given!(:app) { create(:app, user_id: user.id) }
  given!(:commodity_reference) { create(:commodity_reference, app: app) }
  given(:state) { build(:state) }

  background do
    log_in(user)
    visit app_commodity_reference_path(app, commodity_reference)
  end

  scenario 'User can set state to a commodity reference', js: true do
    click_link "Set State"

    within("div#sharedModal") do
      select state.status.titleize, from: 'state[status]'
      fill_in 'state[info]', with: state.info
      fill_in 'state[url]', with: state.url

      click_button 'Submit'
    end

    expect(page).to have_content(state.status.titleize)
    expect(page).to have_content(state.info)
    expect(page).to have_content(state.url)
    expect(page).to have_content("State successfully created")
  end

end