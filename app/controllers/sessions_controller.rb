class SessionsController < ApplicationController
  #This controlls the login/log out process

  def new
    #This starts the login process
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) #if params[:session].present? #params[:session][:email].nil?
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to explore_user_path(current_user)
    else
      session[:user_id] = nil
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # def fb_callback
  #   auth = request.env['omniauth.auth']
  #   if User.find_by(providers: auth['provider'], uid: auth['uid']).nil?
  #     user = User.omniauth(auth)
  #   else
  #     user = User.find_by(providers: auth['provider'], uid: auth['uid'])
  #   end
  #   session[:user_id] = user.id
  #   redirect_to root_url
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end


