class Shout < ActiveRecord::Base
  #include AutoHtml
  require 'paperclip-ffmpeg'
  belongs_to :user  
  validates :user_id, presence: true
  has_many :comments, :as => :commentable
  acts_as_votable
 
  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*\z/i
  before_create :set_content_type
  #validates :url, allow_blank: true#, format: YT_LINK_FORMAT

  attr_accessor :content, :pic, :photo_delete, :snip, :video_delete#, dependent: :destroy
  has_destroyable_file :pic, :snip
  has_attached_file :pic, :styles => { :thumb => "600x600#", :medium => "300x300#", :small => "160x160#"}
 
  validates_attachment_content_type :pic, :content_type => ["image/jpg", "image/jpeg", "image/png" ]
 
  has_attached_file :snip, :styles => {
                           :mobile => {:geometry => "400x300", :format => 'flv', :streaming => true}
                                        }, :processors => [:ffmpeg, :qtfaststart]
 
  def set_content_type
    self.is_video = !self.snip_file_name.nil?
    self.is_pic = !self.pic_file_name.nil?
    self.is_link = !self.url.blank?
    end
 
   def all_votes
     ActsAsVotable::Vote.where(votable_id: self.id)
   end
 
   def like_score
     self.get_likes.size
   end
 
   def dislike_score
     self.get_dislikes.size
   end

   auto_html_for :url do
    html_escape
    image
    youtube(:width => 195, :height => 200, :autoplay => false)
    vimeo(:width => 195, :height => 200, :autoplay => false)
    soundcloud(:width => 195, :height => 200, :autoplay => false)
    flickr(:width => 195, :height => 200, :autoplay => false)
    ted(:width => 195, :height => 200, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
   end

 end