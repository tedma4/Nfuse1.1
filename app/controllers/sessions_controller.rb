class SessionsController < ApplicationController
  #This controlls the login/log out process

  def new
    #This starts the login process
  end

def create
 
    if omniauth_env = request.env.fetch("omniauth.auth", nil)
      # That was the issue.
      email = request.env['omniauth.auth']['info']['email']
    else
      email = params['session']['email']
    end

    user = Identity.find_or_create_by(email: email).user
    Token.update_or_create_with_omniauth(user, omniauth_env) if omniauth_env
    #from_omniauth(auth)
    # #User.find_by_provider_and_uid(auth["provider"],
    # auth["uid"]) || User.create_with_omniauth(auth)
 
    if user
      session[:user_id] = user.id
      redirect_to feed_user_path(user), notice: "Signed in!"
    else
      session[:user_id] = nil
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  #def create
  #This logs a user in 
  #  user = Token.from_omniauth(env["omniauth.auth"])
  #  if user
  #    session[:user_id] = user.id
  #    redirect_to feed_user_path(user), notice: "Signed in!"
  #  else
  #    session[:user_id] = nil
  #    flash.now[:error] = 'Invalid email/password combination'
  #    render 'new'
  #  end
  #end

  def destroy
    #This destroys the session a logs a user out
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end