require 'rails_helper'
Capybara.default_driver = :selenium


RSpec.describe "CreateLinks", type: :request do
  describe "GET /create_links" do
    scenario "page should contain link form details" do
      visit root_path

      expect(page).to have_content "Add a new URL"

      fill_in "link_long_url", :with => "www.google.com"

      click_button "Shorten my URL"

      expect(page).to have_content "http://localhost:3000"
    end
  end

  describe "GET /redirect link" do
    scenario "page should redirect the short url to long url" do

      visit root_path

      fill_in "link_long_url", :with => "www.google.com"
      require "pry-nav"; binding.pry

      @link = Link.create(long_url: "www.google.com")


      @short_url = @link.display_short_url

      click_button "Shorten my URL"

      expect(page).to have_content @short_url


    #   click_link "Sign up"

    #   expect(current_path).to eq signup_path
    # end

    # scenario "page should contain form details" do
    #   visit signup_path
    #   expect(page).to have_content "Name"
    #   expect(page).to have_content "Email"
    #   expect(page).to have_content "Password"
    #   expect(page).to have_content "Password confirmation"
  end
  end
end
