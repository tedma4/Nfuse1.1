class Registrations::FlickrController < ApplicationController

  def create
    #The omniauth used to authorize a facebook user's posts
    auth = request.env["omniauth.auth"]
    user = User.find(session[:user_id])
    Token.update_or_create_with_flickr_omniauth(user.id, auth)
    #redirect_to feed_user_path(user)
    redirect_to request.env['omniauth.origin'] || '/default' # callback_links_path(user)
  end

end
