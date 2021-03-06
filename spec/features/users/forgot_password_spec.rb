require "spec_helper"

describe "Forgotten passwords" do 
  let!(:user) {create(:user)}
  it "sends the user an email" do 
    visit login_path
    click_link "Forgot Password"
    fill_in "Email", with: user.email
    expect{
      click_button "Reset Password"
      }.to change{ ActionMailer::Base.deliveries.size }.by(1)
  end

  it "resets a password when following the email link" do 
    visit login_path
    click_link "Forgot Password"
    fill_in "Email", with: user.email
    click_button "Reset Password"
    open_email(user.email)
    current_email.click_link "http://"
    expect(page).to have_content("Change your password")


    fill_in "Password", with: "newpassword123"
    fill_in "Password (again)", with: "newpassword123"
    click_button "Change Password"
    expect(page).to have_content("Password updated.")
    expect(page.current_path).to eq(todo_lists_path)

    click_link "Log Out"
    expect(page).to have_content("Successfully Logged Out")

    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "newpassword123"
    click_button "Log In"

    expect(page).to have_content("Thank you for logging in!")
  end
end
