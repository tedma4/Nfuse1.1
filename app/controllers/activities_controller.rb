class ActivitiesController < ApplicationController
	# activity_count = current_user.activity_count

	def index
		activity1 = PublicActivity::Activity.includes(:recipient, :owner, :trackable).where(recipient_id: current_user.id, recipient_type: 'User')

		activity2 = PublicActivity::Activity.includes(:owner, :trackable).where("user_recipients LIKE ':id,%' or user_recipients LIKE '%, :id' or user_recipients LIKE '%, :id,%' or user_recipients = ':id'", id: current_user.id)
		@activities = (activity1 + activity2).sort_by{|t| - t.created_at.to_i}
		@activities
		# if params[:page]
		# 	@activities.get_page_and_offset(count, offset_by, params[:page])
		# else
		# 	@activities.get_page_and_offset(count, offset_by, 1)
		# end

		respond_to do |format|
			format.js
		end
	end

	def self.get_page_and_offset(per_page = 11, offset_by = 0, page = 1)
		if activity_count > 0
			if per_page >= activity_count # 10 or 11
				self.limit(activity_count)

			elsif per_page < activity_count # 23

				if ( page * per_page ) < activity_count # 2 * 11 < 23
					if page == 1
						self.limit(per_page)
					else
						offset_by = ( page - 1 ) * per_page # 1 * 11
						self.limit(per_page).offset(offset_by)
					end
				elsif ( page * per_page ) >= activity_count # 3 * 11 > 23
					offset_by = ( page - 1 ) * per_page
					self.limit(per_page).offset(offset_by)
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

	def self.activity_count
		first = PublicActivity::Activity
			.where(recipient_id: current_user.id, recipient_type: 'User')
			.count if PublicActivity::Activity
			  .where(recipient_id: current_user.id, recipient_type: 'User').any?
		second = PublicActivity::Activity
		  .where("user_recipients LIKE ':id,%' or user_recipients LIKE '%, :id' or user_recipients LIKE '%, :id,%' or user_recipients = ':id'", id: current_user.id)
		  .count if PublicActivity::Activity
		    .where("user_recipients LIKE ':id,%' or user_recipients LIKE '%, :id' or user_recipients LIKE '%, :id,%' or user_recipients = ':id'", id: current_user.id).any?
		first + second
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







# .order(created_at: :desc)
# .paginate(page: params[:page], per_page: 20)


# Need to get the two sql queries merged together to form a super query for current user activities

# # Place this in the shout controller create action 
# # @shout.create_activity(key: 'shout.shout', owner: @shout.user, parameters{user: @shout.user.followed_users.pluck(:id)})
# get_user_shit = PublicActivity::Activity.where(recipient_id: current_user.id, recipient_type: 'User')
# # the sql SELECT \"activities\".* FROM \"activities\"  WHERE \"activities\".\"recipient_id\" = 1 AND \"activities\".\"trackable_type\" = 'User'
# get_exclusive = PublicActivity::Activity.where("user_recipients LIKE ':id,%' or user_recipients LIKE '%, :id' or user_recipients LIKE '%, :id,%' or user_recipients = ':id'", id: current_user.id)
# # the sql SELECT \"activities\".* FROM \"activities\"  WHERE (user_recipients LIKE '1,%' or user_recipients LIKE '%, 1' or user_recipients LIKE '%, 1,%' or user_recipients = '1')
# @activities = get_user_shit.merge(get_exclusive)