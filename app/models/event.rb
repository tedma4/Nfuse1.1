class Event < ActiveRecord::Base
	belongs_to :user  
  validates :user_id, :name, :description, :cover, presence: true
  validates :name, length: {maximum: 50}
  validates :description, length: {maximum: 140}
  has_many :comments, :as=> :commentable
  acts_as_votable

  attr_accessor :content, :cover, :photo_delete#, dependent: :destroy
  has_destroyable_file :cover
  has_attached_file :cover, :styles => { :event_cover => "851x315#" }

  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png" ]


end