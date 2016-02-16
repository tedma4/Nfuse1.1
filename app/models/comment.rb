class Comment < ActiveRecord::Base
  
  belongs_to :commentable, :polymorphic => true
  has_ancestry
  belongs_to  :user
  belongs_to  :page
  has_many :comments, as: :commentable, dependent: :destroy
  acts_as_votable
  # belongs_to :commentable, polymorphic: true
  # belongs_to  :user
  # belongs_to  :page
 #  has_many :comments, as: :commentable, dependent: :destroy
 #  # include PublicActivity::Model 
 #  # tracked only: [:create], owner: Proc.new { |controller, model| model.current_user }
  def page
	  return @page if defined?(@page)
	  @page = commentable.is_a?(Page) ? commentable : commentable.page
	end

  has_attached_file :image_upload,
                    :styles => {
                      :thumb => "600x600#",
                      :medium => "300x300#",
                      :small => "160x160#"
                    }
  
  validates_attachment_content_type :image_upload,
                                    :content_type => ["image/jpg", "image/jpeg", "image/png" ], allow_blank:true

  auto_html_for :url do
    html_escape
    image
    youtube(:width => '100%', :height => 225, :autoplay => false)
    vimeo(:width => '100%', :height => 225, :autoplay => false)
    soundcloud
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
end
