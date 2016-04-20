class CallbackLinksController < ApplicationController
	include Wicked::Wizard
  prepend_before_filter :set_steps
  # prepend_before_action :setup_wizard
  #steps :callbacks, :avatar_pic, :username
  
  def show
  	@user = current_user
    render_wizard
  end

  def update
	  @user = current_user
	  @user.update_attributes = params[:user]
	  render_wizard
	end

private
  def set_steps
    if current_user.tokens.empty?
      self.steps = [:avatar_pic, :callbacks]
    else
      self.steps = [:username, :callbacks]
    end
  end

  def redirect_to_finish_wizard(options = nil)
    redirect_to feed_user_path(@user)
  end
end
