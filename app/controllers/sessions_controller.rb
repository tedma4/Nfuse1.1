class SessionsController < ApplicationController
  #This controlls the login/log out process

  def new
    #This starts the login process
  end

  def create
    #This logs a user in 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_back_or feed_user_path(user)
    else
      session[:user_id] = nil
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    #This destroys the session a logs a user out
    session[:user_id] = nil
    redirect_to root_url
  end
end