class ActivitiesController < ApplicationController
	def index
		@activities = PublicActivity::Activity.order(created_at: :desc).where(recipient_id: current_user.id, recipient_type: 'User')#.paginate(page: params[:page], per_page: 10)
    feed                = Feed.new(current_user)
    @providers          = Providers.for(current_user)
    @timeline           = feed.construct(params)
    @unauthed_accounts  = feed.unauthed_accounts
	end
end

# def home
# 	if signed_in?
# 		@providers = Providers.for(current_user)
# 		@timeline  = timeline[:timeline].flatten.sort {|a, b|  b.created_time <=> a.created_time }
# 		# We need to do something with this
# 		# because if each user's details is needed.
# 		# only the last user's data is saved to this loop.
# 		# hence why i put #first at the end of the hash.
#
# 		@unauthed_accounts              = timeline[:unauthed_accounts].first
# 	end
# 	# render 'home' is implicit.
# end
#
# private
#
# def timeline(user=current_user)
# 	stack = {
# 			timeline: [],
# 			unauthed_accounts: [],
# 			feed_unauthed_accounts: []
# 	}
# 	current_user.followed_users.each do |user|
# 		feed=Feed.new(user)
# 		stack[:timeline] << feed.construct(params)
# 		# this is constantly getting over written for each user.
# 		stack[:feed_unauthed_accounts] << feed.unauthed_accounts
# 	end
# 	stack
# end
#
#
#
# def explore_users
# 	@providers = Providers.for(@user)
# 	timeline = []
# 	ids =  current_user.followed_users.collect(&:id)
# 	ids << current_user.id
# 	unless ids.empty?
# 		@users = User.where.not(id: ids)
# 		@users.each do |user|
# 			feed=Feed.new(user)
# 			timeline << feed.construct(params)
# 			@unauthed_accounts              = feed.unauthed_accounts
# 		end
# 	end
# 	@timeline=timeline.flatten.sort { |a, b| b.created_time <=> a.created_time}
# 	render "explore_users"
# end
#
#
# def timeline(user=current_user)
# 	stack = {
# 			timeline: [],
# 			unauthed_accounts: [],
# 			feed_unauthed_accounts: []
# 	}
# 	current_user.followed_users.each do |user|
# 		feed=Feed.new(user)
# 		stack[:timeline] << feed.construct(params)
# 		# this is constantly getting over written for each user.
# 		stack[:feed_unauthed_accounts] << feed.unauthed_accounts
# 	end
# 	stack
# end
#
# def feed
#   feed_builder
#
# end
#
# def feed_builder
#   feed                = Feed.new(@user)
#   @providers          = Providers.for(@user)
#   @timeline           = feed.construct(params)
#   @unauthed_accounts  = feed.unauthed_accounts
#
#   @load_more_url = feed_content_path(
#       twitter_pagination:     feed.twitter_pagination_id,
#       facebook_pagination:    feed.facebook_pagination_id,
#       instagram_max_id:       feed.instagram_max_id,
#       nfuse_post_last_id:     feed.nfuse_pagination_id,
#       youtube_pagination:     feed.youtube_pagination_id,
#       gplus_pagination:       feed.gplus_pagination_id,
#       tumblr_pagination:      feed.tumblr_pagination_id,
#       vimeo_pagination:       feed.vimeo_pagination_id,
#       flickr_pagination:      feed.flickr_pagination_id,
#       id: @user.id)
# end