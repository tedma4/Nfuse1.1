class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
  #tracked only: [:create], owner: Proc.new{|controller, model| model.current_user }

end
