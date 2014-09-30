class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/login'
    mail(to: user, subject: 'Welcome to My Awesome Site')
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end