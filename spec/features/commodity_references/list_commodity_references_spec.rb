require 'rails_helper'

feature 'Listing Commodity References' do
  let!(:user) { create(:user) }
  let!(:app) { create(:app) }

  background do
    log_in(user)
  end

  feature "Visiting #index page" do

    context "With commodity references present" do
      background do
        create_list(:commodity_reference, 10, app_id: app.id)
      end

      let(:commodity_references) { app.commodity_references }

      background do
        visit app_commodity_references_path(app)
      end

      scenario 'Should show 5 recently added commodities' do
        expect(page).to have_css('.list-group.recently-added .list-group-item', count: 5)
      end

      scenario 'Commodities should be ordered by date created DESC' do
        expect(page).to have_css(".list-group.recently-added a:first-child", text: commodity_references.recent.first.name)
        expect(page).to have_css(".list-group.recently-added a:last-child", text: commodity_references.recent.limit(5).last.name)
      end
    end

    context "With no commodities" do
      scenario "It should display no commodities found" do
        visit app_commodity_references_path(app)

        expect(page).to have_text("No commodities found")
      end
    end
  end
end