# require 'rails_helper'
# # require 'support/database_cleaner'
# Capybara.default_driver = :selenium


# RSpec.describe "UserProfilePages", type: :request do
# describe "User clicks My Profile" do
#   it "should take user to profile page" do
#     visit root_path
#     click_link "Log in"

#       visit login_path

#       expect(page).to have_content "Email"
#       expect(page).to have_content "Password"
#     end
#   end

#   describe "User clicks LogIn" do
#     it "should take user to profile page" do
#       @user = User.create(name: "lekan",
#                         email: "famlek@yahoo.com",
#                         password: "olalekan",
#                         password_confirmation: "olalekan")
#       # require "pry-nav"; binding.pry
#       # visit root_path
#       # click_link "Sign up"
#       # page.fill_in "user_name", :with => "Toyosi"
#       # page.fill_in "user_email", :with => "toyosi@yahoo.com"
#       # page.fill_in "user_password", :with => "olatoyosi"
#       # page.fill_in "user_password_confirmation", :with => "olatoyosi"
#       # click_button "Sign up"
#       # expect(current_path).to eq root_path
#       # click_link "Log out"

#       visit login_path
#       # require "pry-nav"; binding.pry
      
#       page.fill_in "session_email", :with => "famlek@yahoo.com"
#       page.fill_in "session_password", :with => "olalekan"
#       click_button "Log in"
#       expect(current_path).to eq(user_path(@user.id))

#       # expect(page).to have_content "#{@user._name}"
#       # expect(page).to have_content "#{@user.email}"
#     end
#   end
# end
