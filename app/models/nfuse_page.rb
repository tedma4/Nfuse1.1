class NfusePage < ActiveRecord::Base
  has_many :shouts
  belongs_to :user
   
  def self.my_nfuse_page(user_id)
    self.where(user_id: user_id)
  end
  
  def self.nfuse_page_owner(user_id)
    User.find_by id: user_id
  end  
end