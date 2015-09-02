class ActivitiesController < ApplicationController
	def index
		@activities = PublicActivity::Activity.order(created_at: :desc).where(recipient_id: current_user.id, recipient_type: 'User').paginate(page: params[:page], per_page: 10)
	end
end
