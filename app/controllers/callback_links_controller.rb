class CallbackLinksController < ApplicationController
	include Wicked::Wizard
  steps :callbacks
  
  def show
  	@user = current_user
    render_wizard
  end

  def update
	  @user = current_user
	  @user.attributes = params[:user]
	  render_wizard @user
	end

private
	def redirect_to_finish_wizard
	  redirect_to feed_user_path(user), notice: "Thanks for signing up."
	endlo
end
