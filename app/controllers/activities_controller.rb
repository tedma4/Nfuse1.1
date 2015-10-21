class ActivitiesController < ApplicationController
	def index
		@activities = PublicActivity::Activity.order(created_at: :desc)
									.where(recipient_id: current_user.id,
									recipient_type: 'User').paginate(page: params[:page], per_page: 10)
		# @notification_count = @activities.where(:read => false).count
	end
	def read_all_notifications
		PublicActivity::Activity.where(recipient_id: current_user.id).update_all(:read => true)
		redirect_to :activities
	end
end

# Part of the new index method
# exclusive_posts = PublicActivity::Activity.where(trackable_type: 'Shout', parameters: {user: current_user.id})

# if exclusive_posts.empty?
# 	@activities << exclusive_posts
# else 
# 	@activities
# end

# Place this in the shout controller create action 
# @shout.create_activity(key: 'shout.shout', owner: @shout.user, parameters{user: @shout.user.followed_users.pluck(:id)})
