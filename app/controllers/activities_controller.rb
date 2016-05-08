class ActivitiesController < ApplicationController
	# activity_count = current_user.activity_count

	def index
		activity1 = PublicActivity::Activity.includes(:recipient, :owner, :trackable).where(recipient_id: current_user.id, recipient_type: 'User')

		activity2 = PublicActivity::Activity.includes(:owner, :trackable).where("user_recipients LIKE ':id,%' or user_recipients LIKE '%, :id' or user_recipients LIKE '%, :id,%' or user_recipients = ':id'", id: current_user.id)

		total_activities = (activity1 + activity2).sort_by{|t| - t.created_at.to_i}
		if params[:page]
			@activities = get_page_and_offset(11, params[:page].to_i, total_activities)
		else
			@activities = get_page_and_offset(11, 1, total_activities)
		end

		respond_to do |format|
			format.js
		end
	end

	def get_page_and_offset(per_page, page = 1, activities)
		total = activities.length
		if total > 0
			if per_page >= total # 10 or 11
				result = activities.first(total)
				params[:last_page] = page
				return result
			elsif per_page < total # 23

				if ( page * per_page ) < total # 2 * 11 < 23
					if page == 1
						result = activities[0..(per_page - 1)]
						params[:first_page] = page
						return result
					else
						offset_by = ( page - 1 ) * per_page # 1 * 11
						next_page = (page * per_page) - 1
						result = activities[offset_by..next_page]
						params[:middle_page] = page
						return result
					end
				elsif ( page * per_page ) >= total # 3 * 11 > 23
					offset_by = ( page - 1 ) * per_page
					to_end = total - 1
					result = activities[offset_by..to_end]
					params[:last_page] = page
					return result
				else
					# Noting more to do
				end

			else
				# Nothing more to do
			end
		else
			# Do Nothing
		end
	end

	def individual_activity
		@activity = PublicActivity::Activity.find(params[:shout])
		respond_to do |format|
			format.js
		end
	end
end
# Regex to match serialized values in between quotes
#   /(["'])((?:(?!\1)[^\\]|(?:\\\\)*\\[^\\])*)\1/

# Example: 
# string = "{:id=>\"1187467057945665_1072558892769816\", :provider=>\"facebook\"}"
# regex = /(["'])((?:(?!\1)[^\\]|(?:\\\\)*\\[^\\])*)\1/
# string.scan(regex)
# => [["\"", "1187467057945665_1072558892769816"], ["\"", "facebook"]]

# post_id = string.scan(regex)[0][1]
# provider = string.scan(regex)[1][1]