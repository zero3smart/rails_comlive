require 'rails_helper'

feature 'Listing Commodities' do
  given(:user) { create(:user) }
  given(:commodity_ids) { create_list(:commodity, 10).map(&:id) }

  context "When user logged in" do
    background do
      log_in(user)
    end

    feature "Visiting #index page" do

      context "With commodities present" do
        given!(:commodities) { Commodity.where(id: commodity_ids) }

        background do
          visit commodities_path
        end

        scenario 'Should show 5 recently added commodities' do
          expect(page).to have_css('.list-group.recently-added .list-group-item', count: 5)
        end

        scenario 'Commodities should be ordered by date created DESC' do
          expect(page).to have_css(".list-group.recently-added a:first-child", text: commodities.recent.first.name)
          expect(page).to have_css(".list-group.recently-added a:last-child", text: commodities.recent.limit(5).last.name)
        end
      end

      context "With no commodities" do
        scenario "It should display no commodities found" do
          visit commodities_path

          expect(page).to have_text("No commodities found")
        end
      end
    end
  end

  context "When not logged in" do
    feature "Visiting #index page" do
      context "With commodities present" do
        given!(:commodities) { Commodity.where(id: commodity_ids) }

        background do
          visit commodities_path
        end

        scenario 'Should show 5 recently added commodities' do
          expect(page).to have_css('.list-group.recently-added .list-group-item', count: 5)
        end

        scenario 'Commodities should be ordered by date created DESC' do
          expect(page).to have_css(".list-group.recently-added a:first-child", text: commodities.recent.first.name)
          expect(page).to have_css(".list-group.recently-added a:last-child", text: commodities.recent.limit(5).last.name)
        end
      end

      context "With no commodities present" do
        scenario "It should display no commodities found" do
          visit commodities_path

          expect(page).to have_text("No commodities found")
        end
      end
    end
  end
end