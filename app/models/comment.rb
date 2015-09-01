class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to  :user

  include PublicActivity::Model 
  tracked only: [:create], owner: Proc.new { |controller, model| model.current_user }
end
