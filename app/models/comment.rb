class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  # belongs_to  :user
  # belongs_to  :page
  has_many :comments, as: :commentable
  # include PublicActivity::Model 
  # tracked only: [:create], owner: Proc.new { |controller, model| model.current_user }
  def page
	  return @page if defined?(@page)
	  @page = commentable.is_a?(Page) ? commentable : commentable.page
	end
end
