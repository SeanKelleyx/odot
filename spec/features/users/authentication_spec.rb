require 'spec_helper'

def login
  User.create(first_name: "name", last_name: "last", email: "name@domain.com", password: "password123", password_confirmation: "password123")
  visit new_user_session_path

  fill_in "Email Address", with: "name@domain.com"
  fill_in "Password", with: "password123"
  click_button "Log In"
end

describe "Logging in" do

  it "logs the user in and goes to the todo list" do 
    login

    expect(page).to have_content "Todo Lists"
    expect(page).to have_content "Thank you for logging in"
  end

  it "displays the email address in the event of a failed login" do 
    visit new_user_session_path

    fill_in "Email Address", with: "name@domain.com"
    fill_in "Password", with: "incorrect"
    click_button "Log In"

    expect(page).to have_field("Email Address", with: "name@domain.com")
  end

  it "shows log in button when not logged in" do 
    visit root_path
    expect(page).to_not have_content("Log Out")
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Log In")
  end

  it "when logged in displays the logout link" do
    login

    expect(page).to have_content("Log Out")
    expect(page).to_not have_content("Log In")
  end

  it "when logged in, clicking the log out button logs out the user" do 
    login  
    click_link "Log Out"
    expect(page).to have_content("Log In")
  end
end