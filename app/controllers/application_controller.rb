class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception
  include SessionsHelper

  include PublicActivity::StoreController
#   force_ssl if: :ssl_required?

# private

# def ssl_required?
# # If request came in *through* the load-balancer, this header will be present
#   if request.headers['X-Forwarded-Proto'].present? && !request.ssl? && Rails.env.production?
#     return true
#     end
#     # We came *from* the LB, ie this is a health check, so no ssl required.
#     return false
#   end
end