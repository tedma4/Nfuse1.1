class Registrations::InstagramController < ApplicationController

  def create
    #The omniauth used to authorize an instagram user's posts
    auth = request.env["omniauth.auth"]
    user = User.find(session[:user_id])
    Token.update_or_create_with_other_omniauth(user.id, auth)
    #redirect_to feed_user_path(user)
    redirect_to request.env['omniauth.origin'] || '/default' #callback_links_path(user)
  end

end
