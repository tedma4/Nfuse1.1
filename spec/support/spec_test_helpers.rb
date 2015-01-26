module SpecTestHelpers
  def login(user)
    request.session[:user_id] = user.id
  end

  def current_user
    return nil if request.session[:user_id].nil?
    User.find(request.session[:user_id])
  end

  def log_out
    request.session[:user_id] = nil
  end

end