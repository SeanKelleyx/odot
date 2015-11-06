def sign_in(user, options={})
  visit "/login"
  fill_in "Email", with: user.email
  fill_in "Password", with: options[:password]
  click_button "Log In"
end