class Shout < ActiveRecord::Base
	require 'paperclip-ffmpeg'
  belongs_to :user  
  validates :user_id, presence: true
  has_many :comments, :as => :commentable
  before_create :set_content_type
  acts_as_votable

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*\z/i
  validates :link, format: YT_LINK_FORMAT, allow_blank: true

  attr_accessor :content, :pic, :photo_delete, :snip, :video_delete#, dependent: :destroy
  has_destroyable_file :pic, :snip
  has_attached_file :pic, :styles => { :thumb => "600x600#", :medium => "300x300#", :small => "160x160#"}

  validates_attachment_content_type :pic, :content_type => ["image/jpg", "image/jpeg", "image/png" ]

  has_attached_file :snip, :styles => {
                            :mobile => {:geometry => "400x300", :format => 'ogg', :streaming => true}
                                        }, :processors => [:ffmpeg, :qtfaststart]

  def set_content_type
    self.is_video = !self.snip_file_name.nil?
    self.is_link = !self.link.nil?

    # parse link
    if self.is_link
      uid = link.match(YT_LINK_FORMAT)
      self.uid = uid[2] if uid && uid[2]
      if self.uid.to_s.length != 11
        self.errors.add(:link, 'is invalid.')
        false
      elsif Shout.where(uid: self.uid).any?
        self.errors.add(:link, 'is not unique.')
        false
      else
        get_additional_info
      end
    end
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

  private

  def get_additional_info
    begin
      client = YouTubeIt::OAuth2Client.new(dev_key: 'AI39si5tETPAcvSl00_0nrLcd2sC7dfDddSCqYtRVPE7pBwf1Ajf5SusGyLhrd3KGT7TqUuHJDBtI6GYxDgfVQK9Jkk0haSOKg')
      video = client.video_by(uid)
      self.title = video.title
      self.duration = parse_duration(video.duration)
      self.author = video.author.name
    rescue
      self.title = '' ; self.duration = '00:00:00' ; self.author = ''
    end
  end

  def parse_duration(d)
    hr = (d / 3600).floor
    min = ((d - (hr * 3600)) / 60).floor
    sec = (d - (hr * 3600) - (min * 60)).floor

    hr = '0' + hr.to_s if hr.to_i < 10
    min = '0' + min.to_s if min.to_i < 10
    sec = '0' + sec.to_s if sec.to_i < 10

    hr.to_s + ':' + min.to_s + ':' + sec.to_s
  end
end
