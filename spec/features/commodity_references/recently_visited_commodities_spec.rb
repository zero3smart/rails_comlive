require 'rails_helper'

feature 'Recently Visited Commodity References' do
  let!(:user) { create(:user) }
  let!(:app) { create(:app, user_id: user.id) }
  let!(:commodity_references){ create_list(:commodity_reference, 10, app_id: app.id) }

  background do
    log_in(user)
    commodity_references.each {|cr| visit app_commodity_reference_path(app,cr) }
    visit app_commodity_references_path(app)
  end

  scenario "should show a maximum of 5 commodities" do
    expect(page).to have_css('.list-group.recently-visited .list-group-item', count: 5)
  end

  scenario "should show a list commodities ordered last first" do
    expect(page).to have_css(".list-group.recently-visited a:first-child", text: commodity_references.last(5).last.name)
    expect(page).to have_css(".list-group.recently-visited a:last-child", text: commodity_references.last(5).first.name)
  end
end