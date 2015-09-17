require 'rails_helper'

RSpec.describe "UserSignUp", type: :request do
  describe "GET /user_signups" do
    before(:all) do
        page.driver.browser.manage.window.maximize()
    end
    scenario "should visit sign up page" do
      visit root_path

      click_link "Sign up"

      expect(current_path).to eq signup_path
    end

    scenario "page should contain form details" do
      visit signup_path
      expect(page).to have_content "Name"
      expect(page).to have_content "Email"
      expect(page).to have_content "Password"
      expect(page).to have_content "Password confirmation"
    end
  end

  describe "On successful user sign up" do
    scenario "should redirect the user to the home page" do
      visit root_path
      click_link "Sign up"

      page.fill_in "user_name", :with => "Toyosi"
      page.fill_in "user_email", :with => "toyosi@yahoo.com"
      page.fill_in "user_password", :with => "olatoyosi"
      page.fill_in "user_password_confirmation", :with => "olatoyosi"
      click_button "Sign up"
      expect(current_path).to eq root_path
    end
  end

  # describe "Unsuccessful user sign up" do
  #   scenario "should redirect the user to the signup page with invalid email" do
  #     visit new_user_path
  #     page.fill_in "user_name", :with => "Toyosi"
  #     page.fill_in "user_email", :with => "toyosiyahoo.com"
  #     page.fill_in "user_password", :with => "olatoyosi"
  #     page.fill_in "user_password_confirmation", :with => "olatoyosi"
 
  #     click_button "Sign up"
  #     require "pry-nav"; binding.pry
  #     expect(current_path).to eq "/users/new"
  #   end
  # end
end
