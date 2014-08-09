class TwitterRegistrationController < ApplicationController

  def create
    begin
      Token.update_or_create_with_omniauth(current_user, request.env["omniauth.auth"])
      flash[:twitter_success] = "You have successfully Nfused Twitter"
    rescue ActiveRecord::RecordInvalid
      flash[:registration_failure] = "Registration with Twitter failed, please try again"
    end
    redirect_to feed_path
  end

end