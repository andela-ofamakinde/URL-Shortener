require 'rails_helper'
# require 'support/database_cleaner'
Capybara.default_driver = :selenium
Capybara.server_port = 31337


RSpec.describe "CreateLinks", type: :request do
  describe "GET /create_links" do
    scenario "page should contain link form details" do
      visit root_path

      expect(page).to have_content "Add a new URL"

      fill_in "link_long_url", :with => "www.google.com"

      click_button "Shorten my URL"
      
      short_url = Link.first.short_url

      expect(page).to have_content(short_url)

      host_port = "localhost:31337/"
      short_url = host_port+short_url
      visit "#{short_url}"

      expect(page).to have_content("Google")

      expect(Link.first.analytic.visits).to eq(1)

    end
  end
end
