class ActivitiesController < ApplicationController
	def index
		@activities = PublicActivity::Activity.order(created_at: :desc)
									.where(recipient_id: current_user.id,
									recipient_type: 'User')#Add will paginate stuff
		# @notification_count = @activities.where(:read => false).count
	end
	
	def read_all_notifications
		PublicActivity::Activity.where(recipient_id: current_user.id).update_all(:read => true)
		render nothing: true
	end
end


