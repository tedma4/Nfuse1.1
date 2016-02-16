class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception
  rescue_from Exception, :with => :handle_exceptions if Rails.env.production? && params[:controller] == 'pages'

  include SessionsHelper

  include PublicActivity::StoreController
  # force_ssl
	private
	def handle_exceptions(e)
		OurAwesomeMailer.experror(e).deliver
		# render :template => "error_mailer/500", :status => 500
	end
end