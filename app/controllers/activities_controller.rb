class ActivitiesController < ApplicationController
	def index
		# @activities = PublicActivity::Activity.order(created_at: :desc)
		# 							.where(recipient_id: current_user.id,
		# 							recipient_type: 'User').paginate(page: params[:page], per_page: 20)

		@activities = PublicActivity::Activity.where("user_recipients LIKE ':id,%' or user_recipients LIKE '%, :id' or user_recipients LIKE '%, :id,%' or user_recipients = ':id'", id: current_user.id)

		# @notification_count = @activities.where(:read => false).count
	end
	def read_all_notifications
		PublicActivity::Activity.where(recipient_id: current_user.id).update_all(:read => true)
		redirect_to :activities
	end
end

# Need to get the two sql queries merged together to form a super query for current user activities

# # Place this in the shout controller create action 
# # @shout.create_activity(key: 'shout.shout', owner: @shout.user, parameters{user: @shout.user.followed_users.pluck(:id)})
# get_user_shit = PublicActivity::Activity.where(recipient_id: current_user.id, recipient_type: 'User')
# # the sql SELECT \"activities\".* FROM \"activities\"  WHERE \"activities\".\"recipient_id\" = 1 AND \"activities\".\"trackable_type\" = 'User'
# get_exclusive = PublicActivity::Activity.where("user_recipients LIKE ':id,%' or user_recipients LIKE '%, :id' or user_recipients LIKE '%, :id,%' or user_recipients = ':id'", id: current_user.id)
# # the sql SELECT \"activities\".* FROM \"activities\"  WHERE (user_recipients LIKE '1,%' or user_recipients LIKE '%, 1' or user_recipients LIKE '%, 1,%' or user_recipients = '1')
# @activities = get_user_shit.merge(get_exclusive)