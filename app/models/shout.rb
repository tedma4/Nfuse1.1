class Shout < ActiveRecord::Base
	require 'paperclip-ffmpeg'
  has_many :comments, dependent: :destroy
  belongs_to :user  
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  default_scope -> { order('created_at DESC') }
	#attr_accessible :content, :title, :photo, :photo_delete, :video, :video_delete, :dependent => :destroy
	#has_destroyable_file :photo, :video
	has_attached_file :photo, :styles => {  :thumb => "600x600#", :medium => "300x300#", :small => "160x160#"}
  	has_attached_file :video, :styles => {
    :mobile => {:geometry => "400x300", :format => 'ogg', :streaming => true}
  }, :processors => [:ffmpeg, :qtfaststart]


end
