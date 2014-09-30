class TwitterRegistrationController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find(session[:user_id])
    Token.update_or_create_with_twitter_omniauth(user.id, auth)
    redirect_to feed_user_path(user)
    #redirect_to feed_user_path(session[:user_id])
  end

  def failure
    redirect_to edit_user_path(session[:user_id]), flash: {:auth_failure => "Authentication failed."}
  end

end