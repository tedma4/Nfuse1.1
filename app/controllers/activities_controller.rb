class ActivitiesController < ApplicationController
	before_action :set_activity, only: :show
	def show
		@activity 		= set_activity
		@post_id      = @activity.parameters[:id]
		@provider 		= @activity.parameters[:provider]
		@activities 	= PublicActivity::Activity.order(created_at: :desc).where(recipient_id: current_user.id,
																									 recipient_type: 'User')
		notify        = Notification::Timeline.new(@post_id, @provider, current_user)
		@post_entry   = notify.construct
		@post_entry
	end

	private

	def set_activity
		PublicActivity::Activity.where(trackable_type: 'User').find(params[:id])
	end

end
#
# @post_id      = @activities.where(trackable_type: 'User').pluck(:parameters).map do |id| {id: id[:id]} end
# @provider 		= @activities.where(trackable_type: 'User').pluck(:parameters).map do |provider| {provider: provider[:provider]} end
# I need to associate the post id and provider to the individual Activity