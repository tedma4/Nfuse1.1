class User < ActiveRecord::Base
  include UserOptions
  # 
  # Relationships
  # 
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :tokens, dependent: :destroy
  has_many :conversations, :foreign_key => :sender_id
  has_many :shouts 
  has_many :comments

  # 
  # Callbacks & Macros
  # 
  has_secure_password
  acts_as_voter

  before_create :downcase_email
  before_create :create_remember_token

  has_attached_file :avatar, styles: { larger: "280x280#", medium: "300x300#", thumb: "50x50#", followp: "208x208#" }, 
                                default_url: "default.png"
                                #:url  => "/assets/images/:id/:style/:basename.:extension",
                                #:path => ":rails_root/assets/images/:id/:style/:basename.:extension"

  has_attached_file :banner, styles: { larger: "851x315#", medium: "300x300#" }, 
                                default_url: "default2.png"
                                #:url  => "/assets/images/:id/:style/:basename.:extension",
                                #:path => ":rails_root/assets/images/:id/:style/:basename.:extension"

  # 
  # Validations
  # 
  # *images
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :banner, :content_type => ["image/jpg", "image/jpeg", "image/png" ]
  # *names
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, :last_name, presence: true
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, length: {minimum: 6}, allow_blank: true

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

#This allows a user to search by first name, last name or both  
  def self.search(search)
      where("first_name like :s or last_name like :s or first_name || ' ' || last_name like :s", :s => "%#{search}") 
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end

