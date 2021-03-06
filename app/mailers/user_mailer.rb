class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  #This sends the contact us email
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
    #This sends the password reset email
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end