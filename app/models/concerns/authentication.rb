module Authentication
  extend ActiveSupport::Concern

  included do
    has_secure_password
  end

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

  def new_remember_token
    SecureRandom.urlsafe_base64
  end

  def digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

end