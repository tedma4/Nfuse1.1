class ActivitiesController < ApplicationController
	# def index
	# 	@activities 	= PublicActivity::Activity.order(created_at: :desc).where(recipient_id: current_user.id,
	# 																																				 recipient_type: 'User')
	# 	feed                = Feed.new(current_user)
	# 	@providers          = Providers.for(current_user)
	# 	@timeline           = feed.construct(params)
	# 	@unauthed_accounts  = feed.unauthed_accounts
	# end

	def index
		@activities 	= PublicActivity::Activity.order(created_at: :desc).where(recipient_id: current_user.id,
																									 recipient_type: 'User')
		@post_id      = @activities.where(trackable_type: 'User').last.parameters[:id]
		@provider 		= @activities.where(trackable_type: 'User').last.parameters[:provider]
		notify        = Notification::Timeline.new(@post_id, @provider, current_user)
		@post_entry   = notify.construct
		@post_entry
	end

end
#
# @post_id      = @activities.where(trackable_type: 'User').pluck(:parameters).map do |id| {id: id[:id]} end
# @provider 		= @activities.where(trackable_type: 'User').pluck(:parameters).map do |provider| {provider: provider[:provider]} end
# I need to associate the post id and provider to the individual Activity