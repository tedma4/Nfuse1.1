
class Shout < ActiveRecord::Base
	require 'paperclip-ffmpeg'
  belongs_to :user  
  validates :user_id, presence: true
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  acts_as_votable
  has_attached_file :pic, :styles => {  :thumb => "600x600#", :medium => "300x300#", :small => "160x160#"}
  validates_attachment_content_type :pic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  has_attached_file :snip, :styles => {
                            :mobile => {:geometry => "400x300", :format => 'ogg', :streaming => true}
                                        }, :processors => [:ffmpeg, :qtfaststart]

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
#  has_attached_file :snip, :styles => {
#                            :mobile => {:geometry => "400x300", :format => 'ogg', :streaming => true}
#                                        }, :processors => [:ffmpeg, :qtfaststart]
#end

=begin
  
Here are the posting params. 
Written posts alone are gone. 
Its just uploading images or videos and 
adding a description to those posts and 
the process is like this for the user:
They click the add button and get sent 
to the post page. On the page 
are two upload links. 

One for images and videos. 
When a user chooses the file type 
for the respective link they are then able
to add a 140 char max description of the post.
The description can not be blank. 
When the post is submitted 
it gets sent to the top of the users feed
  
=end


