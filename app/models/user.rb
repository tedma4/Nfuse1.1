class User < ActiveRecord::Base

  delegate :email, to: :identity
  delegate :user_name, to: :identity

  has_one :identity, dependent: :nullify
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  before_create :create_remember_token
  has_attached_file :avatar, styles: { larger: "280x280#", medium: "300x300#", thumb: "50x50#", followp: "208x208#" }, 
                                default_url: "/assets/:style/default.png"
                                #:url  => "/assets/images/:id/:style/:basename.:extension",
                                #:path => ":rails_root/assets/images/:id/:style/:basename.:extension"

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  validates :first_name, :last_name, presence: true
  #This allows a user to have multiple oauth tokens
  has_many :tokens, dependent: :destroy
  has_many :conversations, :foreign_key => :sender_id
#This sends the email with the password reset token in it
  has_many :shouts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_voter

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
#This generates a password reset token
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
#This validates the password reset token sent to a user
  def validate_tokens!
    tokens.each(&:validate_token!)
  end
#These are the relationship status options a user can choose from
  def rel_stat
    ["I don’t want to say", "Single", "In a relationship", "Engaged", "Married", "It’s complicated", "In an open relationship", "Widowed", "In a domestic partnership", "In a civil union"][self.relationship_status - 1]
  end
#These are the interested in options a user can choose from
  def int_in
    ["Women", "Men", "Women and Men"][self.interested_in - 1]
  end

#These are the looking for options a user can choose from
  def look
    ["Friends", "Dating", "A relationship", "Networking", "Fun"][self.looking_for - 1]
  end

#These are the gender options a user can choose from
  def gender_txt
    ["Not Telling", "Male", "Female"][self.gender - 1]
  end
#This generates a cookie for a user when they log in
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
#This concatinates the user's first and last names
  def full_name
  first_name + " " + last_name
  end
#This turns a user first name entry into a string
  def to_s
    first_name
  end
#This allows a user to search by first name, last name or both  
  def self.search(search)
      where("first_name like :s or last_name like :s or first_name || ' ' || last_name like :s", :s => "%#{search}") 
  end
  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
#<%= link_to image_tag("http://placehold.it/50x50", class: "media-object"), conversation_path(conversation), class: "pull-left" %>

