class Registrations::FacebookController < ApplicationController

  def create
    #The omniauth used to authorize a facebook user's posts
    auth = request.env["omniauth.auth"]
    if session[:user_id].nil?
      if User.find_by(providers: auth['provider'], uid: auth['uid']).nil?
        user = User.omniauth(auth)
        session[:user_id] = user.id
        redirect_to callback_links_path
      else
        user = User.find_by(providers: auth['provider'], uid: auth['uid'])
        session[:user_id] = user.id
        redirect_to root_url
      end
    else
      user = User.find(session[:user_id])
      Token.update_or_create_with_other_omniauth(user.id, auth)
      #redirect_to feed_user_path(user)
      redirect_to request.env['omniauth.origin'] || '/default' # callback_links_path(user)
    end
  end
end
