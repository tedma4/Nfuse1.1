class Conversation < ActiveRecord::Base

  belongs_to :sender,    :foreign_key => :sender_id,    class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy
  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :involving, -> (user) do
    where("conversations.sender_id =? OR conversations.recipient_id =?", user.id, user.id)
  end

  scope :between, -> (sender_id,recipient_id) do
    _sql = "(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)"
    where(_sql, sender_id,recipient_id, recipient_id, sender_id)
  end

  #scope :between, -> (sender_id,recipient_id) do
  #  where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  #end

  def self.find_or_start_convo(params)
    result = between(params[:sender_id], params[:recipient_id])
    return result.first if result.present?
    # below never gets fired if one if found.
    create!(sender_id: params[:sender_id], recipient_id: params[:recipient_id])
  end

end
