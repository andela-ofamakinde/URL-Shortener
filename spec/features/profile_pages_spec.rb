require 'rails_helper'

RSpec.describe "UserProfilePages", type: :request do
describe "User clicks My Profile" do
  it "should take user to profile page" do
    visit root_path
    click_link "Log in"

      visit login_path

      expect(page).to have_content "Email"
      expect(page).to have_content "Password"
    end
  end

  describe "User clicks LogIn" do
    it "should take user to profile page" do
      @user = User.create(name: "lekan",
                        email: "famlek@gmail.com",
                        password: "olalekan",
                        password_confirmation: "olalekan")
      visit login_path
      
      page.fill_in "session_email", :with => "famlek@gmail.com"
      page.fill_in "session_password", :with => "olalekan"
      click_button "Log in"
      expect(current_path).to eq(user_path(@user.id))

      expect(page).to have_content "#{@user.name}"
      expect(page).to have_content "#{@user.email}"
    end
  end
end
