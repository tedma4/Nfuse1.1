class Shout < ActiveRecord::Base
	require 'paperclip-ffmpeg'
  belongs_to :user  
  validates :user_id, presence: true
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  acts_as_votable
  has_attached_file :pic, :styles => {  :thumb => "600x600#", :medium => "300x300#", :small => "160x160#"}
  validates_attachment_content_type :pic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	#attr_accessor :content, :photo, :photo_delete, :video, :video_delete, :dependent => :destroy
	#has_destroyable_file :photo, :video

end

#class ShoutContent < Shout
#  validates :content, presence: true, length: { maximum: 140 }
#end
#
#class PicPost < Shout
#  has_attached_file :pic, :styles => {  :thumb => "600x600#", :medium => "300x300#", :small => "160x160#"}
#end

#class SnipPost < Shout
#  has_attached_file :video, :styles => {
#                            :mobile => {:geometry => "400x300", :format => 'ogg', :streaming => true}
#                                        }, :processors => [:ffmpeg, :qtfaststart]
#end
