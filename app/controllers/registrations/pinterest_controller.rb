class Registrations::PinterestController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find(session[:user_id])
    Token.update_or_create_with_other_omniauth(user.id, auth)
    redirect_to request.env['omniauth.origin'] || '/default' # callback_links_path(user)
  end
end