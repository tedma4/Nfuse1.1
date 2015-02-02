class Registrations::TwitterController < ApplicationController

  def create
    #The omniauth is used to authorize a twitter user's posts
    auth = request.env["omniauth.auth"]
    user = User.find(session[:user_id])
    Token.update_or_create_with_twitter_omniauth(user.id, auth)
    #redirect_to feed_user_path(user)
    redirect_to request.env['omniauth.origin'] || '/default' #callback_links_path(user)
    #redirect_to feed_user_path(session[:user_id])
  end

  def failure  
    redirect_to request.env['omniauth.origin'] || '/default', alert: "Something happened, please try again."  
  end
end
