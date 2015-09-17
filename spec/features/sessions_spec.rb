require 'rails_helper'

RSpec.feature "Sessions", type: :feature do

before(:all) do
    page.driver.browser.manage.window.maximize()
end

  scenario "log in with valid details and redirect to user page" do
    @user = User.create(name: "jeff", email: "jeff@andela.com", password: "jeffwann",
      password_confirmation: "jeffwann")
    visit root_path
    click_link('Log in')

    expect(current_path).to eq(login_path)

    expect(page).to have_selector("h4", text: "Log in")

    fill_in "session_email", with: 'jeff@andela.com'
    fill_in "session_password", with: 'jeffwann'
    click_button('Log in')
    expect(current_path).to eq(user_path(@user.id))

    click_link("jeff logged on")
    click_link("Log out")
    expect(current_path).to eq(root_path)
    expect(page).to have_content "Log in"

  end
end
