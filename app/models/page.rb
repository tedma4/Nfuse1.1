class Page < ActiveRecord::Base
  is_impressionable :counter_cache => true, :column_name => :page_counter_cache
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, source: :users, through: :relationships
  has_many :comments, as: :commentable, dependent: :destroy
end