class User < ActiveRecord::Base
  include UserOptions
  include Authentication
  # 
  # Associations
  # 
  # (Users that I follow)
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  # (Other users that follow Me)
  has_many :reverse_relationships,
            foreign_key: "followed_id",
            class_name: "Relationship",
            dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :tokens, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id
  has_many :shouts, dependent: :destroy
  has_one  :nfuse_page
  has_many :comments, dependent: :destroy

  # 
  # Callbacks & Macros
  # 
  acts_as_voter

  before_create :downcase_email
  before_create :create_remember_token

  has_attached_file :avatar, styles: { larger: "280x280#", medium: "300x300#", thumb: "50x50#", followp: "512x512#", small: "32x32#" }, 
                                default_url: "default_:style.png"#,
                                # storage: :s3,
                                # s3_host_name: 'aa1cee2z3awja3v.c97qscmi7euu.us-west-1.rds.amazonaws.com',
                                # s3_credentials: 'config/s3.yml'

  has_attached_file :banner, styles: { larger: "851x315#", medium: "300x154#" }, 
                                default_url: "default2_:style.png"
  # 
  # Validations
  # 
  # *images
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :banner, :content_type => ["image/jpg", "image/jpeg", "image/png" ]

  # *names
  #
  # VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/i
  USER_CODE = /\A(?:(4081))\Z/
  VALID_USERNAME_REGEX = %r{\A[a-zA-Z0-9]+.?+_?[a-zA-Z0-9]+\z}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first_name, :last_name, :user_name, presence: true
  validates :user_name, length: { maximum: 20 },
            format: { with: VALID_USERNAME_REGEX },
            uniqueness: {case_sensitive: false }

  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, length: {minimum: 6}, allow_blank: true
  #validates :phone_number, presence: true
  # validates_format_of :phone_number,
  #     :with =>/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/, #or this
  #     :message => "should be a phone number"

  #Because We're paranoid about the ppl who keep signing up. This is our cheap version of security
  validates :intro, presence: true, 
  inclusion: { in: %w(4081),
    message: 'Wrong code, Please try again : )' }
  # returns a relationship object not a User object.
  # belongs in Relationship model.
  # ? methods are meant to return a boolean

  def following?(other_user)
    !!(relationships.find_by(followed_id: other_user.id))
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def total_followers
    followers.count
  end

  def total_likes
    ActsAsVotable::Vote.where(:owner_id => self.id).count 
  end

  def to_param
    user_name
  end

  #This allows a user to search by first name, last name or both  
  def self.search(search)
    if search
      q = "%#{search}%"
      where("first_name like ? or last_name like ? or user_name like ? or (first_name || last_name) like ? or first_name || ' ' || last_name like ?", q, q, q, q, q)
    else
      all
    end
  end

  def self.all_except(other_user)
    result = where.not("id = ?",other_user.id).order("created_at DESC")
    result.nil? ? [] : result
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_remember_token
    self.remember_token = digest(new_remember_token)
  end

end

