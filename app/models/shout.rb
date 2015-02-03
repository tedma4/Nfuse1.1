# require 'paperclip-ffmpeg'
class Shout < ActiveRecord::Base
  #include AutoHtml
  belongs_to :user  
  validates :user_id, :content, presence: true
  has_many :comments, :as => :commentable
  acts_as_votable

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*\z/i

  attr_accessor :content, :photo_delete, :video_delete

  has_destroyable_file :pic, :snip

  has_attached_file :pic, 
                    :styles => { 
                      :thumb => "600x600#",
                      :medium => "300x300#",
                      :small => "160x160#"
                    }

  validates_attachment_content_type :pic,
                                    :content_type => ["image/jpg", "image/jpeg", "image/png" ]

  has_attached_file :snip, :styles => {
                           :mobile => {:geometry => "400x300", :format => 'flv', :streaming => true}
                           }, :processors => [:ffmpeg, :qtfaststart]

  # This was my bad.
  # * http://stackoverflow.com/questions/22926614/rails-4-model-is-valid-but-wont-save
  check_file_types = ->(record) {
                  true if (record.is_pic   = !!(record.pic_content_type))
                  true if (record.is_video = !!(record.snip_file_name))
                  true if (record.is_link  = !!(record.url))
  }

  before_create { |record|
                check_file_types.call(record)
                }

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
    youtube(:width => 302, :height => 225, :autoplay => false)
    vimeo(:width => 302, :height => 225, :autoplay => false)
    soundcloud
    flickr(:width => 302, :height => 225, :autoplay => false)
    ted(:width => 302, :height => 225, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
   end

 end