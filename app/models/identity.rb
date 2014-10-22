class Identity < OmniAuth::Identity::Models::ActiveRecord
  belongs_to :user
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: {minimum: 6}, allow_blank: true
  validates :conditions, acceptance: true, allow_nil: false, on: :create
  attr_accessor :conditions

  # this is a hook ( callback ) that executes
  # when it sees that create is called.
  before_create do |new_record|
    user = User.create(first_name: new_record.first_name,
                       last_name: new_record.last_name)
    new_record.user = user
  end

  def full_name
  first_name + " " + last_name
  end
#This turns a user first name entry into a string
  def to_s
    first_name
  end
end