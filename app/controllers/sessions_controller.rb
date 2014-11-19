class SessionsController < ApplicationController
  #This controlls the login/log out process

  def new
    #This starts the login process
  end

  def create
    auth = request.env['omniauth.auth']
 
    # Find an authentication or create an authentication
    @authentication = Token.find_with_omniauth(auth)
    if @authentication.nil?
      # If no authentication was found, create a brand new one here
      @authentication = Token.create_with_omniauth(auth)
    end

      if @authentication.user.present?
        # The authentication we found had a user associated with it so let's 
        # just log them in here
        self.current_user = @authentication.user
        #session[:user_id] = current_user.id
        redirect_to hub_user_path(current_user), notice: "Signed in!"
      else
        # The authentication has no user assigned and there is no user signed in
        # Our decision here is to create a new account for the user
        # But your app may do something different (eg. ask the user
        # if he already signed up with some other service)
        if @authentication.provider == 'identity'
        u = User.find(@authentication.uid)
        # otherwise we have to create a user with the auth hash
        else
        u = Token.create_with_omniauth(auth)
        end
        # NOTE: we will handle the different types of data we get back
        # from providers at the model level in create_with_omniauth
        # We can now link the authentication with the user and log him in
        u.tokens << @authentication
        self.current_user = u
        redirect_to callback_links_path, notice: "Welcome to The app!"
      end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path, notice: "Signed out!"
  end

  def failure  
    redirect_to signin_path, alert: "Signin failed, please try again."  
  end

end


