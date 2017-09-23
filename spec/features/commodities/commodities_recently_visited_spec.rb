require 'rails_helper'

feature 'Recently Visited Commodities' do
  given(:user) { create(:user) }
  given(:commodities){ create_list(:commodity, 10) }

  background do
    log_in(user)
    commodities.each {|com|
      com.create_reference(user)
      visit commodity_path(com)
    }
    visit commodities_path
  end

  scenario "should show a maximum of 5 commodities" do
    expect(page).to have_css('.list-group.recently-visited .list-group-item', count: 5)
  end

  scenario "should show a list commodities ordered last first" do
    expect(page).to have_css(".list-group.recently-visited a:first-child", text: commodities.last(5).last.name)
    expect(page).to have_css(".list-group.recently-visited a:last-child", text: commodities.last(5).first.name)
  end
end
