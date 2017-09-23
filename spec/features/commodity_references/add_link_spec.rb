require 'rails_helper'

feature 'Adding link to a commodity reference' do
  given(:user) { create(:user) }
  given(:app) { user.default_app }
  given(:commodity) { create(:commodity) }
  given!(:commodity_reference) { create(:commodity_reference, commodity: commodity, app_id: app.id) }
  given(:link) { build(:link) }

  background do
    log_in(user)
    visit commodity_path(commodity)
  end

  scenario 'User can add a link to a commodity_reference', js: true do
    find(".btn-add.icon.icon-circle.icon-md").click
    within("#modalAdd") do
      click_link "External Link"
    end

    fill_in 'link[url]', with: link.url
    fill_in 'link[description]',with: link.description
    page.execute_script("$('#link_visibility').selectpicker('val','privatized')")

    # select "Private", from: 'link[visibility]'

    click_button 'Create Link'

    page.execute_script("$('a[href=\"#tab-7\"]').tab('show')")

    expect(page).to have_link(link.url, href: link.url)
    expect(page).to have_content(link.description)
    expect(page).to have_text(/Private/i)
    expect(page).to have_content("link successfully created")
  end

end
