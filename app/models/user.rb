class User < ActiveRecord::Base
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_attached_file :avatar, styles: { larger: '210x260>', medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/default.png"
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  has_many :tokens, dependent: :destroy

  def validate_tokens!
    tokens.each(&:validate_token!)
  end

  def rel_stat
    ["I don’t want to say", "Single", "In a relationship", "Engaged", "Married", "It’s complicated", "In an open relationship", "Widowed", "In a domestic partnership", "In a civil union"][self.relationship_status - 1]
  end

  def int_in
    ["Women", "Men", "Women and Men"][self.interested_in - 1]
  end

  def look
    ["Friends", "Dating", "A relationship", "Networking", "Fun"][self.looking_for - 1]
  end

  def gender_txt
    ["Not Telling", "Male", "Female"][self.gender - 1]
  end

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

  def full_name
  first_name + " " + last_name
  end

  def to_s
    first_name
  end

  def self.search(query)
    where("first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%") 
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
