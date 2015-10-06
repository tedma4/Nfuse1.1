class ActivitiesController < ApplicationController
	# def index
	# 	@activities 				= PublicActivity::Activity.order(created_at: :desc).where(recipient_id: current_user.id,
	# 												recipient_type: 'User')#.paginate(page: params[:page], per_page: 10)
 #    feed                = Feed.new(current_user)
 #    @providers          = Providers.for(current_user)
 #    @timeline           = feed.construct(params)
 #    @unauthed_accounts  = feed.unauthed_accounts

	# end

	def index
	  @activities 	= PublicActivity::Activity.order(created_at: :desc).where(recipient_id: current_user.id,
	                                                                         recipient_type: 'User')
    notification  = Notifications.new(current_user, @post_id, @provider)
	  @providers    = Providers.for(current_user)
    @post_id      = PublicActivity::Activity.last.parameters[:id]
		@provider 		= PublicActivity::Activity.last.parameters[:provider]
	  @timeline     = notification.construct(params)
	end
end


# I need to find out how to associate the id and
#     provider params from the liked post and
#     show it again on the notifications page

# I don't want to re-write all the other models
# to make this work with public activity
