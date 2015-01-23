module SessionsHelper

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
 
  def signed_in?
    !!current_user
  end
 
  #  I dont see where in the app this is being used.
  def current_user=(user)
    @current_user=user
    session[:user_id] = user.nil? ? 999999999999 : user.id
  end

  def current_user?(user) # get current user
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
