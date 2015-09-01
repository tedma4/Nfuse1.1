class ActivitiesController < ApplicationController
	def index
		@activities = PublicActivity::Activity.order(created_at: :desc)#.where(owner_id: current_user.followed_users.map {|u| u.id}, owner_type: "User")#.paginate(page: params[:page], per_page: 10)
	end
end
