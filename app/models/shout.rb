class Shout < ActiveRecord::Base
  belongs_to :user 
  #has_and_belongs_to_many :nfuse_pages
  has_many :nfuse_pages, dependent: :destroy
  validates :user_id, :content, presence: true
  has_many :comments, :as => :commentable, dependent: :destroy
  acts_as_votable

  attr_accessor :photo_delete, :video_delete

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
                  !!(record.content    = record.content)
  }

  before_create { |record|
                check_file_types.call(record)
                }

  def all_votes
   ActsAsVotable::Vote.where(votable_id: self.id)
  end

  auto_html_for :url do
    html_escape
    image
    youtube(:width => '100%', :height => 225, :autoplay => false)
    vimeo(:width => '100%', :height => 225, :autoplay => false)
    soundcloud
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def self.my_nfuses(nfuse_page_id)
    self.where(nfuse_page_id: nfuse_page_id)
  end
  
  def self.nfuse_page_owner(nfuse_page_user_id)
    User.find_by id: nfuse_page_user_id
  end

  def reshout_post(sid, uid, oid)
   nf_page = NfusePage.new(shout_id: sid, user_id: uid, owner_id: oid)
   nf_page.save
  end

 end