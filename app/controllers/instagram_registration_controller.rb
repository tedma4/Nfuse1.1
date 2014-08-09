class InstagramRegistrationController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find(session[:user_id])
    Token.update_or_create_with_omniauth(user.id, auth)
    redirect_to '/'
  end

end