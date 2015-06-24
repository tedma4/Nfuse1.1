class Registrations::TumblrController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find(session[:user_id])
    Token.update_or_create_with_tumblr_omniauth(user.id, auth)
    #redirect_to feed_user_path(user)
    redirect_to request.env['omniauth.origin'] || '/default' # callback_links_path(user)
  end

end
