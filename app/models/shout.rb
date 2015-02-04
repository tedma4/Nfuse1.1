class Shout < ActiveRecord::Base
  belongs_to :user  
  validates :user_id, :content, presence: true
  has_many :comments, :as => :commentable
  acts_as_votable

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
                            :medium => { :geometry => "302x226", :format => 'flv' },
                            :thumb => { :geometry => "100x100#", :format => 'jpg' }
                         }, :processors => [:transcoder]
  # This was my bad.
  # * http://stackoverflow.com/questions/22926614/rails-4-model-is-valid-but-wont-save
  check_file_types = ->(record) {
                  true if (record.is_pic       = !!(record.pic_content_type))
                  true if (record.is_video     = !!(record.snip_file_name))
                  true if (record.is_link      = !!(record.url))
                  true if (record.has_content  = !!(record.content))
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
    youtube(:width => '100%', :height => 225, :autoplay => false)
    vimeo(:width => '100%', :height => 225, :autoplay => false)
    soundcloud
    flickr(:width => '100%', :height => 302)
    ted
    link :target => "_blank", :rel => "nofollow"
    simple_format
   end

  #validate :only_upload_or_url
#
  #private
  #  def only_upload_or_url
  #    if clip.present? and url.present?
  #      errors.add(:clip, "Can not have bot clip and url")
  #      errors.add(:url, "Can not have bot clip and url")
  #      return false
  #    elsif !clip.present? and !url.present?
  #      errors.add(:clip, "Clip and url can not be empty")
  #      errors.add(:url, "Clip and url can not be empty")
  #      return false
  #    else
  #      return true
  #    end
  #  end
#
 end