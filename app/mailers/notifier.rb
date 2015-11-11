class Notifier < ActionMailer::Base
  default from: "from@example.com"
  default_url_options[:host] = "localhost:3000"

  def password_reset(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>",
         subject: "Reset Your Password")
  end
end
