class NfusePage < ActiveRecord::Base
  #has_and_belongs_to_many :shouts
  #has_many :shouts, through: :users
  belongs_to :user

  # attr_accessor :url_html
   
  def self.my_nfuse_page(user_id)
    self.where(user_id: user_id)
  end
  
  def self.nfuse_page_owner(user_id)
    User.find_by id: user_id
  end

  def self.build(options)

    nfuse_page = new( social_key: options[:key] || 'nfuse',
                      social_id: options[:id],
                      url: options[:url],
                      owner_id: options[:owner_id],
                      user_id: options[:user_id] )
    nfuse_page.save
    nfuse_page
  end

  def is_pic?
    !url.blank?
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
  
end