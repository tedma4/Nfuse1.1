class CallbackLinksController < ApplicationController
	include Wicked::Wizard
  steps :callbacks, :avatar_pic
  
  def show
  	@user = current_user
    render_wizard
  end

  def update
	  @user = current_user
	  @user.update_attributes = params[:user]
	  render_wizard @user
	end

private
  def redirect_to_finish_wizard(options = nil)
    redirect_to feed_user_path(@user)
  end
end
