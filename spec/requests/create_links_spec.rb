require 'rails_helper'
# require 'support/database_cleaner'
Capybara.default_driver = :selenium


RSpec.describe "CreateLinks", type: :request do
  describe "GET /create_links" do
    scenario "page should contain link form details" do
      visit root_path

      expect(page).to have_content "Add a new URL"

      fill_in "link_long_url", :with => "www.google.com"

      click_button "Shorten my URL"
      
      short_url = Link.first.display_short_url

      expect(page).to have_content(short_url)

      click_link short_url

    end
  end
end
