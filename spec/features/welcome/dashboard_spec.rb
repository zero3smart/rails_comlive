require 'rails_helper'

feature 'Welcome#dashboard' do
  given(:user) { create(:user) }

  background do
    log_in(user)
  end

  context "With commodities present" do
    given!(:commodities){ create_list(:commodity, 10) }

    background do
      visit root_path
    end

    scenario "should show a maximum of 5 commodities" do
      expect(page).to have_css('.list-group.recently-added .list-group-item', count: 5)
    end

    context "With previously visited commodities" do
      background do
        commodities.each {|com|
          com.create_reference(user)
          visit commodity_path(com)
        }
        visit root_path
      end

      scenario "should show a list commodities ordered last first" do
        expect(page).to have_css(".list-group.recently-visited a:first-child", text: commodities.last(5).last.name)
        expect(page).to have_css(".list-group.recently-visited a:last-child", text: commodities.last(5).first.name)
      end
    end
  end

  context "With no commodities present" do
    it "should show no commodities found message" do
      expect(page).to have_content("No commodities found")
    end
  end

  context "With no visited commodities" do
    it "should show no recently visited commodities message" do
      expect(page).to have_content("No recent commodities visited")
    end
  end

  scenario "Should have relevant titles" do
    expect(page).to have_content("Add New")
    expect(page).to have_content("Recently Added")
    expect(page).to have_content("Recently Visited")
  end
end
