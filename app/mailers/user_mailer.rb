class UserMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/login'
    mail(to: user, subject: 'Welcome to My Awesome Site')
  end
end