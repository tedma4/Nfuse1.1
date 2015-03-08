class NfusePage < ActiveRecord::Base
  has_many :shouts
  belongs_to :user

  delegate :url, :is_pic?, :pic, :url_html , to: :other_shout
   
  def self.my_nfuse_page(user_id)
    self.where(user_id: user_id)
  end
  
  def self.nfuse_page_owner(user_id)
    User.find_by id: user_id
  end

  def other_shout
    @shout = Shout.find(self.shout_id)
  end

  def url_html
    other_shout.url_html
  end

end