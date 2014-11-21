module SessionsHelper

  # def sign_in(user)
    # remember_token = User.new_remember_token
    # cookies.permanent[:remember_token] = remember_token
    # user.update_attribute(:remember_token, User.digest(remember_token))
    # self.current_user = user
  # end


  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
 
  def signed_in?
    !!current_user
  end
 
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
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





  # def sign_out
  #   current_user.update_attribute(:remember_token,
  #                                 User.digest(User.new_remember_token))
  #   cookies.delete(:remember_token)
  #   self.current_user = nil
  # end

  #def redirect_back_or(default)
  #  redirect_to(session[:return_to] || default)
  #  session.delete(:return_to)
  #end

  # def store_location
  #   session[:return_to] = request.url if request.get?
  # end
end
