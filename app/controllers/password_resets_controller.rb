class PasswordResetsController < ApplicationController
  #This controlls the password reset process
	include UsersHelper
  def new
    #This starts the password reset process
  end

  def create
    #This sends the email to the Nfuse user that has issued a password reset request
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end
  
  def edit
    #This starts the update password process
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    #This updates a users password and saves it
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(user_params)
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end